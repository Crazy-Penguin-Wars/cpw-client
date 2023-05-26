package tuxwars.home.ui.logic.help
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.assert;
   
   public class HelpReference
   {
      
      public static const TABLE:String = "HelpData";
      
      private static const TITLE:String = "Title";
      
      private static const PICTURE:String = "Picture";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const SORT_ORDER:String = "SortOrder";
       
      
      private var _row:Row;
      
      public function HelpReference(row:Row)
      {
         super();
         assert("HelpReference is null",true,row != null);
         _row = row;
      }
      
      public function get id() : String
      {
         return _row.id;
      }
      
      public function get title() : String
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["Title"])
            {
               _loc2_._cache["Title"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Title");
            }
            §§push(_loc2_._cache["Title"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get picture() : String
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["Picture"])
            {
               _loc2_._cache["Picture"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Picture");
            }
            §§push(_loc2_._cache["Picture"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, Config.getDataDir() + (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get description() : String
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["Description"])
            {
               _loc2_._cache["Description"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Description");
            }
            §§push(_loc2_._cache["Description"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get sortOrder() : int
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["SortOrder"])
            {
               _loc2_._cache["SortOrder"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SortOrder");
            }
            §§push(_loc2_._cache["SortOrder"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
   }
}
