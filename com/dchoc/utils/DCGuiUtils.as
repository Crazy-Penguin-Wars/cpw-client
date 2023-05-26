package com.dchoc.utils
{
   import com.dchoc.projectdata.ProjectManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class DCGuiUtils
   {
      
      public static const ARIAL_UNICODE_FONT:String = "Arial Unicode MS";
       
      
      public function DCGuiUtils()
      {
         super();
      }
      
      public static function checkTextFieldTextFormat(container:DisplayObjectContainer) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         if(ProjectManager.getProjectTexts().languageHasSpecialCharacters() && container)
         {
            for(i = 0; i < container.numChildren; )
            {
               _loc2_ = container.getChildAt(i);
               if(_loc2_ is TextField)
               {
                  setTextFieldTextFormat(TextField(_loc2_));
               }
               else if(_loc2_ is DisplayObjectContainer)
               {
                  checkTextFieldTextFormat(_loc2_ as DisplayObjectContainer);
               }
               i++;
            }
         }
      }
      
      public static function setTextFieldTextFormat(textField:TextField) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 2;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(textField.defaultTextFormat.font != "Arial Unicode MS")
         {
            _loc2_ = textField.text;
            _loc4_ = textField.defaultTextFormat;
            _loc5_ = int(_loc4_.size);
            _loc6_ = new TextFormat("Arial Unicode MS",_loc5_ > 10 ? _loc5_ - _loc3_ : _loc5_,_loc4_.color,_loc4_.bold,_loc4_.italic,_loc4_.underline,_loc4_.url,_loc4_.target,_loc4_.align,_loc4_.leftMargin,_loc4_.rightMargin,_loc4_.indent,_loc4_.leading);
            textField.defaultTextFormat = _loc6_;
            textField.useRichTextClipboard = true;
            textField.embedFonts = false;
            textField.text = _loc2_;
         }
      }
      
      public static function scaleToFitSize(displayObject:DisplayObject, maxWidth:int, maxHeight:int) : void
      {
         displayObject.scaleX = 1;
         displayObject.scaleY = 1;
         var scaleX:Number = maxWidth / displayObject.width;
         var scaleY:Number = maxHeight / displayObject.height;
         var minScale:Number = Math.min(scaleX,scaleY);
         minScale = Math.min(minScale,1);
         displayObject.scaleX = minScale;
         displayObject.scaleY = minScale;
      }
      
      public static function hitTestPoint(displayObject:DisplayObject, mouseX:Number, mouseY:Number, shapeFlag:Boolean = false, boundsAdd:Rectangle = null) : Boolean
      {
         var _loc6_:* = null;
         var globalPoint:* = null;
         var i:int = 0;
         if(displayObject == null || !displayObject.visible)
         {
            return false;
         }
         if(!shapeFlag)
         {
            _loc6_ = displayObject.getBounds(displayObject);
            if(boundsAdd != null)
            {
               _loc6_.x += boundsAdd.x;
               _loc6_.y += boundsAdd.y;
               _loc6_.width += boundsAdd.width;
               _loc6_.height += boundsAdd.height;
            }
            globalPoint = displayObject.localToGlobal(new Point(_loc6_.x,_loc6_.y));
            if(mouseX >= globalPoint.x && mouseY >= globalPoint.y)
            {
               globalPoint = displayObject.localToGlobal(new Point(_loc6_.x + _loc6_.width,_loc6_.y + _loc6_.height));
               if(mouseX < globalPoint.x && mouseY < globalPoint.y)
               {
                  return true;
               }
            }
            return false;
         }
         var _loc7_:DisplayObjectContainer = displayObject as DisplayObjectContainer;
         if(_loc7_)
         {
            for(i = 0; i < _loc7_.numChildren; )
            {
               if(hitTestPoint(_loc7_.getChildAt(i),mouseX,mouseY,shapeFlag))
               {
                  return true;
               }
               i++;
            }
            return false;
         }
         return displayObject.hitTestPoint(mouseX,mouseY,shapeFlag);
      }
   }
}
