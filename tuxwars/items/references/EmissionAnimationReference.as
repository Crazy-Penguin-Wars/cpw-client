package tuxwars.items.references
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.animationEmissions.AnimationEmissionData;
   import tuxwars.battle.data.animationEmissions.AnimationEmissions;
   
   public class EmissionAnimationReference
   {
      private static const ANIMATION:String = "Animation";
      
      private static const TARGET:String = "Target";
      
      private static const SOUND_ID:String = "SoundID";
      
      private var row:Row;
      
      public function EmissionAnimationReference(row:Row)
      {
         super();
         assert("EmitTargetReference row is null",true,row != null);
         this.row = row;
      }
      
      public function getID() : String
      {
         return row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = row;
         var _loc2_:* = _loc1_._table;
         return _loc2_._name;
      }
      
      public function getAnimationEmissionData() : AnimationEmissionData
      {
         var _loc5_:String = "Animation";
         var _loc3_:Row = row;
         if(!_loc3_._cache[_loc5_])
         {
            _loc3_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc5_);
         }
         var _loc1_:Field = _loc3_._cache[_loc5_];
         var _loc4_:*;
         var _loc2_:Row = _loc1_ != null ? (_loc4_ = _loc1_, (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) as Row) : null;
         return _loc2_ != null ? AnimationEmissions.getAnimationEmissionData(_loc2_.id) : null;
      }
      
      public function getTarget() : String
      {
         var _loc4_:String = "Target";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return _loc1_ != null ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get soundID() : String
      {
         var _loc4_:String = "SoundID";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
   }
}

