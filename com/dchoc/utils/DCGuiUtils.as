package com.dchoc.utils
{
   import com.dchoc.projectdata.*;
   import flash.display.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class DCGuiUtils
   {
      public static const ARIAL_UNICODE_FONT:String = "Arial Unicode MS";
      
      public function DCGuiUtils()
      {
         super();
      }
      
      public static function checkTextFieldTextFormat(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         if(Boolean(ProjectManager.getProjectTexts().languageHasSpecialCharacters()) && Boolean(param1))
         {
            _loc2_ = 0;
            while(_loc2_ < param1.numChildren)
            {
               _loc3_ = param1.getChildAt(_loc2_);
               if(_loc3_ is TextField)
               {
                  setTextFieldTextFormat(TextField(_loc3_));
               }
               else if(_loc3_ is DisplayObjectContainer)
               {
                  checkTextFieldTextFormat(_loc3_ as DisplayObjectContainer);
               }
               _loc2_++;
            }
         }
      }
      
      public static function setTextFieldTextFormat(param1:TextField) : void
      {
         var _loc2_:String = null;
         var _loc3_:TextFormat = null;
         var _loc4_:int = 0;
         _loc4_ = 2;
         var _loc5_:int = 0;
         var _loc6_:TextFormat = null;
         if(param1.defaultTextFormat.font != "Arial Unicode MS")
         {
            _loc2_ = param1.text;
            _loc3_ = param1.defaultTextFormat;
            _loc5_ = int(_loc3_.size);
            _loc6_ = new TextFormat("Arial Unicode MS",_loc5_ > 10 ? _loc5_ - _loc4_ : _loc5_,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading);
            param1.defaultTextFormat = _loc6_;
            param1.useRichTextClipboard = true;
            param1.embedFonts = false;
            param1.text = _loc2_;
         }
      }
      
      public static function scaleToFitSize(param1:DisplayObject, param2:int, param3:int) : void
      {
         param1.scaleX = 1;
         param1.scaleY = 1;
         var _loc4_:Number = param2 / param1.width;
         var _loc5_:Number = param3 / param1.height;
         var _loc6_:Number = Math.min(_loc4_,_loc5_);
         _loc6_ = Math.min(_loc6_,1);
         param1.scaleX = _loc6_;
         param1.scaleY = _loc6_;
      }
      
      public static function hitTestPoint(param1:DisplayObject, param2:Number, param3:Number, param4:Boolean = false, param5:flash.geom.Rectangle = null) : Boolean
      {
         var _loc6_:flash.geom.Rectangle = null;
         var _loc7_:Point = null;
         var _loc8_:int = 0;
         if(param1 == null || !param1.visible)
         {
            return false;
         }
         if(!param4)
         {
            _loc6_ = param1.getBounds(param1);
            if(param5 != null)
            {
               _loc6_.x += param5.x;
               _loc6_.y += param5.y;
               _loc6_.width += param5.width;
               _loc6_.height += param5.height;
            }
            _loc7_ = param1.localToGlobal(new Point(_loc6_.x,_loc6_.y));
            if(param2 >= _loc7_.x && param3 >= _loc7_.y)
            {
               _loc7_ = param1.localToGlobal(new Point(_loc6_.x + _loc6_.width,_loc6_.y + _loc6_.height));
               if(param2 < _loc7_.x && param3 < _loc7_.y)
               {
                  return true;
               }
            }
            return false;
         }
         var _loc9_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(_loc9_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc9_.numChildren)
            {
               if(hitTestPoint(_loc9_.getChildAt(_loc8_),param2,param3,param4))
               {
                  return true;
               }
               _loc8_++;
            }
            return false;
         }
         return param1.hitTestPoint(param2,param3,param4);
      }
   }
}

