package tuxwars.battle.emitters
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import nape.geom.Vec2;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.follower.Followers;
   import tuxwars.battle.data.missiles.MissileData;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.events.FireEmissionMessage;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.missiles.Mine;
   import tuxwars.battle.missiles.Missile;
   import tuxwars.battle.missiles.MissileDef;
   import tuxwars.battle.missiles.MissileManager;
   import tuxwars.items.references.EmissionMissileReference;
   import tuxwars.items.references.EmissionReference;
   
   public class MissileEmitter
   {
      
      public static const MISSILE_EMITTER:String = "MissileEmitter";
      
      private static var tuxGame:TuxWarsGame;
      
      private static var counter:int;
       
      
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
      
      private static function launchMissile(msg:FireEmissionMessage) : void
      {
         var _loc14_:* = null;
         var _loc12_:* = null;
         var _loc9_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc3_:* = null;
         var _loc15_:Emission = msg.emissionObject;
         if(_loc15_ != null && _loc15_.tagger == null)
         {
            LogUtils.log("Tagger is null, this should not be!","MissileEmitter",2,"Emitter",Config.isDev(),false,Config.isDev());
            _loc15_.setEmittingDone();
            return;
         }
         var _loc16_:EmissionReference = msg.emissionReference;
         var _loc18_:Object = _loc15_.getEmissionsParams("Params");
         LogUtils.log("MissileEmitter launching missile from emissionObject: " + _loc15_.shortName + " stepTime: " + tuxGame.tuxWorld.physicsWorld.stepCount,"MissileEmitter",1,"Emitter",false,false,false);
         var _loc17_:Vec2 = EmitterUtils.getFiringDirection(_loc15_,_loc16_,BattleManager.getRandom(),_loc18_ != null && _loc18_.dir != null ? _loc18_.dir : null);
         if(_loc17_.length != 0)
         {
            _loc17_.normalise();
         }
         var _loc21_:EmissionMissileReference = EmissionMissileReference.get(_loc16_.specialEffect);
         var _loc10_:MissileData = _loc21_.missileData;
         var _loc7_:Array = _loc15_.getBoosterMissileEmissions();
         replaceMissileDataWithBoosterMissileData(_loc10_,_loc15_);
         var _loc19_:int = EmitterUtils.getPowerLevel(_loc10_.firingImpulseMax,_loc10_.firingImpulseMin,_loc18_ != null ? _loc18_.powerBar : 0);
         var _loc22_:Vec2 = _loc15_.location.copy();
         var _loc6_:MissileDef = MissileManager.createMissileDefFromData(_loc10_,_loc22_,tuxGame.tuxWorld.physicsWorld,_loc15_.playerAttackValueStat);
         var _loc5_:PlayerGameObject = !!_loc15_.tagger ? _loc15_.tagger.gameObject as PlayerGameObject : null;
         var _loc4_:Vec2 = _loc6_.position.copy();
         var _loc13_:int = msg.currentCount;
         var _loc8_:Vec2 = EmitterUtils.getModifiedFiringDirection(_loc5_,_loc16_,_loc7_,_loc17_,msg.maxCount,_loc13_,BattleManager.getRandom());
         if(_loc8_)
         {
            _loc6_.position = _loc4_.copy();
            EmitterUtils.offsetLocation(_loc16_,_loc8_,_loc13_,BattleManager.getRandom(),_loc6_);
            _loc8_.muleq(_loc19_);
            _loc14_ = tuxGame.tuxWorld.physicsWorld.createGameObject(_loc6_);
            _loc14_.body.userData.gameObject = _loc14_;
            _loc14_.tag.add(_loc5_);
            var _loc23_:* = _loc5_;
            _loc14_.firingPlayerId = _loc23_._id;
            _loc14_.body.applyImpulse(_loc8_);
            _loc14_.soundId = _loc16_.soundID;
            EmitterUtils.handleBoosters(_loc14_,_loc15_,_loc5_);
            _loc12_ = _loc8_.copy();
            if(_loc12_.length != 0)
            {
               _loc12_.normalise();
            }
            var _loc24_:Config = Config;
            _loc9_ = Math.acos(_loc12_.dot(Config.VEC_UP.copy()));
            _loc20_ = Number(_loc12_.x > 0 ? MathUtils.radiansToDegrees(_loc9_) : -MathUtils.radiansToDegrees(_loc9_));
            var _loc25_:* = _loc14_;
            _loc25_._displayObject.rotation = _loc20_;
            if(_loc14_ is Mine)
            {
               _loc14_.body.rotation = 3.141592653589793;
            }
            _loc14_.setCollisionFilterValues(EmitterUtils.getMissileMaskBits(),EmitterUtils.getBitsFor(_loc16_.affectedObjects));
            if(_loc16_ && _loc16_.followers)
            {
               for each(var fod in _loc16_.followers)
               {
                  _loc3_ = Followers.createFollower(fod.id,_loc14_.bodyLocation,tuxGame.tuxWorld.physicsWorld,_loc15_.playerAttackValueStat,_loc15_.playerBoosterStats,_loc14_,_loc15_.tagger);
               }
            }
            for each(var e in _loc15_.getBoosterExplosionEmissions())
            {
               _loc14_.setBoosterExplosionEmission(e);
            }
            LogUtils.log("fired missile: " + _loc14_.shortName + " dir: " + _loc17_ + " finalDir: " + _loc8_ + " missile loc: " + _loc22_ + " missile body loc: " + _loc14_.bodyLocation + " power level: " + _loc19_ + " power bar: " + (_loc18_ != null ? _loc18_.powerBar : NaN),"MissileEmitter",0,"Emitter",false,false,false);
            MessageCenter.sendEvent(new EmissionMessage(_loc14_,msg.playerId));
         }
         _loc17_.dispose();
         tuxGame.battleState.emissionTracker.postProcessEmission(_loc15_);
      }
      
      private static function replaceMissileDataWithBoosterMissileData(missileData:MissileData, emissionObject:Emission) : void
      {
         var _loc4_:* = null;
         var _loc3_:Array = emissionObject.getBoosterMissileEmissions();
         for each(var er in _loc3_)
         {
            if(er.specialType == "MissileEmitter")
            {
               _loc4_ = EmissionMissileReference.get(er.specialEffect);
               if(_loc4_ && _loc4_.missileData)
               {
                  missileData = _loc4_.missileData;
                  break;
               }
            }
         }
      }
      
      private static function handleSendGame(msg:Message) : void
      {
         tuxGame = msg.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
   }
}
