package com.dchoc.avatar.paperdoll
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.avatar.AvatarColor;
   import com.dchoc.avatar.IAvatarColor;
   import com.dchoc.avatar.paperdoll.animations.PaperDollAnimation;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class PaperDoll extends MovieClip
   {
       
      
      private const bodyParts:Vector.<BodyPart> = new Vector.<BodyPart>();
      
      private var _currentAnimation:PaperDollAnimation;
      
      private var currentAnimationCallback:Function;
      
      private var currentClothes:Dictionary;
      
      private var _color:IAvatarColor;
      
      private var _gender:int;
      
      private var nextAnimationName:String;
      
      private var nextAnimLoop:Boolean;
      
      private var nextPlayOnceAndCallThisFunction:Function;
      
      private var nextCallThisFunctionWhenAnimationStarts:Function;
      
      private var _swfFileName:String;
      
      public function PaperDoll(swfFileName:String, color:AvatarColor, gender:int)
      {
         currentClothes = new Dictionary(true);
         super();
         _swfFileName = swfFileName;
         _color = color;
         _gender = gender;
      }
      
      public function clean() : void
      {
         if(_currentAnimation)
         {
            _currentAnimation.dispose();
            _currentAnimation = null;
         }
         if(currentClothes)
         {
            for(var i in currentClothes)
            {
               if(currentClothes[i])
               {
                  currentClothes[i].clean();
                  currentClothes[i] = null;
               }
            }
            currentClothes = null;
         }
         nextPlayOnceAndCallThisFunction = null;
         nextCallThisFunctionWhenAnimationStarts = null;
         bodyParts.splice(0,bodyParts.length);
      }
      
      public function addBodyPart(bodyPart:BodyPart) : void
      {
         if(!containsBodyPart(bodyPart))
         {
            bodyParts.push(bodyPart);
         }
      }
      
      public function removeBodyPart(bodyPart:BodyPart) : void
      {
         var _loc2_:int = indexOf(bodyPart);
         if(_loc2_ != -1)
         {
            bodyParts.splice(_loc2_,1);
         }
      }
      
      public function indexOf(bodyPart:BodyPart) : int
      {
         var i:int = 0;
         for(i = 0; i < bodyParts.length; )
         {
            if(bodyPart.equals(bodyParts[i]))
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function containsBodyPart(other:BodyPart) : Boolean
      {
         for each(var bodyPart in bodyParts)
         {
            if(bodyPart.equals(other))
            {
               return true;
            }
         }
         return false;
      }
      
      public function wear(fileName:String, slot:ClothesSlot, removeItemOnThisSlot:Boolean = true) : Boolean
      {
         if(!fileName)
         {
            return false;
         }
         if(removeItemOnThisSlot)
         {
            unwear(slot);
         }
         var _loc4_:Array = addClothes(fileName,bodyParts,currentClothes[slot] != null ? currentClothes[slot].clips : null);
         if(_loc4_.length > 0)
         {
            currentClothes[slot] = new CurrentClothes(_loc4_,fileName);
         }
         color = _color;
         return _loc4_.length > 0;
      }
      
      private function wearClothes(clothes:CurrentClothes, slot:ClothesSlot) : void
      {
         var _loc3_:Array = addClothes(clothes.fileName,bodyParts,clothes.clips);
         if(_loc3_.length > 0)
         {
            currentClothes[slot] = new CurrentClothes(_loc3_,clothes.fileName);
         }
      }
      
      public function unwear(slot:ClothesSlot) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var i:int = 0;
         var _loc2_:* = null;
         if(currentClothes[slot])
         {
            _loc4_ = CurrentClothes(currentClothes[slot]).clips;
            _loc3_ = _loc4_.length;
            for(i = 0; i < _loc3_; )
            {
               _loc2_ = _loc4_[i];
               _loc2_.parent.removeChild(_loc2_);
               i++;
            }
            currentClothes[slot].clean();
            currentClothes[slot] = null;
            delete currentClothes[slot];
         }
      }
      
      protected function createAnimation(mc:MovieClip, loopAnim:Boolean = true, callback:Function = null) : void
      {
         var i:int = 0;
         if(_currentAnimation)
         {
            _currentAnimation.dispose();
         }
         for(i = numChildren - 1; i >= 0; )
         {
            removeChildAt(i);
            i--;
         }
         if(mc)
         {
            _currentAnimation = new PaperDollAnimation(mc,true,loopAnim,callback);
            addChild(_currentAnimation);
            color = _color;
            gender = _gender;
            redrawCurrentClothes();
         }
      }
      
      public function changeAnimation(anim:AvatarAnimation, showTransition:Boolean = true, callThisFunctionWhenAnimationStarts:Function = null) : void
      {
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF(_swfFileName,anim.classDefinitionName);
         if(_loc4_)
         {
            nextAnimationName = null;
            _loc4_.name = anim.classDefinitionName;
            createAnimation(_loc4_,anim.isLooping(),anim.callback);
            if(callThisFunctionWhenAnimationStarts != null)
            {
               callThisFunctionWhenAnimationStarts();
            }
         }
      }
      
      public function addFrameScriptToAnimation(label:String, callback:Function) : void
      {
         var _loc3_:int = 0;
         if(_currentAnimation)
         {
            _loc3_ = DCUtils.indexOfLabel(_currentAnimation.clip,label);
            _currentAnimation.clip.addFrameScript(_loc3_,callback);
         }
      }
      
      private function startNextAnimation() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(currentAnimationCallback != null)
         {
            _loc2_ = currentAnimationCallback;
            currentAnimationCallback = null;
            _loc2_();
         }
         if(nextAnimationName != null)
         {
            _loc1_ = DCResourceManager.instance.getFromSWF(_swfFileName,nextAnimationName);
            createAnimation(_loc1_,nextAnimLoop,nextPlayOnceAndCallThisFunction);
            nextAnimationName = null;
            nextPlayOnceAndCallThisFunction = null;
            if(nextCallThisFunctionWhenAnimationStarts != null)
            {
               nextCallThisFunctionWhenAnimationStarts();
               nextCallThisFunctionWhenAnimationStarts = null;
            }
         }
      }
      
      public function redrawCurrentClothes() : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         for(i = 0; i < ClothesSlot.TYPE_NAMES.length; )
         {
            _loc2_ = ClothesSlot.getSlotByID(i);
            _loc1_ = currentClothes[_loc2_];
            if(_loc1_)
            {
               wearClothes(_loc1_,_loc2_);
            }
            else
            {
               unwear(_loc2_);
            }
            i++;
         }
      }
      
      public function stopAnimation() : void
      {
         if(_currentAnimation)
         {
            _currentAnimation.clean();
         }
      }
      
      public function resumeAnimation() : void
      {
         if(_currentAnimation)
         {
            _currentAnimation.play();
         }
      }
      
      private function addClothes(filename:String, bodyParts:Vector.<BodyPart>, prevClothes:Array = null) : Array
      {
         var i:int = 0;
         var _loc4_:* = null;
         var _loc10_:* = null;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc11_:* = null;
         var _loc7_:Array = [];
         var _loc5_:MovieClip = _currentAnimation.getChildAt(0) as MovieClip;
         if(_loc5_)
         {
            for(i = 0; i < bodyParts.length; )
            {
               _loc4_ = bodyParts[i];
               _loc10_ = _loc4_.getClipName();
               _loc6_ = DCUtils.getChildByPath(_loc5_,_loc10_) as MovieClip;
               _loc9_ = _loc4_.getClassName();
               _loc8_ = getClothClip(filename,_loc9_,prevClothes);
               if(_loc6_ && _loc8_)
               {
                  _loc6_.addChild(_loc8_);
                  _loc11_ = _loc8_ as DisplayObjectContainer;
                  if(!_loc11_ || _loc11_.numChildren > 0)
                  {
                     _loc7_.push(_loc8_);
                  }
               }
               i++;
            }
         }
         return _loc7_;
      }
      
      private function getClothClip(filename:String, className:String, prevClothes:Array = null) : MovieClip
      {
         if(prevClothes)
         {
            for each(var prevClip in prevClothes)
            {
               if(prevClip.name == className)
               {
                  return prevClip;
               }
            }
         }
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF(filename,className);
         if(_loc4_)
         {
            _loc4_.name = className;
         }
         return _loc4_;
      }
      
      public function set color(value:IAvatarColor) : void
      {
         _color = value;
         if(!_color)
         {
            return;
         }
         applyColor(_currentAnimation,_color);
      }
      
      public function get color() : IAvatarColor
      {
         return _color;
      }
      
      private function applyColor(mc:DisplayObjectContainer, color:IAvatarColor) : void
      {
         var i:int = 0;
         var _loc3_:* = null;
         if(!mc)
         {
            return;
         }
         i = 0;
         while(i < mc.numChildren)
         {
            _loc3_ = mc.getChildAt(i);
            setColor(_loc3_,color);
            applyColor(_loc3_ as DisplayObjectContainer,color);
            i++;
         }
      }
      
      private function setColor(mc:DisplayObject, color:IAvatarColor) : void
      {
         if(mc.name == "colorable")
         {
            mc.transform.colorTransform = color.colorTransform;
         }
      }
      
      private function getBodyPartClip(clipName:String) : MovieClip
      {
         var _loc4_:* = null;
         var j:int = 0;
         var anim:MovieClip = _currentAnimation.getChildAt(0) as MovieClip;
         var clip:* = clipName;
         if(clip.indexOf("/") != -1)
         {
            _loc4_ = clip.split("/");
            for(j = 0; j < _loc4_.length - 1; )
            {
               anim = anim[_loc4_[j]];
               if(!anim)
               {
                  return null;
               }
               j++;
            }
            clip = _loc4_[j];
         }
         return anim[clip];
      }
      
      public function getAnimationElapsedPercentage() : int
      {
         return _currentAnimation.getAnimationElapsedPercentage();
      }
      
      public function get animation() : PaperDollAnimation
      {
         return _currentAnimation;
      }
      
      public function set gender(gender:int) : void
      {
         _gender = gender;
      }
      
      public function get gender() : int
      {
         return _gender;
      }
      
      public function getClothesInSlot(slot:ClothesSlot) : Array
      {
         if(currentClothes[slot])
         {
            return currentClothes[slot].clips;
         }
         return null;
      }
   }
}

class CurrentClothes
{
    
   
   private var _clips:Array;
   
   private var _fileName:String;
   
   public function CurrentClothes(clips:Array, fileName:String)
   {
      super();
      _clips = clips;
      _fileName = fileName;
   }
   
   public function clean() : void
   {
      _clips = null;
      _fileName = null;
   }
   
   private function get clips() : Array
   {
      return _clips;
   }
   
   private function get fileName() : String
   {
      return _fileName;
   }
}
