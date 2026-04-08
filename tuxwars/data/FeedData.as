package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.*;
   
   public class FeedData
   {
      private static const IMAGE:String = "Image";
      
      private static const TITLE:String = "Title";
      
      private static const CONTENT_TEXT:String = "ContentText";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const ACTION_TEXT:String = "ActionText";
      
      private var row:Row;
      
      public function FeedData(param1:Row)
      {
         super();
         assert("Row is null.",true,param1 != null);
         this.row = param1;
      }
      
      public function get id() : String
      {
         return this.row.id;
      }
      
      public function get image() : String
      {
         return this.getValue("Image");
      }
      
      public function get title() : String
      {
         return this.getValue("Title");
      }
      
      public function get contentText() : String
      {
         return this.getValue("ContentText");
      }
      
      public function get description() : String
      {
         return this.getValue("Description");
      }
      
      public function get actionText() : String
      {
         return this.getValue("ActionText");
      }
      
      private function getValue(param1:String) : *
      {
         var _loc5_:* = undefined;
         var _loc2_:* = param1;
         var _loc3_:Row = this.row;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         _loc5_ = _loc4_;
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         return !!_loc4_ ? (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) : null;
      }
   }
}

