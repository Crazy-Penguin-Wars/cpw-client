package tuxwars.battle.gameobjects
{
   import com.citrusengine.physics.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import org.odefu.flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.data.follower.*;
   import tuxwars.battle.data.particles.*;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.rewards.RewardsHandler;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.battle.world.loader.LevelPowerUpResult;
   import tuxwars.battle.world.loader.PowerUpObjectPhysics;
   import tuxwars.challenges.events.*;
   import tuxwars.net.*;
   
   public class PowerUpGameObject extends PhysicsEmissionGameObject
   {
      private var exportBase:String;
      
      private var _toughness:int;
      
      private var powerUpUsed:Boolean;
      
      private var world:TuxWorld;
      
      private var resultObject:LevelPowerUpResult;
      
      private var useEffect:String;
      
      private var particlesShown:Boolean;
      
      public function PowerUpGameObject(param1:PowerUpGameObjectDef, param2:TuxWarsGame)
      {
         var _loc3_:* = undefined;
         super(param1,param2);
         this.exportBase = param1.graphics.export;
         this.resultObject = param1.powerUpResult;
         this.useEffect = param1.powerUp.getPowerUpObjectPhysics().getUseEffect();
         this.toughness = 10;
         this.world = (this.game as TuxWarsGame).tuxWorld;
         setCollisionFilterValues(PhysicsCollisionCategories.Get("POWER_UP"),-1);
         if(param1.followers)
         {
            for each(_loc3_ in param1.followers)
            {
               Followers.createFollower(_loc3_.id,body.position,(this.game as TuxWarsGame).tuxWorld.physicsWorld,playerAttackValueStat,playerBoosterStats,this,this.tagger);
            }
         }
      }
      
      override public function dispose() : void
      {
         this.world = null;
         if(this.resultObject)
         {
            this.resultObject.dispose();
            this.resultObject = null;
         }
         super.dispose();
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         var _loc2_:ParticleReference = null;
         super.physicsUpdate(param1);
         if(!body)
         {
            return;
         }
         if(Boolean(this.powerUpUsed) && !this._markedForRemoval)
         {
            LogUtils.log("PowerUp: " + this._id + " picked up",this);
            if(!this.particlesShown)
            {
               _loc2_ = Particles.getParticlesReference(this.useEffect);
               if(Boolean(_loc2_) && Boolean(this.world))
               {
                  this.world.addParticle(_loc2_,location.x,location.y);
               }
               this.particlesShown = true;
            }
            if(!emissions || emissions.length == 0)
            {
               markForRemoval();
            }
         }
      }
      
      override public function triggerEmission() : void
      {
         this.applyEmissions();
      }
      
      override public function get tagger() : Tagger
      {
         return !!super.tagger ? super.tagger : new Tagger(this);
      }
      
      public function get toughness() : int
      {
         return this._toughness;
      }
      
      public function set toughness(param1:int) : void
      {
         this._toughness = param1;
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         switch(param1)
         {
            case "object":
            case "powerup":
               return true;
            default:
               return super.affectsGameObject(param1,param2);
         }
      }
      
      override protected function updateGraphics() : void
      {
         if(body)
         {
            this.displayObject.x = bodyLocation.x;
            this.displayObject.y = bodyLocation.y;
            if(allowDisplayObjectRotation && body.allowRotation)
            {
               this.displayObject.rotation = body.rotation + 3.141592653589793;
            }
         }
      }
      
      override protected function createBody(param1:PhysicsGameObjectDef) : void
      {
         var _loc2_:PowerUpGameObjectDef = param1 as PowerUpGameObjectDef;
         var _loc3_:PowerUpObjectPhysics = _loc2_.powerUp.getPowerUpObjectPhysics();
         body = _loc3_.getBodyManager().createBody(_loc3_.getFixtureName(),param1.space,_loc3_.getLocation(),this,_loc3_.getAngle(),false);
      }
      
      override protected function loadGraphics() : void
      {
         super.loadGraphics();
         OdefuMovieClip(!!this.graphics ? this.displayObject.getChildByName(this.graphics.export) : null).loop = false;
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         var _loc3_:PlayerGameObject = null;
         if(!this.powerUpUsed)
         {
            location = findFirstCollisionPosition(param2);
            if(location)
            {
               MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,param1.userData.gameObject,location.copy()));
               _loc3_ = param1.userData.gameObject as PlayerGameObject;
               if(_loc3_)
               {
                  this.applyHealEffect(_loc3_);
                  this.applyScoreEffect(_loc3_);
                  this.applyIngameMoneyEffect(_loc3_);
                  this.applyItemsEffect(_loc3_);
                  this.applyEmissions();
                  this.powerUpUsed = true;
                  MessageCenter.sendEvent(new PowerUpPickedUpMessage(_loc3_,this));
               }
            }
         }
      }
      
      private function applyEmissions() : void
      {
         var _loc1_:* = undefined;
         if(Boolean(emissions) && readyToEmit())
         {
            for each(_loc1_ in emissions)
            {
               MessageCenter.sendEvent(new EmissionMessage(this,null));
            }
         }
      }
      
      private function applyItemsEffect(param1:PlayerGameObject) : void
      {
         var _loc2_:Array = this.resultObject.resultItems;
         if(_loc2_ && _loc2_.length > 0 && Boolean(param1))
         {
            this.giveItems(_loc2_,param1,this.resultObject.areResultItemsRandomized());
         }
      }
      
      private function giveItems(param1:Array, param2:PlayerGameObject, param3:Boolean) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:TextEffect = null;
         var _loc7_:RewardsHandler = param2.rewardsHandler;
         if(_loc7_)
         {
            if(param3)
            {
               LogUtils.log("Call to random giveItems()",this,0,"Random",false,false,false);
               _loc4_ = param1[BattleManager.getRandom().integer(0,param1.length)];
               _loc5_ = int(this.getItemAmount());
               CRMService.sendEvent("Economy","Earn_Item","Get_powerup",_loc4_);
               _loc7_.addLootItemFor(this,_loc4_,_loc5_);
            }
            else
            {
               for each(_loc4_ in param1)
               {
                  _loc5_ = int(this.getItemAmount());
                  CRMService.sendEvent("Economy","Earn_Item","Get_powerup",_loc4_);
                  _loc7_.addLootItemFor(this,_loc4_,_loc5_);
               }
            }
            _loc6_ = this.world.addTextEffect(3,null,location.x,location.y,false);
            this.world.ignoreLevelSizeScale(_loc6_.movieClip,true,false);
         }
      }
      
      private function applyIngameMoneyEffect(param1:PlayerGameObject) : void
      {
         if(this.resultObject.resultCoins > 0)
         {
            CRMService.sendEvent("Economy","Earn GC","Get_powerup","Earn GC",null,this.resultObject.resultCoins);
            param1.rewardsHandler.addInGameMoneyGained(this.resultObject.resultCoins,this);
         }
      }
      
      private function applyScoreEffect(param1:PlayerGameObject) : void
      {
         if(this.resultObject.resultPoints > 0)
         {
            CRMService.sendEvent("Economy","Earn_Score","Get_powerup","Earn_Score",null,this.resultObject.resultPoints);
            param1.addScore("PowerUp_" + this._name,this.resultObject.resultPoints);
         }
      }
      
      private function applyHealEffect(param1:PlayerGameObject) : void
      {
         var _loc2_:TextEffect = null;
         if(this.resultObject.resultHeal > 0)
         {
            CRMService.sendEvent("Economy","Earn_Healing","Get_powerup","Earn_Score",null,-this.resultObject.resultHeal);
            param1.reduceHitPoints(new Damage(this,"PowerUpHeal",this._uniqueId,-this.resultObject.resultHeal,location,null));
            _loc2_ = this.world.addTextEffect(1,this.resultObject.resultHeal.toString(),location.x,location.y,false);
            this.world.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
         }
      }
      
      private function getItemAmount() : int
      {
         LogUtils.log("Call to random getItemAmount()",this,0,"Random",false,false,false);
         return !!this.resultObject.areResultItemsAmountRandomized() ? int(BattleManager.getRandom().integer(1,this.resultObject.resultItemAmount + 1)) : int(this.resultObject.resultItemAmount);
      }
      
      override public function get linearVelocity() : Vec2
      {
         return !!body ? body.velocity.copy() : null;
      }
   }
}

