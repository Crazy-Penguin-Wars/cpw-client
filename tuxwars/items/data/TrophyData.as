package tuxwars.items.data
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class TrophyData extends ClothingData
   {
      private static const REQUIRED_CHALLENGES:String = "RequierdChallenges";
      
      private static const STAT_TEXT_OVERRIDE:String = "StatTextOverride";
      
      public function TrophyData(param1:Row)
      {
         super(param1);
      }
      
      override public function get graphics() : GraphicsReference
      {
         LogUtils.addDebugLine("ItemData","Has no graphics configured, so the graphics is returning null by override",this);
         return null;
      }
      
      public function get requiredChallenges() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "RequierdChallenges";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get statTextOverrideDesc() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "StatTextOverride";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
   }
}

