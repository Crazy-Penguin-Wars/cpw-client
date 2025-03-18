package tuxwars.home.ui.logic.help
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
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
            var _loc4_:String = "Title";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Picture";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Description";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "SortOrder";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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

