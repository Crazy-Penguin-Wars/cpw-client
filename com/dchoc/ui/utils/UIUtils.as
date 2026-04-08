package com.dchoc.ui.utils
{
   import com.dchoc.resources.*;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class UIUtils
   {
      public function UIUtils()
      {
         super();
      }
      
      public static function movieClipContainsLabel(param1:MovieClip, param2:String) : Boolean
      {
         return indexOfLabel(param1,param2) >= 0;
      }
      
      public static function indexOfLabel(param1:MovieClip, param2:String) : int
      {
         var _loc3_:* = 0;
         var _loc4_:Array = param1.currentLabels;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_].name == param2)
            {
               return _loc4_[_loc3_].frame - 1;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public static function removeAllChildren(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1.numChildren;
         while(true)
         {
            _loc2_--;
            if(_loc2_ < 0)
            {
               break;
            }
            param1.removeChildAt(0);
         }
      }
      
      public static function bringToFront(param1:DisplayObjectContainer, param2:DisplayObject) : void
      {
         param1.setChildIndex(param2,param1.numChildren - 1);
      }
      
      public static function duplicateDisplayObject(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         var _loc3_:flash.geom.Rectangle = null;
         var _loc4_:Class = Object(param1).constructor;
         var _loc5_:DisplayObject = new _loc4_();
         _loc5_.transform = param1.transform;
         _loc5_.filters = param1.filters;
         _loc5_.cacheAsBitmap = param1.cacheAsBitmap;
         _loc5_.opaqueBackground = param1.opaqueBackground;
         if(param1.scale9Grid)
         {
            _loc3_ = param1.scale9Grid;
            _loc5_.scale9Grid = _loc3_;
         }
         if(param2 && Boolean(param1.parent))
         {
            param1.parent.addChild(_loc5_);
         }
         return _loc5_;
      }
      
      public static function replaceDisplayObject(param1:DisplayObject, param2:DisplayObject, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc5_:DisplayObjectContainer = param1.parent;
         var _loc6_:int = _loc5_.getChildIndex(param1);
         _loc5_.removeChildAt(_loc6_);
         _loc5_.addChildAt(param2,_loc6_);
         param2.x = param1.x;
         param2.y = param1.y;
         param2.transform = param1.transform;
         if(param4)
         {
            scaleToFitSize(param2,param1.width,param1.height);
         }
         if(param3)
         {
            alignCentered(param2);
         }
      }
      
      public static function scaleToFitSize(param1:DisplayObject, param2:Number, param3:Number) : void
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
      
      public static function alignCentered(param1:DisplayObject) : void
      {
         var _loc2_:flash.geom.Rectangle = param1.getBounds(param1);
         var _loc3_:Number = _loc2_.x * param1.scaleX;
         var _loc4_:Number = _loc2_.y * param1.scaleY;
         var _loc5_:Number = _loc2_.width * 0.5 * param1.scaleX;
         var _loc6_:Number = _loc2_.height * 0.5 * param1.scaleY;
         param1.x = param1.x - _loc5_ + _loc3_;
         param1.y = param1.y - _loc6_ + _loc4_;
      }
      
      public static function getTransition(param1:String) : MovieClip
      {
         return DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf",param1);
      }
   }
}

