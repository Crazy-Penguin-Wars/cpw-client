package tuxwars.battle.data.animationEmissions
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.TuxEmissionGameObjectData;
   
   public class AnimationEmissionData extends TuxEmissionGameObjectData
   {
      private static const ACTIVATION_TIME:String = "ActivationTime";
      
      public function AnimationEmissionData(row:Row)
      {
         super(row);
      }
      
      public function get activationTime() : int
      {
         var _loc3_:String = "ActivationTime";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      override public function hasPhysicsToLoad() : Boolean
      {
         return false;
      }
   }
}

