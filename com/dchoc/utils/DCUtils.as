package com.dchoc.utils
{
   import com.dchoc.game.*;
   import flash.display.*;
   import flash.external.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.*;
   import flash.utils.*;
   
   public class DCUtils
   {
      private static const CLASS_MAP:Object = {};
      
      public function DCUtils()
      {
         super();
      }
      
      public static function getClassDefinitionByName(param1:String) : Class
      {
         if(!CLASS_MAP.hasOwnProperty(param1))
         {
            CLASS_MAP[param1] = getDefinitionByName(param1) as Class;
         }
         return CLASS_MAP[param1];
      }
      
      public static function propertyNames(param1:Object) : Vector.<String>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<String> = new Vector.<String>();
         for(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function toArray(param1:*) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function find(param1:*, param2:String, param3:*) : *
      {
         var _loc4_:* = undefined;
         for each(_loc4_ in param1)
         {
            if(_loc4_.hasOwnProperty(param2))
            {
               if(_loc4_[param2] is Function && _loc4_[param2]() == param3)
               {
                  return _loc4_;
               }
               if(_loc4_[param2] == param3)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public static function findAll(param1:*, param2:*, param3:String) : Array
      {
         var _loc5_:* = undefined;
         var _loc4_:Array = [];
         for each(_loc5_ in param1)
         {
            if(Boolean(_loc5_.hasOwnProperty(param3)) && _loc5_[param3] == param2)
            {
               _loc4_.push(_loc5_);
            }
         }
         return _loc4_;
      }
      
      public static function deleteProperties(param1:Object) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in param1)
         {
            delete param1[_loc2_];
         }
      }
      
      public static function objectToString(param1:Object) : String
      {
         var _loc3_:* = undefined;
         var _loc2_:String = "";
         for(_loc3_ in param1)
         {
            _loc2_ += _loc3_ + ": " + param1[_loc3_] + ", ";
         }
         return _loc2_.substring(0,_loc2_.length - 2);
      }
      
      public static function bringToFront(param1:DisplayObjectContainer, param2:DisplayObject) : void
      {
         param1.setChildIndex(param2,param1.numChildren - 1);
      }
      
      public static function strStartsWith(param1:String, param2:String) : Boolean
      {
         return !param1.indexOf(param2);
      }
      
      public static function replaceSubstring(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:int = int(param1.indexOf(param2));
         return _loc4_ >= 0 ? param1.substring(0,_loc4_) + param3 + param1.substring(_loc4_ + param2.length) : param1;
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
      
      public static function centerClip(param1:DisplayObject) : void
      {
         param1.x = DCGame.getStage().stageWidth >> 1;
         param1.y = DCGame.getStage().stageHeight >> 1;
      }
      
      public static function getChildByPath(param1:DisplayObjectContainer, param2:String) : DisplayObject
      {
         var _loc3_:int = 0;
         if(!param2 || param2 == "")
         {
            return param1;
         }
         var _loc4_:Array = param2.split("/");
         var _loc5_:* = param1;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length - 1)
         {
            _loc5_ = _loc5_.getChildByName(_loc4_[_loc3_]) as DisplayObjectContainer;
            _loc3_++;
         }
         return !!_loc5_ ? _loc5_.getChildByName(_loc4_[_loc3_]) : null;
      }
      
      public static function replaceDisplayObject(param1:DisplayObject, param2:DisplayObject, param3:Boolean = false, param4:Boolean = false, param5:Boolean = true) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         var _loc6_:DisplayObjectContainer = param1.parent;
         if(!_loc6_)
         {
            LogUtils.log("[ERROR PREVENTED] DCUtils.replaceDisplayObject() trying to replace a display object that does not have a parent",DCUtils,2,"ErrorLogging",true,false,false);
            return;
         }
         var _loc7_:int = _loc6_.getChildIndex(param1);
         if(param5)
         {
            param2.name = param1.name;
         }
         _loc6_.removeChildAt(_loc7_);
         _loc6_.addChildAt(param2,_loc7_);
         copyTransform(param1,param2);
         if(param4)
         {
            if(param1.width > 0 && param1.height > 0)
            {
               DCGuiUtils.scaleToFitSize(param2,param1.width,param1.height);
            }
            else
            {
               LogUtils.log("Skipping scaling of image because it will become height or width is 0, this may need some improvement in cases where we actualy wish to scale to 0",DCUtils,2,"ErrorLogging",false,false,true);
            }
         }
         if(param3)
         {
            DCUtils.alignCentered(param2);
         }
      }
      
      public static function copyTransform(param1:DisplayObject, param2:DisplayObject) : void
      {
         param2.x = param1.x;
         param2.y = param1.y;
         param2.rotation = param1.rotation;
         param2.scaleX = param1.scaleX;
         param2.scaleY = param1.scaleY;
      }
      
      public static function removeChildren(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1.numChildren - 1;
         while(_loc2_ >= 0)
         {
            param1.removeChildAt(_loc2_);
            _loc2_--;
         }
      }
      
      public static function stopMovieClip(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         param1.stop();
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_) as MovieClip;
            if(_loc3_)
            {
               stopMovieClip(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public static function playMovieClip(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         param1.play();
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_) as MovieClip;
            if(_loc3_)
            {
               playMovieClip(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public static function disposeAllBitmapData(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_ is Bitmap)
            {
               Bitmap(_loc3_).bitmapData.dispose();
            }
            else if(_loc3_ is DisplayObjectContainer)
            {
               disposeAllBitmapData(_loc3_ as DisplayObjectContainer);
            }
            _loc2_++;
         }
      }
      
      public static function movieClipContainsLabel(param1:MovieClip, param2:String) : Boolean
      {
         return indexOfLabel(param1,param2) >= 0;
      }
      
      public static function indexOfLabel(param1:MovieClip, param2:String) : int
      {
         var _loc4_:* = undefined;
         var _loc3_:Array = param1.currentLabels;
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.name == param2)
            {
               return _loc4_.frame - 1;
            }
         }
         return -1;
      }
      
      public static function refreshPage() : void
      {
         ExternalInterface.call("fromFlash","reload");
      }
      
      public static function loadPage(param1:String, param2:String = "_parent") : void
      {
         LogUtils.log("Call to link: " + param1 + " (" + param2 + ")",DCUtils,0,"ErrorLogging",false,false,false);
         if(param1)
         {
            navigateToURL(new URLRequest(param1),param2);
         }
      }
      
      public static function setBitmapSmoothing(param1:Boolean, param2:MovieClip) : void
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         if(param2 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.numChildren)
            {
               _loc4_ = param2.getChildAt(_loc3_);
               if(_loc4_ is MovieClip)
               {
                  setBitmapSmoothing(param1,_loc4_ as MovieClip);
               }
               else if(_loc4_ is Bitmap)
               {
                  Bitmap(_loc4_).smoothing = param1;
               }
               _loc3_++;
            }
         }
      }
      
      public static function localToLocal(param1:Point, param2:DisplayObject, param3:DisplayObject) : Point
      {
         var _loc4_:Point = param2.localToGlobal(param1);
         return param3.globalToLocal(_loc4_);
      }
      
      public static function takeScreenShot() : Bitmap
      {
         var _loc3_:Bitmap = null;
         var _loc1_:MovieClip = DCGame.getMainMovieClip();
         var _loc2_:BitmapData = new BitmapData(DCGame.getStage().stageWidth,DCGame.getStage().stageHeight);
         _loc2_.draw(_loc1_);
         _loc3_ = new Bitmap(_loc2_);
         _loc3_.x = -DCGame.getStage().stageWidth * 0.5;
         _loc3_.y = -DCGame.getStage().stageHeight * 0.5;
         return _loc3_;
      }
      
      public static function addToOther(param1:*, param2:*) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1)
         {
            param2.push(_loc3_);
         }
      }
      
      public static function getBrowser() : String
      {
         var userAgent:String = null;
         var browser:String = null;
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

