package tuxwars.battle.emitters
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.data.follower.*;
   import tuxwars.battle.data.missiles.MissileData;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.items.references.*;
   
   public class MissileEmitter
   {
      private static var tuxGame:TuxWarsGame;
      
      private static var counter:int;
      
      public static const MISSILE_EMITTER:String = "MissileEmitter";
      
      public function MissileEmitter()
      {
         super();
         throw new Error("MissileEmitter is a static class!");
      }
      
      public static function addListeners() : void
      {
         counter = 0;
         MessageCenter.addListener("MissileEmitter",launchMissile);
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
      }
      
      public static function removeListeners() : void
      {
         MessageCenter.removeListener("MissileEmitter",launchMissile);
      }
      
      private static function launchMissile(param1:FireEmissionMessage) : void
      {
         var _loc21_:* = undefined;
         var _loc22_:Config = null;
         var _loc23_:* = undefined;
         var _loc24_:* = undefined;
         var _loc25_:* = undefined;
         var _loc2_:Missile = null;
         var _loc3_:Vec2 = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Follower = null;
         var _loc7_:Emission = param1.emissionObject;
         if(_loc7_ != null && _loc7_.tagger == null)
         {
            LogUtils.log("Tagger is null, this should not be!","MissileEmitter",2,"Emitter",Config.isDev(),false,Config.isDev());
            _loc7_.setEmittingDone();
            return;
         }
         var _loc8_:EmissionReference = param1.emissionReference;
         var _loc9_:Object = _loc7_.getEmissionsParams("Params");
         LogUtils.log("MissileEmitter launching missile from emissionObject: " + _loc7_.shortName + " stepTime: " + tuxGame.tuxWorld.physicsWorld.stepCount,"MissileEmitter",1,"Emitter",false,false,false);
         var _loc10_:Vec2 = EmitterUtils.getFiringDirection(_loc7_,_loc8_,BattleManager.getRandom(),_loc9_ != null && _loc9_.dir != null ? _loc9_.dir : null);
         if(_loc10_.length != 0)
         {
            _loc10_.normalise();
         }
         var _loc11_:EmissionMissileReference = EmissionMissileReference.get(_loc8_.specialEffect);
         var _loc12_:MissileData = _loc11_.missileData;
         var _loc13_:Array = _loc7_.getBoosterMissileEmissions();
         replaceMissileDataWithBoosterMissileData(_loc12_,_loc7_);
         var _loc14_:int = int(EmitterUtils.getPowerLevel(_loc12_.firingImpulseMax,_loc12_.firingImpulseMin,_loc9_ != null ? int(_loc9_.powerBar) : 0));
         var _loc15_:Vec2 = _loc7_.location.copy();
         var _loc16_:MissileDef = MissileManager.createMissileDefFromData(_loc12_,_loc15_,tuxGame.tuxWorld.physicsWorld,_loc7_.playerAttackValueStat);
         var _loc17_:PlayerGameObject = !!_loc7_.tagger ? _loc7_.tagger.gameObject as PlayerGameObject : null;
         var _loc18_:Vec2 = _loc16_.position.copy();
         var _loc19_:int = param1.currentCount;
         var _loc20_:Vec2 = EmitterUtils.getModifiedFiringDirection(_loc17_,_loc8_,_loc13_,_loc10_,param1.maxCount,_loc19_,BattleManager.getRandom());
         if(_loc20_)
         {
            _loc16_.position = _loc18_.copy();
            EmitterUtils.offsetLocation(_loc8_,_loc20_,_loc19_,BattleManager.getRandom(),_loc16_);
            _loc20_.muleq(_loc14_);
            _loc2_ = tuxGame.tuxWorld.physicsWorld.createGameObject(_loc16_);
            _loc2_.body.userData.gameObject = _loc2_;
            _loc2_.tag.add(_loc17_);
            _loc21_ = _loc17_;
            _loc2_.firingPlayerId = _loc21_._id;
            _loc2_.body.applyImpulse(_loc20_);
            _loc2_.soundId = _loc8_.soundID;
            EmitterUtils.handleBoosters(_loc2_,_loc7_,_loc17_);
            _loc3_ = _loc20_.copy();
            if(_loc3_.length != 0)
            {
               _loc3_.normalise();
            }
            _loc22_ = Config;
            _loc4_ = Math.acos(_loc3_.dot(Config.VEC_UP.copy()));
            _loc5_ = _loc3_.x > 0 ? Number(MathUtils.radiansToDegrees(_loc4_)) : -MathUtils.radiansToDegrees(_loc4_);
            _loc23_ = _loc2_;
            _loc23_._displayObject.rotation = _loc5_;
            if(_loc2_ is Mine)
            {
               _loc2_.body.rotation = 3.141592653589793;
            }
            _loc2_.setCollisionFilterValues(EmitterUtils.getMissileMaskBits(),EmitterUtils.getBitsFor(_loc8_.affectedObjects));
            if(Boolean(_loc8_) && Boolean(_loc8_.followers))
            {
               for each(_loc25_ in _loc8_.followers)
               {
                  _loc6_ = Followers.createFollower(_loc25_.id,_loc2_.bodyLocation,tuxGame.tuxWorld.physicsWorld,_loc7_.playerAttackValueStat,_loc7_.playerBoosterStats,_loc2_,_loc7_.tagger);
               }
            }
            for each(_loc24_ in _loc7_.getBoosterExplosionEmissions())
            {
               _loc2_.setBoosterExplosionEmission(_loc24_);
            }
            LogUtils.log("fired missile: " + _loc2_.shortName + " dir: " + _loc10_ + " finalDir: " + _loc20_ + " missile loc: " + _loc15_ + " missile body loc: " + _loc2_.bodyLocation + " power level: " + _loc14_ + " power bar: " + (_loc9_ != null ? _loc9_.powerBar : NaN),"MissileEmitter",0,"Emitter",false,false,false);
            MessageCenter.sendEvent(new EmissionMessage(_loc2_,param1.playerId));
         }
         _loc10_.dispose();
         tuxGame.battleState.emissionTracker.postProcessEmission(_loc7_);
      }
      
      private static function replaceMissileDataWithBoosterMissileData(param1:MissileData, param2:Emission) : void
      {
         var _loc5_:* = undefined;
         var _loc3_:EmissionMissileReference = null;
         var _loc4_:Array = param2.getBoosterMissileEmissions();
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.specialType == "MissileEmitter")
            {
               _loc3_ = EmissionMissileReference.get(_loc5_.specialEffect);
               if(Boolean(_loc3_) && Boolean(_loc3_.missileData))
               {
                  param1 = _loc3_.missileData;
                  break;
               }
            }
         }
      }
      
      private static function handleSendGame(param1:Message) : void
      {
         tuxGame = param1.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
   }
}

