package tuxwars.battle.data.animationEmissions
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.TuxEmissionGameObjectData;
   
   public class AnimationEmissionData extends TuxEmissionGameObjectData
   {
      private static const ACTIVATION_TIME:String = "ActivationTime";
      
      public function AnimationEmissionData(param1:Row)
      {
         super(param1);
      }
      
      public function get activationTime() : int
      {
         var _loc1_:String = "ActivationTime";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      override public function hasPhysicsToLoad() : Boolean
      {
         return false;
      }
   }
}

