package tuxwars.items.references
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
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
         var _loc3_:Row = row;
         if(!_loc3_._cache["Animation"])
         {
            _loc3_._cache["Animation"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Animation");
         }
         var _loc1_:Field = _loc3_._cache["Animation"];
         var _loc4_:*;
         var _loc2_:Row = _loc1_ != null ? (_loc4_ = _loc1_, (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) as Row) : null;
         return _loc2_ != null ? AnimationEmissions.getAnimationEmissionData(_loc2_.id) : null;
      }
      
      public function getTarget() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Target"])
         {
            _loc2_._cache["Target"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Target");
         }
         var _loc1_:Field = _loc2_._cache["Target"];
         var _loc3_:*;
         return _loc1_ != null ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get soundID() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["SoundID"])
         {
            _loc2_._cache["SoundID"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SoundID");
         }
         var _loc1_:Field = _loc2_._cache["SoundID"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
   }
}
