package tuxwars.battle.emitters
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import nape.phys.*;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.data.explosions.ExplosionData;
   import tuxwars.battle.data.follower.*;
   import tuxwars.battle.effects.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.explosions.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.battle.utils.*;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.challenges.events.*;
   import tuxwars.items.references.*;
   import tuxwars.player.reports.events.*;
   
   public class ExplosionEmitter
   {
      private static var _instance:ExplosionEmitter;
      
      public static const EXPLOSION_EMITTER:String = "ExplosionEmitter";
      
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
         this.tuxGame = null;
         ExplosionPreCalculationsWrapper.disposeWorld();
      }
      
      public function addListeners() : void
      {
         MessageCenter.addListener("ExplosionEmitter",this.explode);
         MessageCenter.addListener("SendGame",this.handleSendGame);
         MessageCenter.sendMessage("GetGame");
      }
      
      public function removeListeners() : void
      {
         MessageCenter.removeListener("ExplosionEmitter",this.explode);
      }
      
      private function explode(param1:FireEmissionMessage) : void
      {
         var _loc24_:* = undefined;
         var _loc2_:PlayerGameObject = null;
         var _loc3_:EmissionReference = null;
         var _loc4_:Vec2 = null;
         var _loc5_:EmissionExplosionReference = null;
         var _loc6_:ExplosionData = null;
         var _loc7_:Explosion = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:* = undefined;
         var _loc12_:EmissionExplosionReference = null;
         var _loc13_:ExplosionData = null;
         var _loc14_:Explosion = null;
         if(Config.isDev())
         {
            assert("Expected an explosion: " + param1.emissionReference.id + " specialType: " + param1.emissionReference.specialType,true,param1.emissionReference.specialType == "ExplosionEmitter");
         }
         var _loc15_:Emission = param1.emissionObject;
         var _loc16_:PhysicsGameObject = _loc15_ as PhysicsGameObject;
         if(_loc16_)
         {
            if(_loc16_._hasHPs && _loc16_.isDeadHP())
            {
               LogUtils.log("Trying to blow up an already destroyed game object: " + _loc16_.shortName,this,2,"Emission");
               return;
            }
            _loc2_ = _loc16_ as PlayerGameObject;
            if(Boolean(_loc2_) && (_loc2_.isDead() || _loc2_.isSpawning()))
            {
               LogUtils.log("Trying to blow up a dead player: " + _loc2_.shortName,this,2,"Emission");
               return;
            }
         }
         if(Boolean(_loc15_) && !_loc15_.tagger)
         {
            LogUtils.log("Tagger is null, this should not be!","ExplosionEmitter",2,"Emitter",Config.isDev(),false,Config.isDev());
            _loc15_.setEmittingDone();
            return;
         }
         if(!_loc15_.location)
         {
            LogUtils.log("Explosion location is null, skipping. (id:" + _loc15_.id + ")(uid:" + _loc15_.uniqueId + ")",this,1,"Emitter",Config.isDev(),false,false);
            _loc15_.setEmittingDone();
            return;
         }
         LogUtils.log("Explosion: " + _loc15_ + " stepTime: " + this.tuxGame.tuxWorld.physicsWorld.stepCount,this,0,"Emitter",false,false,false);
         var _loc17_:TuxWorld = this.tuxGame.tuxWorld;
         var _loc18_:PlayerGameObject = !!_loc15_.tagger ? _loc15_.tagger.gameObject as PlayerGameObject : null;
         var _loc19_:EmissionReference = param1.emissionReference;
         var _loc20_:Object = _loc15_.getEmissionsParams("Params");
         var _loc21_:Vec2 = EmitterUtils.getFiringDirection(_loc15_,_loc19_,BattleManager.getRandom(),_loc20_ != null && _loc20_.dir != null ? _loc20_.dir : null);
         if(_loc21_.length != 0)
         {
            _loc21_.normalise();
         }
         var _loc22_:int = param1.currentCount;
         var _loc23_:Vec2 = EmitterUtils.getModifiedFiringDirection(_loc18_,_loc19_,null,_loc21_,param1.maxCount,_loc22_,BattleManager.getRandom());
         _loc21_.dispose();
         if(_loc23_)
         {
            _loc3_ = param1.emissionReference;
            _loc4_ = _loc15_.location;
            EmitterUtils.offsetLocation(_loc3_,_loc23_,_loc22_,BattleManager.getRandom(),null,_loc4_);
            _loc5_ = EmissionExplosionReference.get(_loc3_.specialEffect);
            _loc6_ = _loc5_.getExplosionData();
            _loc7_ = new Explosion(_loc6_.id,_loc6_.attack,_loc6_.impulse,_loc6_.impulseRadius,_loc6_.damageRadius,_loc4_,_loc6_.explosionShape,_loc6_.particleEffect,_loc15_.tagger,_loc6_.getEmissions(),_loc15_.playerAttackValueStat,_loc15_.playerBoosterStats,_loc6_.simpleScript,_loc6_.simpleScriptEveryTarget,_loc6_.shakeEffectTime,_loc6_.shakeEffectStrength,_loc6_.flash);
            _loc7_.soundId = _loc3_.soundID;
            EmitterUtils.copyParams(_loc15_,_loc7_,_loc23_);
            EmitterUtils.handleBoosters(_loc7_,_loc15_,_loc18_);
            LogUtils.log(_loc15_.id + " exploding " + _loc7_.id + " at loc: " + _loc4_ + ", stepTime: " + this.tuxGame.tuxWorld.physicsWorld.stepCount,this,0,"Emitter",false,false,false);
            if(!_loc18_)
            {
               LogUtils.log("No firing player!",this,1,"Emitter",false,false,false);
            }
            _loc8_ = _loc15_.getEmissionData(_loc3_,"DamageList");
            this.handleDamage(_loc7_,_loc17_,_loc4_,_loc18_,_loc15_,_loc8_,_loc5_,param1.emissionReference);
            _loc9_ = _loc15_.getEmissionData(_loc3_,"ImpulseList");
            this.handleImpulse(_loc7_,_loc17_,_loc4_,_loc18_,_loc9_);
            _loc10_ = _loc15_.getEmissionData(_loc3_,"TerrainList");
            this.handleTerrain(_loc7_,_loc17_,_loc4_,_loc18_,_loc10_);
            if(!_loc7_.simpleScriptEveryTarget)
            {
               this.handleScript(_loc7_,null);
            }
            MessageCenter.sendEvent(new EmissionMessage(_loc7_,param1.playerId));
            _loc17_.addCameraShake(_loc7_.getShakeTime(),_loc7_.getShakeStrength());
            if(_loc7_.flash)
            {
               FlashEffect.execute();
            }
            _loc15_.setEmissionData(_loc3_,"Handled",true);
            if(!param1.emissionObject.hasEmissionData(param1.emissionReference,"BoosterExplosion") || !param1.emissionObject.getEmissionData(param1.emissionReference,"BoosterExplosion"))
            {
               _loc11_ = this.generateExplosionEmissions(_loc15_);
               for each(_loc24_ in _loc11_)
               {
                  _loc12_ = EmissionExplosionReference.get(_loc24_.specialEffect);
                  _loc13_ = _loc12_.getExplosionData();
                  _loc14_ = new Explosion(_loc13_.id,_loc13_.attack,_loc13_.impulse,_loc13_.impulseRadius,_loc13_.damageRadius,_loc4_,_loc13_.explosionShape,_loc13_.particleEffect,_loc15_.tagger,[_loc24_],_loc15_.playerAttackValueStat,_loc15_.playerBoosterStats,_loc13_.simpleScript,_loc13_.simpleScriptEveryTarget,_loc13_.shakeEffectTime,_loc13_.shakeEffectStrength,_loc13_.flash);
                  _loc14_.setEmissionData(_loc24_,"BoosterExplosion",true);
                  MessageCenter.sendEvent(new EmissionMessage(new EmissionSpawn(_loc14_,_loc4_,_loc15_.tagger),param1.playerId));
               }
            }
         }
         this.tuxGame.battleState.emissionTracker.postProcessEmission(_loc15_);
      }
      
      private function handleImpulse(param1:Explosion, param2:TuxWorld, param3:Vec2, param4:PlayerGameObject, param5:Array) : void
      {
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc6_:PhysicsGameObject = null;
         var _loc7_:Body = null;
         var _loc8_:Vec2 = null;
         var _loc9_:Vec2 = null;
         var _loc10_:String = null;
         if(Boolean(param5) && param5.length > 0)
         {
            LogUtils.log("Explosion: " + param1.id + " objects in impulse radius: " + param5.length,this,0,"Emitter",false,false,false);
            for each(_loc11_ in param5)
            {
               _loc12_ = this.tuxGame.tuxWorld;
               _loc6_ = _loc12_._gameObjects.findGameObjectByUniqueId(_loc11_) as PhysicsGameObject;
               if(!_loc6_)
               {
                  LogUtils.log("Couldn\'t find game object with id: " + _loc11_,this,3,"ErrorLogging",true,false,false);
               }
               else if(_loc6_.body)
               {
                  LogUtils.addDebugLine("HitImpulseRadius",_loc6_.shortName + " was inside impulse radius.");
                  _loc7_ = _loc6_.body;
                  if(_loc7_.type != BodyType.STATIC)
                  {
                     _loc8_ = _loc6_.bodyLocation.copy();
                     _loc9_ = _loc8_.sub(param3);
                     _loc10_ = "initial hitVector: " + _loc9_ + ", initial body loc: " + _loc8_;
                     if(_loc9_.length != 0)
                     {
                        _loc9_.normalise();
                     }
                     if(Boolean(isNaN(_loc9_.x)) && Boolean(isNaN(_loc9_.y)))
                     {
                        _loc9_.x = 0;
                        _loc9_.y = 0;
                     }
                     _loc10_ += ", normalized hitVector: " + _loc9_;
                     _loc9_.length = DamageUtil.scaleValueAccordingToDistance(param1.impulseRadius,param1.impulse,param3,_loc8_,_loc6_,param1,"impulse");
                     _loc10_ += ",  multiplied hitVector: " + _loc9_;
                     _loc7_.applyImpulse(_loc9_);
                     LogUtils.log("ExplosionEmitter impulse " + _loc10_ + ", final hitVector: " + _loc9_ + ", final body loc: " + _loc8_ + " stepTime: " + this.tuxGame.tuxWorld.physicsWorld.stepCount,this,0,"Emitter",false,false,false);
                  }
                  _loc6_.handleExplosionImpulse(param3,param4);
               }
            }
         }
      }
      
      private function handleDamage(param1:Explosion, param2:TuxWorld, param3:Vec2, param4:PlayerGameObject, param5:Emission, param6:Array, param7:EmissionExplosionReference, param8:EmissionReference) : void
      {
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc9_:PhysicsGameObject = null;
         var _loc10_:Vec2 = null;
         var _loc11_:Follower = null;
         var _loc12_:int = 0;
         param2.addParticle(param1.particleEffect,param3.x,param3.y);
         var _loc13_:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
         var _loc14_:Vector.<int> = new Vector.<int>();
         if(Boolean(param6) && param6.length > 0)
         {
            LogUtils.log("Explosion: " + param1.id + " objects in damage radius: " + param6.length,this,1,"Emitter",false,false,false);
            for each(_loc15_ in param6)
            {
               _loc16_ = this.tuxGame.tuxWorld;
               _loc9_ = _loc16_._gameObjects.findGameObjectByUniqueId(_loc15_) as PhysicsGameObject;
               if(!_loc9_)
               {
                  LogUtils.log("Couldn\'t find game object with id: " + _loc15_,this,3,"ErrorLogging",true,false,false);
               }
               else if(_loc9_.body)
               {
                  LogUtils.addDebugLine("HitDamageRadius",_loc9_.shortName + " was inside damage radius.");
                  _loc10_ = _loc9_.bodyLocation.copy();
                  if(!(_loc9_ is TerrainGameObject) || _loc9_ is TerrainGameObject && Boolean((_loc9_ as TerrainGameObject).isDynamic()))
                  {
                     if(Boolean(param8) && Boolean(param8.followers))
                     {
                        for each(_loc17_ in param8.followers)
                        {
                           _loc11_ = Followers.createFollower(_loc17_.id,_loc10_,param2.physicsWorld,param5.playerAttackValueStat,param5.playerBoosterStats,_loc9_,param5.tagger);
                        }
                     }
                  }
                  _loc12_ = int(DamageUtil.damageRecieved(param1.attackerStat,param5,_loc9_,this.calculateExplosionDamageRadius(param5,param1.damageRadius),param3,_loc10_));
                  if(param1.simpleScriptEveryTarget)
                  {
                     this.handleScript(param1,new SimpleScriptParams(_loc9_,param4));
                  }
                  if(_loc12_ != 0)
                  {
                     _loc9_.handleExplosionDamage(new Damage(param5,param1.id,param1.uniqueId,_loc12_,param3,param4));
                  }
                  _loc13_.push(_loc9_);
                  _loc14_.push(_loc12_);
               }
            }
            if(param4)
            {
               MessageCenter.sendEvent(new ReportExplosionMessage(param4,_loc13_,_loc14_));
            }
         }
         if(param4)
         {
            LogUtils.log("Sending ChallengeAmmoHitMessage","ExplosionEmitter",0,"Challenges",false,false,false);
            MessageCenter.sendEvent(new ChallengeAmmoHitMessage(param5,param8,param7,_loc13_,param4,_loc14_));
         }
      }
      
      private function addAttackModifiers(param1:Stat, param2:Explosion) : void
      {
         var _loc3_:* = undefined;
         if(param1 != null && param1.getModifiers().length > 0)
         {
            LogUtils.log("Found attack stat boost: " + param1,this,0,"Stats",false,false,false);
            for each(_loc3_ in param1.getModifiers())
            {
               param2.attackerStat.addModifier(_loc3_);
               LogUtils.log("Damage explosion modified with: " + _loc3_.getId(),null,0,"DamageModify",false,false,false);
            }
         }
      }
      
      private function handleTerrain(param1:Explosion, param2:TuxWorld, param3:Vec2, param4:PlayerGameObject, param5:Array) : void
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc6_:PhysicsGameObject = null;
         if(Boolean(param5) && param5.length > 0)
         {
            LogUtils.log("Explosion: " + param1.id + " objects in terrain explosion radius: " + param5.length,this,1,"Emitter",false,false,false);
            for each(_loc7_ in param5)
            {
               _loc8_ = this.tuxGame.tuxWorld;
               _loc6_ = _loc8_._gameObjects.findGameObjectByUniqueId(_loc7_) as PhysicsGameObject;
               if(!_loc6_)
               {
                  LogUtils.log("Couldn\'t find game object with id: " + _loc7_,this,3,"ErrorLogging",true,false,false);
               }
               else
               {
                  LogUtils.addDebugLine("HitTerrainRadius",_loc6_.shortName + " was inside terrain radius.");
                  _loc6_.handleExplosionTerrain(param3,param1.explosionShape);
               }
            }
         }
      }
      
      private function handleScript(param1:Explosion, param2:SimpleScriptParams) : void
      {
         if(param1.className)
         {
            if(!SimpleScriptManager.instance)
            {
               new SimpleScriptManager();
            }
            SimpleScriptManager.instance.run(false,param1,param2);
         }
      }
      
      private function handleSendGame(param1:Message) : void
      {
         this.tuxGame = param1.data;
         ExplosionPreCalculationsWrapper.initStaticPool(this.tuxGame.tuxWorld);
         MessageCenter.removeListener("SendGame",this.handleSendGame);
      }
      
      private function generateExplosionEmissions(param1:Emission) : Vector.<EmissionReference>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<EmissionReference> = new Vector.<EmissionReference>();
         for each(_loc3_ in param1.getBoosterExplosionEmissions())
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      private function calculateExplosionDamageRadius(param1:Emission, param2:int) : int
      {
         var _loc3_:Number = Number(NaN);
         var _loc4_:int = 0;
         var _loc5_:* = param2;
         var _loc6_:Stat = param1.findStat("DamageRadius");
         if(_loc6_ != null && _loc6_.getModifiers().length > 0)
         {
            _loc3_ = _loc6_.calculateValue();
            if(_loc3_ != 0)
            {
               _loc4_ = _loc5_ * _loc3_;
               LogUtils.log("Damage explosion radius: " + _loc5_ + " modified by: " + _loc6_.getFormattedCalculatedValue() + " new radius: " + _loc4_,null,0,"Emission",false,false,false);
               _loc5_ = _loc4_;
            }
         }
         return _loc5_;
      }
   }
}

