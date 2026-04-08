package com.dchoc.avatar
{
   import com.dchoc.avatar.paperdoll.*;
   import flash.display.MovieClip;
   import flash.filters.BitmapFilter;
   import flash.utils.*;
   
   public class UserAvatar extends MovieClip implements IAvatar
   {
      public static const TRACE_OUTPUT:Boolean = false;
      
      public static const INDEX_FOR_AVATAR:int = 0;
      
      public static const INDEX_FOR_SHADOW_IF_NOT_USE_SHADOW_LAYER:int = 0;
      
      public static const INDEX_FOR_AVATAR_IF_NOT_USE_SHADOW_LAYER:int = 1;
      
      public static const MALE_FEMALE:int = 4;
      
      public static const FEMALE:int = 2;
      
      public static const MALE:int = 1;
      
      public static const MALE_FEMALE_2_VERSIONS:int = 3;
      
      protected var _currentAnimation:AvatarAnimation;
      
      private var _paperdoll:PaperDoll;
      
      private var wornItems:Dictionary = new Dictionary(true);
      
      private var swfFileName:String;
      
      public function UserAvatar(param1:String, param2:Boolean = true, param3:Class = null)
      {
         super();
         this.swfFileName = param1;
         this.initialize();
         addChild(this._paperdoll);
      }
      
      public function dispose() : void
      {
         this._currentAnimation = null;
         if(this._paperdoll)
         {
            this._paperdoll.clean();
            this._paperdoll = null;
         }
         this.wornItems = null;
      }
      
      public function addBodyPart(param1:BodyPart) : void
      {
         this._paperdoll.addBodyPart(param1);
      }
      
      public function removeBodyPart(param1:BodyPart) : void
      {
         this._paperdoll.removeBodyPart(param1);
      }
      
      public function addFilter(param1:BitmapFilter) : void
      {
         this._paperdoll.filters = !!param1 ? [param1] : null;
      }
      
      public function putOnItem(param1:WearableItem) : Boolean
      {
         var _loc2_:ClothesSlot = null;
         if(param1)
         {
            _loc2_ = ClothesSlot.getSlotByID(param1.wearableSlot);
            this.wornItems[_loc2_] = param1;
            return this._paperdoll.wear(param1.swf,_loc2_);
         }
         return false;
      }
      
      public function putOnItems(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            this.setNaked();
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               this.putOnItem(param1[_loc2_] as WearableItem);
               _loc2_++;
            }
         }
      }
      
      public function get currentAnimation() : AvatarAnimation
      {
         return this._currentAnimation;
      }
      
      public function getItemWornAtSlotID(param1:int) : WearableItem
      {
         return this.wornItems[ClothesSlot.getSlotByID(param1)];
      }
      
      public function takeOffItem(param1:WearableItem) : void
      {
         var _loc2_:ClothesSlot = ClothesSlot.getSlotByID(param1.wearableSlot);
         this.wornItems[_loc2_] = null;
         this._paperdoll.unwear(_loc2_);
      }
      
      public function setNaked() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.wornItems)
         {
            this.takeOffItem(_loc1_);
         }
      }
      
      public function set gender(param1:int) : void
      {
         this._paperdoll.gender = param1;
         this.putOnItems(this.getWornItems());
      }
      
      public function get gender() : int
      {
         return this._paperdoll.gender;
      }
      
      public function set color(param1:IAvatarColor) : void
      {
         this._paperdoll.color = param1;
      }
      
      public function get color() : IAvatarColor
      {
         return this._paperdoll.color;
      }
      
      public function getWornItems() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:WearableItem = null;
         var _loc3_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < ClothesSlot.TYPE_NAMES.length)
         {
            _loc2_ = this.wornItems[ClothesSlot.getSlotByID(_loc1_)];
            if(_loc2_)
            {
               _loc3_.push(_loc2_);
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function getWornItemsIds() : String
      {
         var _loc1_:int = 0;
         var _loc2_:WearableItem = null;
         var _loc3_:* = "";
         _loc1_ = 0;
         while(_loc1_ < ClothesSlot.TYPE_NAMES.length)
         {
            _loc2_ = this.wornItems[ClothesSlot.getSlotByID(_loc1_)];
            if(_loc2_)
            {
               if(_loc3_ != "")
               {
                  _loc3_ += ",";
               }
               _loc3_ += "" + _loc2_.id;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function stopAnimation() : void
      {
         this._paperdoll.stopAnimation();
      }
      
      public function resumeAnimation() : void
      {
         this._paperdoll.resumeAnimation();
      }
      
      protected function getPaperDollClass() : Class
      {
         return PaperDoll;
      }
      
      private function initialize() : void
      {
         var _loc1_:Class = this.getPaperDollClass();
         this._paperdoll = new _loc1_(this.swfFileName,new AvatarColor(0,0,0),1);
      }
      
      private function getAnimFace(param1:Boolean) : String
      {
         return param1 ? "front" : "rear";
      }
      
      public function resetCurrentAnimation() : void
      {
         this._currentAnimation = null;
      }
      
      public function animate(param1:AvatarAnimation, param2:Boolean = true, param3:Function = null) : Boolean
      {
         this._currentAnimation = param1;
         this._paperdoll.changeAnimation(param1,param2,param3);
         return true;
      }
      
      public function get paperDoll() : PaperDoll
      {
         return this._paperdoll;
      }
      
      public function faceLeft() : void
      {
         if(this.isFacingRight())
         {
            this.flip();
         }
      }
      
      public function faceRight() : void
      {
         if(!this.isFacingRight())
         {
            this.flip();
         }
      }
      
      public function flip() : void
      {
         this._paperdoll.scaleX *= -1;
      }
      
      public function isFacingRight() : Boolean
      {
         return this._paperdoll.scaleX > 0;
      }
      
      public function show(param1:Boolean) : void
      {
         this._paperdoll.visible = param1;
      }
      
      public function isVisible() : Boolean
      {
         return this._paperdoll.visible;
      }
   }
}

