package tuxwars.battle.emitters
{
   import com.dchoc.gameobjects.GameObjectDef;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Ray;
   import nape.geom.RayResult;
   import nape.geom.Vec2;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.animationEmission.AnimationEmission;
   import tuxwars.battle.animationEmission.AnimationEmissionDef;
   import tuxwars.battle.data.animationEmissions.AnimationEmissionData;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.events.FireEmissionMessage;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.items.references.EmissionAnimationReference;
   
   public class AnimationEmitter
   {
      
      public static const ANIMATION_EMITTER:String = "AnimationEmitter";
      
      private static const TARGET_FROM_AIR:String = "from_air";
      
      private static const TARGET_AT_POINT:String = "at_point";
      
      private static var tuxGame:TuxWarsGame;
      
      private static var hitLocation:Vec2;
       
      
      public function AnimationEmitter()
      {
         super();
         throw new Error("TargetEmitter is a static class!");
      }
      
      public static function addListeners() : void
      {
         MessageCenter.addListener("AnimationEmitter",emit);
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
      }
      
      public static function removeListeners() : void
      {
         MessageCenter.removeListener("AnimationEmitter",emit);
      }
      
      private static function handleSendGame(msg:Message) : void
      {
         tuxGame = msg.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public static function emit(msg:FireEmissionMessage) : void
      {
         var _loc2_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var animation:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:Emission = msg.emissionObject;
         if(_loc5_ && !_loc5_.tagger)
         {
            LogUtils.log("Tagger is null, this should not be!","AnimationEmitter",2,"Emitter",false,false,false);
            _loc5_.setEmittingDone();
            return;
         }
         var _loc9_:TuxWorld = tuxGame.tuxWorld;
         getHitLocation(msg);
         if(hitLocation)
         {
            _loc2_ = new EmissionAnimationReference(msg.emissionReference.specialEffect);
            _loc8_ = _loc2_.getAnimationEmissionData();
            _loc7_ = new AnimationEmissionDef(tuxGame.tuxWorld.physicsWorld.space);
            _loc7_.loadDataConf(_loc8_);
            animation = _loc9_.createGameObject(_loc7_ as GameObjectDef);
            var _loc10_:* = animation;
            _loc10_._displayObject.x = hitLocation.x;
            var _loc11_:* = animation;
            _loc11_._displayObject.y = hitLocation.y;
            var _loc12_:* = animation;
            _loc9_.addDisplayObject(_loc12_._displayObject);
            animation.location = hitLocation.copy();
            animation.emitLocation = hitLocation.copy();
            animation.playerAttackValueStat = _loc5_.playerAttackValueStat;
            animation.tagger = _loc5_.tagger;
            animation.soundId = _loc2_.soundID;
            _loc6_ = _loc5_.getEmissionsParams("Params");
            _loc4_ = EmitterUtils.getFiringDirection(_loc5_,msg.emissionReference,BattleManager.getRandom(),_loc6_ != null && _loc6_.dir != null ? _loc6_.dir : null);
            if(_loc4_.length != 0)
            {
               _loc4_.normalise();
            }
            EmitterUtils.copyParams(msg.emissionObject,animation,_loc4_);
            MessageCenter.sendEvent(new EmissionMessage(animation,msg.playerId));
            LogUtils.log(_loc5_.id + " animation triggered at location: " + hitLocation,"AnimationEmitter");
            tuxGame.battleState.emissionTracker.postProcessEmission(_loc5_);
         }
      }
      
      private static function getHitLocation(msg:FireEmissionMessage) : void
      {
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:Emission = msg.emissionObject;
         var _loc6_:EmissionAnimationReference = new EmissionAnimationReference(msg.emissionReference.specialEffect);
         var _loc7_:Object = _loc5_.getEmissionsParams("Params");
         var _loc4_:Vec2 = _loc7_.dir;
         var _loc10_:* = _loc6_.getTarget();
         if("from_air" !== _loc10_)
         {
            hitLocation = _loc5_.location.copy();
         }
         else
         {
            _loc9_ = tuxGame.tuxWorld;
            _loc8_ = _loc5_.location.copy();
            _loc8_.x += _loc4_.x;
            _loc8_.y = 0;
            hitLocation = null;
            _loc10_ = Config;
            _loc3_ = new Ray(_loc8_,Config.VEC_DOWN.copy());
            _loc2_ = _loc9_.physicsWorld.space.rayCast(_loc3_);
            hitLocation = _loc3_.at(_loc2_.distance);
         }
      }
   }
}
