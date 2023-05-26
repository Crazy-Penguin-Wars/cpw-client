package tuxwars.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.assert;
   
   public class FeedData
   {
      
      private static const IMAGE:String = "Image";
      
      private static const TITLE:String = "Title";
      
      private static const CONTENT_TEXT:String = "ContentText";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const ACTION_TEXT:String = "ActionText";
       
      
      private var row:Row;
      
      public function FeedData(row:Row)
      {
         super();
         assert("Row is null.",true,row != null);
         this.row = row;
      }
      
      public function get id() : String
      {
         return row.id;
      }
      
      public function get image() : String
      {
         return getValue("Image");
      }
      
      public function get title() : String
      {
         return getValue("Title");
      }
      
      public function get contentText() : String
      {
         return getValue("ContentText");
      }
      
      public function get description() : String
      {
         return getValue("Description");
      }
      
      public function get actionText() : String
      {
         return getValue("ActionText");
      }
      
      private function getValue(column:String) : *
      {
         var _loc5_:* = column;
         var _loc3_:Row = row;
         if(!_loc3_._cache[_loc5_])
         {
            _loc3_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc5_);
         }
         var _loc2_:Field = _loc3_._cache[_loc5_];
         var _loc4_:*;
         return !!_loc2_ ? (_loc4_ = _loc2_, _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
   }
}
