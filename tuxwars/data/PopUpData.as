package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class PopUpData
   {
      private static var _table:Table;
      
      private static const TABLE:String = "PopupData";
      
      private static const PICTURE:String = "Picture";
      
      private static const TITLE:String = "Title";
      
      private static const DESCRIPTION:String = "Description";
      
      public function PopUpData()
      {
         super();
         throw new Error("PopUpData is a static class!");
      }
      
      public static function getPicture(param1:String) : String
      {
         return Config.getDataDir() + getValue(param1,"Picture");
      }
      
      public static function getTitle(param1:String, param2:Array = null) : String
      {
         return ProjectManager.getText(getValue(param1,"Title"),param2);
      }
      
      public static function getDescription(param1:String, param2:Array = null) : String
      {
         return ProjectManager.getText(getValue(param1,"Description"),param2);
      }
      
      private static function getValue(param1:String, param2:String) : *
      {
         var _loc7_:Row = null;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc3_:Field = null;
         if(!PopUpData.table)
         {
            PopUpData.table = ProjectManager.findTable("PopupData");
         }
         var _loc4_:* = param1;
         var _loc5_:* = PopUpData.table;
         if(!_loc5_.getCache[_loc4_])
         {
            _loc7_ = DCUtils.find(_loc5_.rows,"id",_loc4_);
            if(!_loc7_)
            {
               LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc5_.name + "\'",_loc5_,3);
            }
            _loc5_.getCache[_loc4_] = _loc7_;
         }
         var _loc6_:Row = _loc5_.getCache[_loc4_];
         if(_loc6_)
         {
            _loc8_ = param2;
            _loc9_ = _loc6_;
            if(!_loc9_.getCache[_loc8_])
            {
               _loc9_.getCache[_loc8_] = DCUtils.find(_loc9_.getFields(),"name",_loc8_);
            }
            _loc3_ = _loc9_.getCache[_loc8_];
            _loc10_ = _loc3_;
            return !!_loc3_ ? (_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value) : null;
         }
         return null;
      }
      
      private static function get table() : Table
      {
         var _loc1_:String = null;
         if(!_table)
         {
            _loc1_ = "PopupData";
            _table = ProjectManager.findTable(_loc1_);
         }
         return _table;
      }
   }
}

