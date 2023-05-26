package com.dchoc.utils
{
   import com.dchoc.game.DCGame;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getDefinitionByName;
   
   public class DCUtils
   {
      
      private static const CLASS_MAP:Object = {};
       
      
      public function DCUtils()
      {
         super();
      }
      
      public static function getClassDefinitionByName(className:String) : Class
      {
         if(!CLASS_MAP.hasOwnProperty(className))
         {
            CLASS_MAP[className] = getDefinitionByName(className) as Class;
         }
         return CLASS_MAP[className];
      }
      
      public static function propertyNames(obj:Object) : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         for(var name in obj)
         {
            _loc2_.push(name);
         }
         return _loc2_;
      }
      
      public static function toArray(iterable:*) : Array
      {
         var _loc3_:Array = [];
         for each(var elem in iterable)
         {
            _loc3_.push(elem);
         }
         return _loc3_;
      }
      
      public static function find(from:*, prop:String, target:*) : *
      {
         for each(var obj in from)
         {
            if(obj.hasOwnProperty(prop))
            {
               if(obj[prop] is Function && obj[prop]() == target)
               {
                  return obj;
               }
               if(obj[prop] == target)
               {
                  return obj;
               }
            }
         }
         return null;
      }
      
      public static function findAll(from:*, target:*, prop:String) : Array
      {
         var _loc4_:Array = [];
         for each(var obj in from)
         {
            if(obj.hasOwnProperty(prop) && obj[prop] == target)
            {
               _loc4_.push(obj);
            }
         }
         return _loc4_;
      }
      
      public static function deleteProperties(obj:Object) : void
      {
         for(var prop in obj)
         {
            delete obj[prop];
         }
      }
      
      public static function objectToString(obj:Object) : String
      {
         var str:String = "";
         for(var prop in obj)
         {
            str += prop + ": " + obj[prop] + ", ";
         }
         return str.substring(0,str.length - 2);
      }
      
      public static function bringToFront(container:DisplayObjectContainer, mc:DisplayObject) : void
      {
         container.setChildIndex(mc,container.numChildren - 1);
      }
      
      public static function strStartsWith(str:String, startwith:String) : Boolean
      {
         return !str.indexOf(startwith);
      }
      
      public static function replaceSubstring(source:String, replace:String, by:String) : String
      {
         var _loc4_:int = source.indexOf(replace);
         return _loc4_ >= 0 ? source.substring(0,_loc4_) + by + source.substring(_loc4_ + replace.length) : source;
      }
      
      public static function alignCentered(newObject:DisplayObject) : void
      {
         var _loc2_:Rectangle = newObject.getBounds(newObject);
         var _loc6_:Number = _loc2_.x * newObject.scaleX;
         var _loc5_:Number = _loc2_.y * newObject.scaleY;
         var _loc3_:Number = _loc2_.width * 0.5 * newObject.scaleX;
         var _loc4_:Number = _loc2_.height * 0.5 * newObject.scaleY;
         newObject.x = newObject.x - _loc3_ + _loc6_;
         newObject.y = newObject.y - _loc4_ + _loc5_;
      }
      
      public static function centerClip(clip:DisplayObject) : void
      {
         var _loc2_:DCGame = DCGame;
         clip.x = Number(com.dchoc.game.DCGame._stage.stageWidth) >> 1;
         var _loc3_:DCGame = DCGame;
         clip.y = Number(com.dchoc.game.DCGame._stage.stageHeight) >> 1;
      }
      
      public static function getChildByPath(mc:DisplayObjectContainer, path:String) : DisplayObject
      {
         var i:int = 0;
         if(!path || path == "")
         {
            return mc;
         }
         var _loc4_:Array = path.split("/");
         var currentMc:* = mc;
         for(i = 0; i < _loc4_.length - 1; )
         {
            currentMc = currentMc.getChildByName(_loc4_[i]) as DisplayObjectContainer;
            i++;
         }
         return !!currentMc ? currentMc.getChildByName(_loc4_[i]) : null;
      }
      
      public static function replaceDisplayObject(oldObject:DisplayObject, newObject:DisplayObject, alignCentered:Boolean = false, scaleToSameSize:Boolean = false, changeName:Boolean = true) : void
      {
         if(!oldObject || !newObject)
         {
            return;
         }
         var _loc7_:DisplayObjectContainer = oldObject.parent;
         if(!_loc7_)
         {
            LogUtils.log("[ERROR PREVENTED] DCUtils.replaceDisplayObject() trying to replace a display object that does not have a parent",DCUtils,2,"ErrorLogging",true,false,false);
            return;
         }
         var _loc6_:int = _loc7_.getChildIndex(oldObject);
         if(changeName)
         {
            newObject.name = oldObject.name;
         }
         _loc7_.removeChildAt(_loc6_);
         _loc7_.addChildAt(newObject,_loc6_);
         copyTransform(oldObject,newObject);
         if(scaleToSameSize)
         {
            if(oldObject.width > 0 && oldObject.height > 0)
            {
               DCGuiUtils.scaleToFitSize(newObject,oldObject.width,oldObject.height);
            }
            else
            {
               LogUtils.log("Skipping scaling of image because it will become height or width is 0, this may need some improvement in cases where we actualy wish to scale to 0",DCUtils,2,"ErrorLogging",false,false,true);
            }
         }
         if(alignCentered)
         {
            DCUtils.alignCentered(newObject);
         }
      }
      
      public static function copyTransform(source:DisplayObject, target:DisplayObject) : void
      {
         target.x = source.x;
         target.y = source.y;
         target.rotation = source.rotation;
         target.scaleX = source.scaleX;
         target.scaleY = source.scaleY;
      }
      
      public static function removeChildren(container:DisplayObjectContainer) : void
      {
         var i:int = 0;
         for(i = container.numChildren - 1; i >= 0; )
         {
            container.removeChildAt(i);
            i--;
         }
      }
      
      public static function stopMovieClip(mc:MovieClip) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         mc.stop();
         for(i = 0; i < mc.numChildren; )
         {
            _loc2_ = mc.getChildAt(i) as MovieClip;
            if(_loc2_)
            {
               stopMovieClip(_loc2_);
            }
            i++;
         }
      }
      
      public static function playMovieClip(mc:MovieClip) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         mc.play();
         for(i = 0; i < mc.numChildren; )
         {
            _loc2_ = mc.getChildAt(i) as MovieClip;
            if(_loc2_)
            {
               playMovieClip(_loc2_);
            }
            i++;
         }
      }
      
      public static function disposeAllBitmapData(parent:DisplayObjectContainer) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         for(i = 0; i < parent.numChildren; )
         {
            _loc2_ = parent.getChildAt(i);
            if(_loc2_ is Bitmap)
            {
               Bitmap(_loc2_).bitmapData.dispose();
            }
            else if(_loc2_ is DisplayObjectContainer)
            {
               disposeAllBitmapData(_loc2_ as DisplayObjectContainer);
            }
            i++;
         }
      }
      
      public static function movieClipContainsLabel(clip:MovieClip, label:String) : Boolean
      {
         return indexOfLabel(clip,label) >= 0;
      }
      
      public static function indexOfLabel(clip:MovieClip, label:String) : int
      {
         var _loc3_:Array = clip.currentLabels;
         for each(var frameLabel in _loc3_)
         {
            if(frameLabel.name == label)
            {
               return frameLabel.frame - 1;
            }
         }
         return -1;
      }
      
      public static function refreshPage() : void
      {
         ExternalInterface.call("fromFlash","reload");
      }
      
      public static function loadPage(link:String, window:String = "_parent") : void
      {
         LogUtils.log("Call to link: " + link + " (" + window + ")",DCUtils,0,"ErrorLogging",false,false,false);
         if(link)
         {
            navigateToURL(new URLRequest(link),window);
         }
      }
      
      public static function setBitmapSmoothing(value:Boolean, mc:MovieClip) : void
      {
         var i:int = 0;
         var _loc3_:* = null;
         if(mc != null)
         {
            for(i = 0; i < mc.numChildren; )
            {
               _loc3_ = mc.getChildAt(i);
               if(_loc3_ is MovieClip)
               {
                  setBitmapSmoothing(value,_loc3_ as MovieClip);
               }
               else if(_loc3_ is Bitmap)
               {
                  Bitmap(_loc3_).smoothing = value;
               }
               i++;
            }
         }
      }
      
      public static function localToLocal(point:Point, firstDisplayObject:DisplayObject, secondDisplayObject:DisplayObject) : Point
      {
         var _loc4_:Point = firstDisplayObject.localToGlobal(point);
         return secondDisplayObject.globalToLocal(_loc4_);
      }
      
      public static function takeScreenShot() : Bitmap
      {
         var _loc3_:MovieClip = DCGame.getMainMovieClip();
         var _loc4_:DCGame = DCGame;
         var _loc5_:DCGame = DCGame;
         var _loc1_:BitmapData = new BitmapData(com.dchoc.game.DCGame._stage.stageWidth,com.dchoc.game.DCGame._stage.stageHeight);
         _loc1_.draw(_loc3_);
         var _loc2_:Bitmap = new Bitmap(_loc1_);
         var _loc6_:DCGame = DCGame;
         _loc2_.x = -Number(com.dchoc.game.DCGame._stage.stageWidth) * 0.5;
         var _loc7_:DCGame = DCGame;
         _loc2_.y = -Number(com.dchoc.game.DCGame._stage.stageHeight) * 0.5;
         return _loc2_;
      }
      
      public static function addToOther(from:*, to:*) : void
      {
         for each(var obj in from)
         {
            to.push(obj);
         }
      }
      
      public static function getBrowser() : String
      {
         var userAgent:* = null;
         var browser:* = null;
         try
         {
            userAgent = ExternalInterface.call("window.navigator.userAgent.toString");
            browser = "[Unknown]";
            if(userAgent.indexOf("Safari") != -1)
            {
               browser = "Safari";
            }
            if(userAgent.indexOf("Firefox") != -1)
            {
               browser = "Firefox";
            }
            if(userAgent.indexOf("Chrome") != -1)
            {
               browser = "Chrome";
            }
            if(userAgent.indexOf("MSIE") != -1)
            {
               browser = "Internet_Explorer";
            }
            if(userAgent.indexOf("Opera") != -1)
            {
               browser = "Opera";
            }
         }
         catch(e:Error)
         {
            return "[NoExternalInterface]";
         }
         return browser;
      }
   }
}
