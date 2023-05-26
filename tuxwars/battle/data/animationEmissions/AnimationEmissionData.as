package tuxwars.battle.data.animationEmissions
{
   import com.dchoc.projectdata.Row;
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
         var _loc1_:Row = row;
         if(!_loc1_._cache["ActivationTime"])
         {
            _loc1_._cache["ActivationTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","ActivationTime");
         }
         var _loc2_:* = _loc1_._cache["ActivationTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      override public function hasPhysicsToLoad() : Boolean
      {
         return false;
      }
   }
}
