package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class LevelData
   {
      private static const LEVEL_FILE:String = "LevelFile";
      
      private static const MIN_LEVEL:String = "MinLevel";
      
      private static const NAME:String = "Name";
      
      private static const SWF:String = "SWF";
      
      private static const EXPORT:String = "Export";
      
      private var row:Row;
      
      public function LevelData(param1:Row)
      {
         super();
         this.row = param1;
      }
      
      public function get levelFile() : String
      {
         var _loc1_:String = "LevelFile";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get minLevel() : int
      {
         var _loc1_:String = "MinLevel";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public function get tid() : String
      {
         var _loc1_:String = "Name";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get name() : String
      {
         return ProjectManager.getText(this.tid);
      }
      
      public function get swf() : String
      {
         var _loc1_:String = "SWF";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get export() : String
      {
         var _loc1_:String = "Export";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get id() : String
      {
         return this.row.id;
      }
   }
}

