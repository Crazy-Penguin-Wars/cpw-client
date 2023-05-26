package tuxwars.items.data
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   
   public class TrophyData extends ClothingData
   {
      
      private static const REQUIRED_CHALLENGES:String = "RequierdChallenges";
      
      private static const STAT_TEXT_OVERRIDE:String = "StatTextOverride";
       
      
      public function TrophyData(row:Row)
      {
         super(row);
      }
      
      override public function get graphics() : GraphicsReference
      {
         LogUtils.addDebugLine("ItemData","Has no graphics configured, so the graphics is returning null by override",this);
         return null;
      }
      
      public function get requiredChallenges() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RequierdChallenges"])
         {
            _loc2_._cache["RequierdChallenges"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RequierdChallenges");
         }
         var _loc1_:Field = _loc2_._cache["RequierdChallenges"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get statTextOverrideDesc() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["StatTextOverride"])
         {
            _loc2_._cache["StatTextOverride"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","StatTextOverride");
         }
         var _loc1_:Field = _loc2_._cache["StatTextOverride"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
   }
}
