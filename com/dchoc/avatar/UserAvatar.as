package com.dchoc.avatar
{
   import com.dchoc.avatar.paperdoll.BodyPart;
   import com.dchoc.avatar.paperdoll.ClothesSlot;
   import com.dchoc.avatar.paperdoll.PaperDoll;
   import flash.display.MovieClip;
   import flash.filters.BitmapFilter;
   import flash.utils.Dictionary;
   
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
      
      private var wornItems:Dictionary;
      
      private var swfFileName:String;
      
      public function UserAvatar(fileName:String, addShadow:Boolean = true, avatarClass:Class = null)
      {
         wornItems = new Dictionary(true);
         super();
         swfFileName = fileName;
         initialize();
         addChild(_paperdoll);
      }
      
      public function dispose() : void
      {
         _currentAnimation = null;
         if(_paperdoll)
         {
            _paperdoll.clean();
            _paperdoll = null;
         }
         wornItems = null;
      }
      
      public function addBodyPart(bodyPart:BodyPart) : void
      {
         _paperdoll.addBodyPart(bodyPart);
      }
      
      public function removeBodyPart(bodyPart:BodyPart) : void
      {
         _paperdoll.removeBodyPart(bodyPart);
      }
      
      public function addFilter(filter:BitmapFilter) : void
      {
         _paperdoll.filters = !!filter ? [filter] : null;
      }
      
      public function putOnItem(item:WearableItem) : Boolean
      {
         var _loc2_:* = null;
         if(item)
         {
            _loc2_ = ClothesSlot.getSlotByID(item.wearableSlot);
            wornItems[_loc2_] = item;
            return _paperdoll.wear(item.swf,_loc2_);
         }
         return false;
      }
      
      public function putOnItems(items:Array) : void
      {
         var i:int = 0;
         if(items)
         {
            setNaked();
            for(i = 0; i < items.length; )
            {
               putOnItem(items[i] as WearableItem);
               i++;
            }
         }
      }
      
      public function get currentAnimation() : AvatarAnimation
      {
         return _currentAnimation;
      }
      
      public function getItemWornAtSlotID(slotID:int) : WearableItem
      {
         return wornItems[ClothesSlot.getSlotByID(slotID)];
      }
      
      public function takeOffItem(item:WearableItem) : void
      {
         var _loc2_:ClothesSlot = ClothesSlot.getSlotByID(item.wearableSlot);
         wornItems[_loc2_] = null;
         _paperdoll.unwear(_loc2_);
      }
      
      public function setNaked() : void
      {
         for each(var item in wornItems)
         {
            takeOffItem(item);
         }
      }
      
      public function set gender(value:int) : void
      {
         _paperdoll.gender = value;
         putOnItems(getWornItems());
      }
      
      public function get gender() : int
      {
         return _paperdoll.gender;
      }
      
      public function set color(value:IAvatarColor) : void
      {
         _paperdoll.color = value;
      }
      
      public function get color() : IAvatarColor
      {
         return _paperdoll.color;
      }
      
      public function getWornItems() : Array
      {
         var i:int = 0;
         var _loc2_:* = null;
         var _loc1_:Array = [];
         for(i = 0; i < ClothesSlot.TYPE_NAMES.length; )
         {
            _loc2_ = wornItems[ClothesSlot.getSlotByID(i)];
            if(_loc2_)
            {
               _loc1_.push(_loc2_);
            }
            i++;
         }
         return _loc1_;
      }
      
      public function getWornItemsIds() : String
      {
         var i:int = 0;
         var _loc2_:* = null;
         var items:String = "";
         for(i = 0; i < ClothesSlot.TYPE_NAMES.length; )
         {
            _loc2_ = wornItems[ClothesSlot.getSlotByID(i)];
            if(_loc2_)
            {
               if(items != "")
               {
                  items += ",";
               }
               items += "" + _loc2_.id;
            }
            i++;
         }
         return items;
      }
      
      public function stopAnimation() : void
      {
         _paperdoll.stopAnimation();
      }
      
      public function resumeAnimation() : void
      {
         _paperdoll.resumeAnimation();
      }
      
      protected function getPaperDollClass() : Class
      {
         return PaperDoll;
      }
      
      private function initialize() : void
      {
         var _loc1_:Class = getPaperDollClass();
         _paperdoll = new _loc1_(swfFileName,new AvatarColor(0,0,0),1);
      }
      
      private function getAnimFace(isFacingDown:Boolean) : String
      {
         return isFacingDown ? "front" : "rear";
      }
      
      public function resetCurrentAnimation() : void
      {
         _currentAnimation = null;
      }
      
      public function animate(anim:AvatarAnimation, showTransition:Boolean = true, callThisFunctionWhenAnimationStarts:Function = null) : Boolean
      {
         _currentAnimation = anim;
         _paperdoll.changeAnimation(anim,showTransition,callThisFunctionWhenAnimationStarts);
         return true;
      }
      
      public function get paperDoll() : PaperDoll
      {
         return _paperdoll;
      }
      
      public function faceLeft() : void
      {
         if(isFacingRight())
         {
            flip();
         }
      }
      
      public function faceRight() : void
      {
         if(!isFacingRight())
         {
            flip();
         }
      }
      
      public function flip() : void
      {
         _paperdoll.scaleX *= -1;
      }
      
      public function isFacingRight() : Boolean
      {
         return _paperdoll.scaleX > 0;
      }
      
      public function show(visible:Boolean) : void
      {
         _paperdoll.visible = visible;
      }
      
      public function isVisible() : Boolean
      {
         return _paperdoll.visible;
      }
   }
}
