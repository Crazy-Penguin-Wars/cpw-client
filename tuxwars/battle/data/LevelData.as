package tuxwars.battle.data
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
   public class LevelData
   {
      
      private static const LEVEL_FILE:String = "LevelFile";
      
      private static const MIN_LEVEL:String = "MinLevel";
      
      private static const NAME:String = "Name";
      
      private static const SWF:String = "SWF";
      
      private static const EXPORT:String = "Export";
       
      
      private var row:Row;
      
      public function LevelData(row:Row)
      {
         super();
         this.row = row;
      }
      
      public function get levelFile() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["LevelFile"])
         {
            _loc1_._cache["LevelFile"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","LevelFile");
         }
         var _loc2_:* = _loc1_._cache["LevelFile"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get minLevel() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["MinLevel"])
         {
            _loc1_._cache["MinLevel"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MinLevel");
         }
         var _loc2_:* = _loc1_._cache["MinLevel"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get tid() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["Name"])
         {
            _loc1_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Name");
         }
         var _loc2_:* = _loc1_._cache["Name"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get name() : String
      {
         return ProjectManager.getText(tid);
      }
      
      public function get swf() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["SWF"])
         {
            _loc1_._cache["SWF"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","SWF");
         }
         var _loc2_:* = _loc1_._cache["SWF"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get export() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["Export"])
         {
            _loc1_._cache["Export"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Export");
         }
         var _loc2_:* = _loc1_._cache["Export"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get id() : String
      {
         return row.id;
      }
   }
}
