package tuxwars.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class PopUpData
   {
      
      private static const TABLE:String = "PopupData";
      
      private static const PICTURE:String = "Picture";
      
      private static const TITLE:String = "Title";
      
      private static const DESCRIPTION:String = "Description";
      
      private static var _table:Table;
       
      
      public function PopUpData()
      {
         super();
         throw new Error("PopUpData is a static class!");
      }
      
      public static function getPicture(id:String) : String
      {
         return Config.getDataDir() + getValue(id,"Picture");
      }
      
      public static function getTitle(id:String, params:Array = null) : String
      {
         return ProjectManager.getText(getValue(id,"Title"),params);
      }
      
      public static function getDescription(id:String, params:Array = null) : String
      {
         return ProjectManager.getText(getValue(id,"Description"),params);
      }
      
      private static function getValue(id:String, fieldName:String) : *
      {
         var _loc3_:* = null;
         if(!tuxwars.data.PopUpData._table)
         {
            tuxwars.data.PopUpData._table = com.dchoc.projectdata.ProjectManager.findTable("PopupData");
         }
         var _loc8_:* = id;
         var _loc5_:* = tuxwars.data.PopUpData._table;
         if(!_loc5_._cache[_loc8_])
         {
            var _loc9_:Row = com.dchoc.utils.DCUtils.find(_loc5_.rows,"id",_loc8_);
            if(!_loc9_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc8_ + "\' was found in table: \'" + _loc5_.name + "\'",_loc5_,3);
            }
            _loc5_._cache[_loc8_] = _loc9_;
         }
         var _loc4_:Row = _loc5_._cache[_loc8_];
         if(_loc4_)
         {
            var _loc10_:* = fieldName;
            var _loc6_:* = _loc4_;
            if(!_loc6_._cache[_loc10_])
            {
               _loc6_._cache[_loc10_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc10_);
            }
            _loc3_ = _loc6_._cache[_loc10_];
            var _loc7_:*;
            return !!_loc3_ ? (_loc7_ = _loc3_, _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) : null;
         }
         return null;
      }
      
      private static function get table() : Table
      {
         if(!_table)
         {
            var _loc1_:ProjectManager = ProjectManager;
            _table = com.dchoc.projectdata.ProjectManager.projectData.findTable("PopupData");
         }
         return _table;
      }
   }
}
