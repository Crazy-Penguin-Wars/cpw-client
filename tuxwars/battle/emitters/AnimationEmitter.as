package tuxwars.battle.emitters
{
   import com.dchoc.gameobjects.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.animationEmission.*;
   import tuxwars.battle.data.animationEmissions.AnimationEmissionData;
   import tuxwars.battle.events.*;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.items.references.*;
   
   public class AnimationEmitter
   {
      private static var tuxGame:TuxWarsGame;
      
      private static var hitLocation:Vec2;
      
      public static const ANIMATION_EMITTER:String = "AnimationEmitter";
      
      private static const TARGET_FROM_AIR:String = "from_air";
      
      private static const TARGET_AT_POINT:String = "at_point";
      
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
      
      private static function handleSendGame(param1:Message) : void
      {
         tuxGame = param1.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public static function emit(param1:FireEmissionMessage) : void
      {
         var _loc2_:EmissionAnimationReference = null;
         var _loc8_:Emission = null;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         _loc2_ = null;
         var _loc3_:AnimationEmissionData = null;
         var _loc4_:AnimationEmissionDef = null;
         var _loc5_:AnimationEmission = null;
         var _loc6_:Object = null;
         var _loc7_:Vec2 = null;
         _loc8_ = param1.emissionObject;
         if((Boolean(_loc8_)) && !_loc8_.tagger)
         {
            LogUtils.log("Tagger is null, this should not be!","AnimationEmitter",2,"Emitter",false,false,false);
            _loc8_.setEmittingDone();
            return;
         }
         var _loc9_:TuxWorld = tuxGame.tuxWorld;
         getHitLocation(param1);
         if(hitLocation)
         {
            _loc2_ = new EmissionAnimationReference(param1.emissionReference.specialEffect);
            _loc3_ = _loc2_.getAnimationEmissionData();
            _loc4_ = new AnimationEmissionDef(tuxGame.tuxWorld.physicsWorld.space);
            _loc4_.loadDataConf(_loc3_);
            _loc10_ = _loc5_ = _loc9_.createGameObject(_loc4_ as GameObjectDef);
            _loc10_._displayObject.x = hitLocation.x;
            _loc11_ = _loc5_;
            _loc11_._displayObject.y = hitLocation.y;
            _loc12_ = _loc5_;
            _loc9_.addDisplayObject(_loc12_._displayObject);
            _loc5_.location = hitLocation.copy();
            _loc5_.emitLocation = hitLocation.copy();
            _loc5_.playerAttackValueStat = _loc8_.playerAttackValueStat;
            _loc5_.tagger = _loc8_.tagger;
            _loc5_.soundId = _loc2_.soundID;
            _loc6_ = _loc8_.getEmissionsParams("Params");
            _loc7_ = EmitterUtils.getFiringDirection(_loc8_,param1.emissionReference,BattleManager.getRandom(),_loc6_ != null && _loc6_.dir != null ? _loc6_.dir : null);
            if(_loc7_.length != 0)
            {
               _loc7_.normalise();
            }
            EmitterUtils.copyParams(param1.emissionObject,_loc5_,_loc7_);
            MessageCenter.sendEvent(new EmissionMessage(_loc5_,param1.playerId));
            LogUtils.log(_loc8_.id + " animation triggered at location: " + hitLocation,"AnimationEmitter");
            tuxGame.battleState.emissionTracker.postProcessEmission(_loc8_);
         }
      }
      
      private static function getHitLocation(param1:FireEmissionMessage) : void
      {
         var _loc2_:TuxWorld = null;
         var _loc3_:Vec2 = null;
         var _loc4_:Ray = null;
         var _loc5_:RayResult = null;
         var _loc6_:Emission = param1.emissionObject;
         var _loc7_:EmissionAnimationReference = new EmissionAnimationReference(param1.emissionReference.specialEffect);
         var _loc8_:Object = _loc6_.getEmissionsParams("Params");
         var _loc9_:Vec2 = _loc8_.dir;
         var _loc10_:* = _loc7_.getTarget();
         if("from_air" !== _loc10_)
         {
            hitLocation = _loc6_.location.copy();
         }
         else
         {
            _loc2_ = tuxGame.tuxWorld;
            _loc3_ = _loc6_.location.copy();
            _loc3_.x += _loc9_.x;
            _loc3_.y = 0;
            hitLocation = null;
            _loc10_ = Config;
            _loc4_ = new Ray(_loc3_,Config.VEC_DOWN.copy());
            _loc5_ = _loc2_.physicsWorld.space.rayCast(_loc4_);
            hitLocation = _loc4_.at(_loc5_.distance);
         }
      }
   }
}

