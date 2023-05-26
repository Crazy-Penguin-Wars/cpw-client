package com.dchoc.ui.utils
{
   import com.dchoc.resources.DCResourceManager;
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
      
      public static function movieClipContainsLabel(clip:MovieClip, label:String) : Boolean
      {
         return indexOfLabel(clip,label) >= 0;
      }
      
      public static function indexOfLabel(clip:MovieClip, label:String) : int
      {
         var i:* = 0;
         var _loc3_:Array = clip.currentLabels;
         for(i = 0; i < _loc3_.length; )
         {
            if(_loc3_[i].name == label)
            {
               return Number(_loc3_[i].frame) - 1;
            }
            i++;
         }
         return -1;
      }
      
      public static function removeAllChildren(container:DisplayObjectContainer) : void
      {
         var i:int = 0;
         i = container.numChildren;
         while(true)
         {
            i--;
            if(i < 0)
            {
               break;
            }
            container.removeChildAt(0);
         }
      }
      
      public static function bringToFront(container:DisplayObjectContainer, mc:DisplayObject) : void
      {
         container.setChildIndex(mc,container.numChildren - 1);
      }
      
      public static function duplicateDisplayObject(target:DisplayObject, autoAdd:Boolean = false) : DisplayObject
      {
         var rect:* = null;
         var targetClass:Class = Object(target).constructor;
         var duplicate:DisplayObject = new targetClass();
         duplicate.transform = target.transform;
         duplicate.filters = target.filters;
         duplicate.cacheAsBitmap = target.cacheAsBitmap;
         duplicate.opaqueBackground = target.opaqueBackground;
         if(target.scale9Grid)
         {
            rect = target.scale9Grid;
            duplicate.scale9Grid = rect;
         }
         if(autoAdd && target.parent)
         {
            target.parent.addChild(duplicate);
         }
         return duplicate;
      }
      
      public static function replaceDisplayObject(oldObject:DisplayObject, newObject:DisplayObject, isAlignCentered:Boolean = false, scaleToSameSize:Boolean = false) : void
      {
         if(oldObject == null || newObject == null)
         {
            return;
         }
         var container:DisplayObjectContainer = oldObject.parent;
         var index:int = container.getChildIndex(oldObject);
         container.removeChildAt(index);
         container.addChildAt(newObject,index);
         newObject.x = oldObject.x;
         newObject.y = oldObject.y;
         newObject.transform = oldObject.transform;
         if(scaleToSameSize)
         {
            scaleToFitSize(newObject,oldObject.width,oldObject.height);
         }
         if(isAlignCentered)
         {
            alignCentered(newObject);
         }
      }
      
      public static function scaleToFitSize(displayObject:DisplayObject, maxWidth:Number, maxHeight:Number) : void
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
      
      public static function alignCentered(newObject:DisplayObject) : void
      {
         var bounds:Rectangle = newObject.getBounds(newObject);
         var x:Number = bounds.x * newObject.scaleX;
         var y:Number = bounds.y * newObject.scaleY;
         var halfW:Number = bounds.width * 0.5 * newObject.scaleX;
         var halfH:Number = bounds.height * 0.5 * newObject.scaleY;
         newObject.x = newObject.x - halfW + x;
         newObject.y = newObject.y - halfH + y;
      }
      
      public static function getTransition(name:String) : MovieClip
      {
         return DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf",name);
      }
   }
}
