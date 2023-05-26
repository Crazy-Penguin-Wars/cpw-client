package tuxwars.battle.gameobjects
{
   import com.citrusengine.physics.PhysicsCollisionCategories;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import org.odefu.flash.display.OdefuMovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.follower.Followers;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.data.particles.Particles;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.events.PowerUpPickedUpMessage;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.rewards.RewardsHandler;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.battle.world.loader.LevelPowerUpResult;
   import tuxwars.battle.world.loader.PowerUpObjectPhysics;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.net.CRMService;
   
   public class PowerUpGameObject extends PhysicsEmissionGameObject
   {
       
      
      private var exportBase:String;
      
      private var _toughness:int;
      
      private var powerUpUsed:Boolean;
      
      private var world:TuxWorld;
      
      private var resultObject:LevelPowerUpResult;
      
      private var useEffect:String;
      
      private var particlesShown:Boolean;
      
      public function PowerUpGameObject(def:PowerUpGameObjectDef, game:TuxWarsGame)
      {
         super(def,game);
         exportBase = def.graphics.export;
         resultObject = def.powerUpResult;
         useEffect = def.powerUp.getPowerUpObjectPhysics().getUseEffect();
         toughness = 10;
         world = (this.game as tuxwars.TuxWarsGame).tuxWorld;
         setCollisionFilterValues(PhysicsCollisionCategories.Get("POWER_UP"),-1);
         if(def.followers)
         {
            for each(var r in def.followers)
            {
               Followers.createFollower(r.id,body.position,(this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld,playerAttackValueStat,playerBoosterStats,this,tagger);
            }
         }
      }
      
      override public function dispose() : void
      {
         world = null;
         if(resultObject)
         {
            resultObject.dispose();
            resultObject = null;
         }
         super.dispose();
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         var _loc2_:* = null;
         super.physicsUpdate(deltaTime);
         if(!body)
         {
            return;
         }
         if(powerUpUsed && !this._markedForRemoval)
         {
            LogUtils.log("PowerUp: " + this._id + " picked up",this);
            if(!particlesShown)
            {
               _loc2_ = Particles.getParticlesReference(useEffect);
               if(_loc2_ && world)
               {
                  world.addParticle(_loc2_,location.x,location.y);
               }
               particlesShown = true;
            }
            if(!emissions || emissions.length == 0)
            {
               markForRemoval();
            }
         }
      }
      
      override public function triggerEmission() : void
      {
         applyEmissions();
      }
      
      override public function get tagger() : Tagger
      {
         return !!super.tagger ? super.tagger : new Tagger(this);
      }
      
      public function get toughness() : int
      {
         return _toughness;
      }
      
      public function set toughness(value:int) : void
      {
         _toughness = value;
      }
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         switch(type)
         {
            case "object":
               break;
            case "powerup":
               break;
            default:
               return super.affectsGameObject(type,taggerGameObject);
         }
         return true;
      }
      
      override protected function updateGraphics() : void
      {
         if(body)
         {
            this._displayObject.x = bodyLocation.x;
            this._displayObject.y = bodyLocation.y;
            if(allowDisplayObjectRotation && body.allowRotation)
            {
               this._displayObject.rotation = body.rotation + 3.141592653589793;
            }
         }
      }
      
      override protected function createBody(def:PhysicsGameObjectDef) : void
      {
         var _loc3_:PowerUpGameObjectDef = def as PowerUpGameObjectDef;
         var _loc2_:PowerUpObjectPhysics = _loc3_.powerUp.getPowerUpObjectPhysics();
         body = _loc2_.getBodyManager().createBody(_loc2_.getFixtureName(),def.space,_loc2_.getLocation(),this,_loc2_.getAngle(),false);
      }
      
      override protected function loadGraphics() : void
      {
         super.loadGraphics();
         OdefuMovieClip(!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null).loop = false;
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         var _loc3_:* = null;
         if(!powerUpUsed)
         {
            location = findFirstCollisionPosition(arbiterList);
            if(location)
            {
               MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,otherBody.userData.gameObject,location.copy()));
               _loc3_ = otherBody.userData.gameObject as PlayerGameObject;
               if(_loc3_)
               {
                  applyHealEffect(_loc3_);
                  applyScoreEffect(_loc3_);
                  applyIngameMoneyEffect(_loc3_);
                  applyItemsEffect(_loc3_);
                  applyEmissions();
                  powerUpUsed = true;
                  MessageCenter.sendEvent(new PowerUpPickedUpMessage(_loc3_,this));
               }
            }
         }
      }
      
      private function applyEmissions() : void
      {
         if(emissions && readyToEmit())
         {
            for each(var emission in emissions)
            {
               MessageCenter.sendEvent(new EmissionMessage(this,null));
            }
         }
      }
      
      private function applyItemsEffect(targetCharacter:PlayerGameObject) : void
      {
         var _loc2_:Array = resultObject.resultItems;
         if(_loc2_ && _loc2_.length > 0 && targetCharacter)
         {
            giveItems(_loc2_,targetCharacter,resultObject.areResultItemsRandomized());
         }
      }
      
      private function giveItems(resultItemsArray:Array, targetCharacter:PlayerGameObject, giveRandomItem:Boolean) : void
      {
         var itemId:* = null;
         var itemAmount:int = 0;
         var _loc6_:* = null;
         var _loc5_:RewardsHandler = targetCharacter.rewardsHandler;
         if(_loc5_)
         {
            if(giveRandomItem)
            {
               LogUtils.log("Call to random giveItems()",this,0,"Random",false,false,false);
               itemId = resultItemsArray[BattleManager.getRandom().integer(0,resultItemsArray.length)];
               itemAmount = getItemAmount();
               CRMService.sendEvent("Economy","Earn_Item","Get_powerup",itemId);
               _loc5_.addLootItemFor(this,itemId,itemAmount);
            }
            else
            {
               for each(itemId in resultItemsArray)
               {
                  itemAmount = getItemAmount();
                  CRMService.sendEvent("Economy","Earn_Item","Get_powerup",itemId);
                  _loc5_.addLootItemFor(this,itemId,itemAmount);
               }
            }
            _loc6_ = world.addTextEffect(3,null,location.x,location.y,false);
            world.ignoreLevelSizeScale(_loc6_.movieClip,true,false);
         }
      }
      
      private function applyIngameMoneyEffect(targetCharacter:PlayerGameObject) : void
      {
         if(resultObject.resultCoins > 0)
         {
            CRMService.sendEvent("Economy","Earn GC","Get_powerup","Earn GC",null,resultObject.resultCoins);
            targetCharacter.rewardsHandler.addInGameMoneyGained(resultObject.resultCoins,this);
         }
      }
      
      private function applyScoreEffect(targetCharacter:PlayerGameObject) : void
      {
         if(resultObject.resultPoints > 0)
         {
            CRMService.sendEvent("Economy","Earn_Score","Get_powerup","Earn_Score",null,resultObject.resultPoints);
            targetCharacter.addScore("PowerUp_" + this._name,resultObject.resultPoints);
         }
      }
      
      private function applyHealEffect(targetCharacter:PlayerGameObject) : void
      {
         var _loc2_:* = null;
         if(resultObject.resultHeal > 0)
         {
            CRMService.sendEvent("Economy","Earn_Healing","Get_powerup","Earn_Score",null,-resultObject.resultHeal);
            targetCharacter.reduceHitPoints(new Damage(this,"PowerUpHeal",this._uniqueId,-resultObject.resultHeal,location,null));
            _loc2_ = world.addTextEffect(1,resultObject.resultHeal.toString(),location.x,location.y,false);
            world.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
         }
      }
      
      private function getItemAmount() : int
      {
         LogUtils.log("Call to random getItemAmount()",this,0,"Random",false,false,false);
         return resultObject.areResultItemsAmountRandomized() ? BattleManager.getRandom().integer(1,resultObject.resultItemAmount + 1) : resultObject.resultItemAmount;
      }
      
      override public function get linearVelocity() : Vec2
      {
         return !!body ? body.velocity.copy() : null;
      }
   }
}
