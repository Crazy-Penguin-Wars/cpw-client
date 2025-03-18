package tuxwars.items.data
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import org.as3commons.lang.StringUtils;
   import tuxwars.items.references.EmissionReference;
   
   public class WeaponData extends ItemData
   {
      private static const ANIMATION_TYPE:String = "AnimationType";
      
      private static const TARGETING:String = "Targeting";
      
      private static const EMISSIONS:String = "Emitters";
      
      private static const ALLOW_ROTATION:String = "AllowRotation";
      
      private static const DEFAULT:String = "Default";
      
      protected var playerAnimation:GraphicsReference;
      
      public function WeaponData(row:Row)
      {
         super(row);
      }
      
      public function get animationType() : String
      {
         var _loc3_:String = "AnimationType";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get targeting() : String
      {
         var _loc3_:String = "Targeting";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get emissions() : Array
      {
         var newEmissions:*;
         var emissionArray:Array;
         var _loc4_:String = "Emitters";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc4_])
         {
            _loc1_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc4_);
         }
         var _loc2_:* = _loc1_._cache[_loc4_];
         newEmissions = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
         emissionArray = newEmissions is Array ? newEmissions as Array : [newEmissions];
         emissionArray.sort(function(row1:Row, row2:Row):int
         {
            return StringUtils.compareTo(row1.id,row2.id);
         });
         return EmissionReference.getEmissionReferences(emissionArray);
      }
      
      public function get allowRotation() : Boolean
      {
         var _loc4_:String = "AllowRotation";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return _loc1_ != null ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : false;
      }
   }
}

