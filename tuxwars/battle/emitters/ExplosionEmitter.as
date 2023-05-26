package tuxwars.battle.emitters
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.modifier.StatModifier;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyType;
   import no.olog.utilfunctions.assert;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.explosions.ExplosionData;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.follower.Followers;
   import tuxwars.battle.effects.FlashEffect;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.events.FireEmissionMessage;
   import tuxwars.battle.explosions.Explosion;
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.EmissionSpawn;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.battle.utils.DamageUtil;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   import tuxwars.items.references.EmissionExplosionReference;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.player.reports.events.ReportExplosionMessage;
   
   public class ExplosionEmitter
   {
      
      public static const EXPLOSION_EMITTER:String = "ExplosionEmitter";
      
      private static var _instance:ExplosionEmitter;
       
      
      private var tuxGame:TuxWarsGame;
      
      public function ExplosionEmitter()
      {
         super();
      }
      
      public static function get instance() : ExplosionEmitter
      {
         if(!_instance)
         {
            _instance = new ExplosionEmitter();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         _instance = null;
         tuxGame = null;
         ExplosionPreCalculationsWrapper.disposeWorld();
      }
      
      public function addListeners() : void
      {
         MessageCenter.addListener("ExplosionEmitter",explode);
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
      }
      
      public function removeListeners() : void
      {
         MessageCenter.removeListener("ExplosionEmitter",explode);
      }
      
      private function explode(msg:FireEmissionMessage) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var locationPoint:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc18_:* = null;
         var _loc13_:* = null;
         var _loc24_:* = null;
         var _loc6_:* = null;
         var _loc23_:* = undefined;
         var _loc22_:* = null;
         var _loc9_:* = null;
         var _loc11_:* = null;
         if(Config.isDev())
         {
            assert("Expected an explosion: " + msg.emissionReference.id + " specialType: " + msg.emissionReference.specialType,true,msg.emissionReference.specialType == "ExplosionEmitter");
         }
         var _loc14_:Emission = msg.emissionObject;
         var _loc15_:PhysicsGameObject = _loc14_ as PhysicsGameObject;
         if(_loc15_)
         {
            if(_loc15_._hasHPs && _loc15_.isDeadHP())
            {
               LogUtils.log("Trying to blow up an already destroyed game object: " + _loc15_.shortName,this,2,"Emission");
               return;
            }
            _loc5_ = _loc15_ as PlayerGameObject;
            if(_loc5_ && (_loc5_.isDead() || _loc5_.isSpawning()))
            {
               LogUtils.log("Trying to blow up a dead player: " + _loc5_.shortName,this,2,"Emission");
               return;
            }
         }
         if(_loc14_ && !_loc14_.tagger)
         {
            LogUtils.log("Tagger is null, this should not be!","ExplosionEmitter",2,"Emitter",Config.isDev(),false,Config.isDev());
            _loc14_.setEmittingDone();
            return;
         }
         if(!_loc14_.location)
         {
            LogUtils.log("Explosion location is null, skipping. (id:" + _loc14_.id + ")(uid:" + _loc14_.uniqueId + ")",this,1,"Emitter",Config.isDev(),false,false);
            _loc14_.setEmittingDone();
            return;
         }
         LogUtils.log("Explosion: " + _loc14_ + " stepTime: " + tuxGame.tuxWorld.physicsWorld.stepCount,this,0,"Emitter",false,false,false);
         var _loc20_:TuxWorld = tuxGame.tuxWorld;
         var _loc7_:PlayerGameObject = !!_loc14_.tagger ? _loc14_.tagger.gameObject as PlayerGameObject : null;
         var _loc16_:EmissionReference = msg.emissionReference;
         var _loc19_:Object = _loc14_.getEmissionsParams("Params");
         var _loc17_:Vec2 = EmitterUtils.getFiringDirection(_loc14_,_loc16_,BattleManager.getRandom(),_loc19_ != null && _loc19_.dir != null ? _loc19_.dir : null);
         if(_loc17_.length != 0)
         {
            _loc17_.normalise();
         }
         var _loc10_:int = msg.currentCount;
         var _loc8_:Vec2 = EmitterUtils.getModifiedFiringDirection(_loc7_,_loc16_,null,_loc17_,msg.maxCount,_loc10_,BattleManager.getRandom());
         _loc17_.dispose();
         if(_loc8_)
         {
            _loc3_ = msg.emissionReference;
            locationPoint = _loc14_.location;
            EmitterUtils.offsetLocation(_loc3_,_loc8_,_loc10_,BattleManager.getRandom(),null,locationPoint);
            _loc2_ = EmissionExplosionReference.get(_loc3_.specialEffect);
            _loc4_ = _loc2_.getExplosionData();
            _loc18_ = new Explosion(_loc4_.id,_loc4_.attack,_loc4_.impulse,_loc4_.impulseRadius,_loc4_.damageRadius,locationPoint,_loc4_.explosionShape,_loc4_.particleEffect,_loc14_.tagger,_loc4_.getEmissions(),_loc14_.playerAttackValueStat,_loc14_.playerBoosterStats,_loc4_.simpleScript,_loc4_.simpleScriptEveryTarget,_loc4_.shakeEffectTime,_loc4_.shakeEffectStrength,_loc4_.flash);
            _loc18_.soundId = _loc3_.soundID;
            EmitterUtils.copyParams(_loc14_,_loc18_,_loc8_);
            EmitterUtils.handleBoosters(_loc18_,_loc14_,_loc7_);
            LogUtils.log(_loc14_.id + " exploding " + _loc18_.id + " at loc: " + locationPoint + ", stepTime: " + tuxGame.tuxWorld.physicsWorld.stepCount,this,0,"Emitter",false,false,false);
            if(!_loc7_)
            {
               LogUtils.log("No firing player!",this,1,"Emitter",false,false,false);
            }
            _loc13_ = _loc14_.getEmissionData(_loc3_,"DamageList");
            handleDamage(_loc18_,_loc20_,locationPoint,_loc7_,_loc14_,_loc13_,_loc2_,msg.emissionReference);
            _loc24_ = _loc14_.getEmissionData(_loc3_,"ImpulseList");
            handleImpulse(_loc18_,_loc20_,locationPoint,_loc7_,_loc24_);
            _loc6_ = _loc14_.getEmissionData(_loc3_,"TerrainList");
            handleTerrain(_loc18_,_loc20_,locationPoint,_loc7_,_loc6_);
            if(!_loc18_.simpleScriptEveryTarget)
            {
               handleScript(_loc18_,null);
            }
            MessageCenter.sendEvent(new EmissionMessage(_loc18_,msg.playerId));
            _loc20_.addCameraShake(_loc18_.getShakeTime(),_loc18_.getShakeStrength());
            if(_loc18_.flash)
            {
               FlashEffect.execute();
            }
            _loc14_.setEmissionData(_loc3_,"Handled",true);
            if(!msg.emissionObject.hasEmissionData(msg.emissionReference,"BoosterExplosion") || !msg.emissionObject.getEmissionData(msg.emissionReference,"BoosterExplosion"))
            {
               _loc23_ = generateExplosionEmissions(_loc14_);
               for each(var boostEmission in _loc23_)
               {
                  _loc22_ = EmissionExplosionReference.get(boostEmission.specialEffect);
                  _loc9_ = _loc22_.getExplosionData();
                  _loc11_ = new Explosion(_loc9_.id,_loc9_.attack,_loc9_.impulse,_loc9_.impulseRadius,_loc9_.damageRadius,locationPoint,_loc9_.explosionShape,_loc9_.particleEffect,_loc14_.tagger,[boostEmission],_loc14_.playerAttackValueStat,_loc14_.playerBoosterStats,_loc9_.simpleScript,_loc9_.simpleScriptEveryTarget,_loc9_.shakeEffectTime,_loc9_.shakeEffectStrength,_loc9_.flash);
                  _loc11_.setEmissionData(boostEmission,"BoosterExplosion",true);
                  MessageCenter.sendEvent(new EmissionMessage(new EmissionSpawn(_loc11_,locationPoint,_loc14_.tagger),msg.playerId));
               }
            }
         }
         tuxGame.battleState.emissionTracker.postProcessEmission(_loc14_);
      }
      
      private function handleImpulse(explosion:Explosion, world:TuxWorld, locationPoint:Vec2, firingPlayer:PlayerGameObject, affectedObjects:Array) : void
      {
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc10_:* = null;
         var _loc8_:* = null;
         var hitVectorData:* = null;
         if(affectedObjects && affectedObjects.length > 0)
         {
            LogUtils.log("Explosion: " + explosion.id + " objects in impulse radius: " + affectedObjects.length,this,0,"Emitter",false,false,false);
            for each(var affectedObjectId in affectedObjects)
            {
               var _loc12_:* = tuxGame.tuxWorld;
               _loc11_ = _loc12_._gameObjects.findGameObjectByUniqueId(affectedObjectId) as PhysicsGameObject;
               if(!_loc11_)
               {
                  LogUtils.log("Couldn\'t find game object with id: " + affectedObjectId,this,3,"ErrorLogging",true,false,false);
               }
               else if(_loc11_.body)
               {
                  LogUtils.addDebugLine("HitImpulseRadius",_loc11_.shortName + " was inside impulse radius.");
                  _loc7_ = _loc11_.body;
                  if(_loc7_.type != BodyType.STATIC)
                  {
                     _loc10_ = _loc11_.bodyLocation.copy();
                     _loc8_ = _loc10_.sub(locationPoint);
                     hitVectorData = "initial hitVector: " + _loc8_ + ", initial body loc: " + _loc10_;
                     if(_loc8_.length != 0)
                     {
                        _loc8_.normalise();
                     }
                     if(isNaN(_loc8_.x) && isNaN(_loc8_.y))
                     {
                        _loc8_.x = 0;
                        _loc8_.y = 0;
                     }
                     hitVectorData += ", normalized hitVector: " + _loc8_;
                     _loc8_.length = DamageUtil.scaleValueAccordingToDistance(explosion.impulseRadius,explosion.impulse,locationPoint,_loc10_,_loc11_,explosion,"impulse");
                     hitVectorData += ",  multiplied hitVector: " + _loc8_;
                     _loc7_.applyImpulse(_loc8_);
                     LogUtils.log("ExplosionEmitter impulse " + hitVectorData + ", final hitVector: " + _loc8_ + ", final body loc: " + _loc10_ + " stepTime: " + tuxGame.tuxWorld.physicsWorld.stepCount,this,0,"Emitter",false,false,false);
                  }
                  _loc11_.handleExplosionImpulse(locationPoint,firingPlayer);
               }
            }
         }
      }
      
      private function handleDamage(explosion:Explosion, world:TuxWorld, locationPoint:Vec2, firingPlayer:PlayerGameObject, emissionObject:Emission, affectedObjects:Array, emitExplosionRef:EmissionExplosionReference, emissionReference:EmissionReference) : void
      {
         var _loc14_:* = null;
         var _loc11_:* = null;
         var _loc9_:* = null;
         var _loc12_:int = 0;
         world.addParticle(explosion.particleEffect,locationPoint.x,locationPoint.y);
         var _loc13_:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
         var _loc10_:Vector.<int> = new Vector.<int>();
         if(affectedObjects && affectedObjects.length > 0)
         {
            LogUtils.log("Explosion: " + explosion.id + " objects in damage radius: " + affectedObjects.length,this,1,"Emitter",false,false,false);
            for each(var affectedObjectId in affectedObjects)
            {
               var _loc17_:* = tuxGame.tuxWorld;
               _loc14_ = _loc17_._gameObjects.findGameObjectByUniqueId(affectedObjectId) as PhysicsGameObject;
               if(!_loc14_)
               {
                  LogUtils.log("Couldn\'t find game object with id: " + affectedObjectId,this,3,"ErrorLogging",true,false,false);
               }
               else if(_loc14_.body)
               {
                  LogUtils.addDebugLine("HitDamageRadius",_loc14_.shortName + " was inside damage radius.");
                  _loc11_ = _loc14_.bodyLocation.copy();
                  if(!(_loc14_ is TerrainGameObject) || _loc14_ is TerrainGameObject && (_loc14_ as TerrainGameObject).isDynamic())
                  {
                     if(emissionReference && emissionReference.followers)
                     {
                        for each(var fod in emissionReference.followers)
                        {
                           _loc9_ = Followers.createFollower(fod.id,_loc11_,world.physicsWorld,emissionObject.playerAttackValueStat,emissionObject.playerBoosterStats,_loc14_,emissionObject.tagger);
                        }
                     }
                  }
                  _loc12_ = DamageUtil.damageRecieved(explosion.attackerStat,emissionObject,_loc14_,calculateExplosionDamageRadius(emissionObject,explosion.damageRadius),locationPoint,_loc11_);
                  if(explosion.simpleScriptEveryTarget)
                  {
                     handleScript(explosion,new SimpleScriptParams(_loc14_,firingPlayer));
                  }
                  if(_loc12_ != 0)
                  {
                     _loc14_.handleExplosionDamage(new Damage(emissionObject,explosion.id,explosion.uniqueId,_loc12_,locationPoint,firingPlayer));
                  }
                  _loc13_.push(_loc14_);
                  _loc10_.push(_loc12_);
               }
            }
            if(firingPlayer)
            {
               MessageCenter.sendEvent(new ReportExplosionMessage(firingPlayer,_loc13_,_loc10_));
            }
         }
         if(firingPlayer)
         {
            LogUtils.log("Sending ChallengeAmmoHitMessage","ExplosionEmitter",0,"Challenges",false,false,false);
            MessageCenter.sendEvent(new ChallengeAmmoHitMessage(emissionObject,emissionReference,emitExplosionRef,_loc13_,firingPlayer,_loc10_));
         }
      }
      
      private function addAttackModifiers(damageModifierStat:Stat, explosion:Explosion) : void
      {
         if(damageModifierStat != null && damageModifierStat.getModifiers().length > 0)
         {
            LogUtils.log("Found attack stat boost: " + damageModifierStat,this,0,"Stats",false,false,false);
            for each(var modifier in damageModifierStat.getModifiers())
            {
               explosion.attackerStat.addModifier(modifier);
               LogUtils.log("Damage explosion modified with: " + modifier.getId(),null,0,"DamageModify",false,false,false);
            }
         }
      }
      
      private function handleTerrain(explosion:Explosion, world:TuxWorld, locationPoint:Vec2, firingPlayer:PlayerGameObject, affectedObjects:Array) : void
      {
         var _loc7_:* = null;
         if(affectedObjects && affectedObjects.length > 0)
         {
            LogUtils.log("Explosion: " + explosion.id + " objects in terrain explosion radius: " + affectedObjects.length,this,1,"Emitter",false,false,false);
            for each(var affectedObjectId in affectedObjects)
            {
               var _loc8_:* = tuxGame.tuxWorld;
               _loc7_ = _loc8_._gameObjects.findGameObjectByUniqueId(affectedObjectId) as PhysicsGameObject;
               if(!_loc7_)
               {
                  LogUtils.log("Couldn\'t find game object with id: " + affectedObjectId,this,3,"ErrorLogging",true,false,false);
               }
               else
               {
                  LogUtils.addDebugLine("HitTerrainRadius",_loc7_.shortName + " was inside terrain radius.");
                  _loc7_.handleExplosionTerrain(locationPoint,explosion.explosionShape);
               }
            }
         }
      }
      
      private function handleScript(explosion:Explosion, targetingData:SimpleScriptParams) : void
      {
         if(explosion.className)
         {
            var _loc3_:SimpleScriptManager = SimpleScriptManager;
            if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
            {
               new tuxwars.battle.simplescript.SimpleScriptManager();
            }
            tuxwars.battle.simplescript.SimpleScriptManager._instance.run(false,explosion,targetingData);
         }
      }
      
      private function handleSendGame(msg:Message) : void
      {
         tuxGame = msg.data;
         ExplosionPreCalculationsWrapper.initStaticPool(tuxGame.tuxWorld);
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      private function generateExplosionEmissions(emissionObject:Emission) : Vector.<EmissionReference>
      {
         var _loc2_:Vector.<EmissionReference> = new Vector.<EmissionReference>();
         for each(var boosterEmission in emissionObject.getBoosterExplosionEmissions())
         {
            _loc2_.push(boosterEmission);
         }
         return _loc2_;
      }
      
      private function calculateExplosionDamageRadius(emission:Emission, _radius:int) : int
      {
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var radius:* = _radius;
         var _loc4_:Stat = emission.findStat("DamageRadius");
         if(_loc4_ != null && _loc4_.getModifiers().length > 0)
         {
            _loc3_ = _loc4_.calculateValue();
            if(_loc3_ != 0)
            {
               _loc6_ = radius * _loc3_;
               LogUtils.log("Damage explosion radius: " + radius + " modified by: " + _loc4_.getFormattedCalculatedValue() + " new radius: " + _loc6_,null,0,"Emission",false,false,false);
               radius = _loc6_;
            }
         }
         return radius;
      }
   }
}
