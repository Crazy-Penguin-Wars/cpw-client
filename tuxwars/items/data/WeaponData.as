package tuxwars.items.data
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import org.as3commons.lang.*;
   import tuxwars.items.references.*;
   
   public class WeaponData extends ItemData
   {
      private static const ANIMATION_TYPE:String = "AnimationType";
      
      private static const TARGETING:String = "Targeting";
      
      private static const EMISSIONS:String = "Emitters";
      
      private static const ALLOW_ROTATION:String = "AllowRotation";
      
      private static const DEFAULT:String = "Default";
      
      protected var playerAnimation:GraphicsReference;
      
      public function WeaponData(param1:Row)
      {
         super(param1);
      }
      
      public function get animationType() : String
      {
         var _loc1_:String = "AnimationType";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get targeting() : String
      {
         var _loc1_:String = "Targeting";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get emissions() : Array
      {
         var _loc2_:*;
         var newEmissions:* = undefined;
         var emissionArray:Array = null;
         var _loc4_:String = "Emitters";
         var _loc1_:Row = row;
         if(!_loc1_.getCache[_loc4_])
         {
            _loc1_.getCache[_loc4_] = DCUtils.find(_loc1_.getFields(),"name",_loc4_);
         }
         _loc2_ = _loc1_.getCache[_loc4_];
         newEmissions = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
         emissionArray = newEmissions is Array ? newEmissions as Array : [newEmissions];
         emissionArray.sort(function(param1:Row, param2:Row):int
         {
            return StringUtils.compareTo(param1.id,param2.id);
         });
         return EmissionReference.getEmissionReferences(emissionArray);
      }
      
      public function get allowRotation() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "AllowRotation";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return _loc3_ != null ? (_loc4_.overrideValue != null ? Boolean(_loc4_.overrideValue) : Boolean(_loc4_._value)) : false;
      }
   }
}

