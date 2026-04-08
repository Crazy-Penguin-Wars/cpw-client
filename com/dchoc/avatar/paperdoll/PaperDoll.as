package com.dchoc.avatar.paperdoll
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.avatar.AvatarColor;
   import com.dchoc.avatar.IAvatarColor;
   import com.dchoc.avatar.paperdoll.animations.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.utils.*;
   
   public class PaperDoll extends MovieClip
   {
      private const bodyParts:Vector.<BodyPart> = new Vector.<BodyPart>();
      
      private var _currentAnimation:PaperDollAnimation;
      
      private var currentAnimationCallback:Function;
      
      private var currentClothes:Dictionary = new Dictionary(true);
      
      private var _color:IAvatarColor;
      
      private var _gender:int;
      
      private var nextAnimationName:String;
      
      private var nextAnimLoop:Boolean;
      
      private var nextPlayOnceAndCallThisFunction:Function;
      
      private var nextCallThisFunctionWhenAnimationStarts:Function;
      
      private var _swfFileName:String;
      
      public function PaperDoll(param1:String, param2:AvatarColor, param3:int)
      {
         super();
         this._swfFileName = param1;
         this._color = param2;
         this._gender = param3;
      }
      
      public function clean() : void
      {
         var _loc1_:* = undefined;
         if(this._currentAnimation)
         {
            this._currentAnimation.dispose();
            this._currentAnimation = null;
         }
         if(this.currentClothes)
         {
            for(_loc1_ in this.currentClothes)
            {
               if(this.currentClothes[_loc1_])
               {
                  this.currentClothes[_loc1_].clean();
                  this.currentClothes[_loc1_] = null;
               }
            }
            this.currentClothes = null;
         }
         this.nextPlayOnceAndCallThisFunction = null;
         this.nextCallThisFunctionWhenAnimationStarts = null;
         this.bodyParts.splice(0,this.bodyParts.length);
      }
      
      public function addBodyPart(param1:BodyPart) : void
      {
         if(!this.containsBodyPart(param1))
         {
            this.bodyParts.push(param1);
         }
      }
      
      public function removeBodyPart(param1:BodyPart) : void
      {
         var _loc2_:int = this.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.bodyParts.splice(_loc2_,1);
         }
      }
      
      public function indexOf(param1:BodyPart) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.bodyParts.length)
         {
            if(param1.equals(this.bodyParts[_loc2_]))
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function containsBodyPart(param1:BodyPart) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.bodyParts)
         {
            if(_loc2_.equals(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function wear(param1:String, param2:ClothesSlot, param3:Boolean = true) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param3)
         {
            this.unwear(param2);
         }
         var _loc4_:Array = this.addClothes(param1,this.bodyParts,this.currentClothes[param2] != null ? this.currentClothes[param2].clips : null);
         if(_loc4_.length > 0)
         {
            this.currentClothes[param2] = new CurrentClothes(_loc4_,param1);
         }
         this.color = this._color;
         return _loc4_.length > 0;
      }
      
      private function wearClothes(param1:CurrentClothes, param2:ClothesSlot) : void
      {
         var _loc3_:Array = this.addClothes(param1.fileName,this.bodyParts,param1.clips);
         if(_loc3_.length > 0)
         {
            this.currentClothes[param2] = new CurrentClothes(_loc3_,param1.fileName);
         }
      }
      
      public function unwear(param1:ClothesSlot) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         if(this.currentClothes[param1])
         {
            _loc2_ = CurrentClothes(this.currentClothes[param1]).clips;
            _loc3_ = int(_loc2_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = _loc2_[_loc4_];
               _loc5_.parent.removeChild(_loc5_);
               _loc4_++;
            }
            this.currentClothes[param1].clean();
            this.currentClothes[param1] = null;
            delete this.currentClothes[param1];
         }
      }
      
      protected function createAnimation(param1:MovieClip, param2:Boolean = true, param3:Function = null) : void
      {
         var _loc4_:int = 0;
         if(this._currentAnimation)
         {
            this._currentAnimation.dispose();
         }
         _loc4_ = numChildren - 1;
         while(_loc4_ >= 0)
         {
            removeChildAt(_loc4_);
            _loc4_--;
         }
         if(param1)
         {
            this._currentAnimation = new PaperDollAnimation(param1,true,param2,param3);
            addChild(this._currentAnimation);
            this.color = this._color;
            this.gender = this._gender;
            this.redrawCurrentClothes();
         }
      }
      
      public function changeAnimation(param1:AvatarAnimation, param2:Boolean = true, param3:Function = null) : void
      {
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF(this._swfFileName,param1.classDefinitionName);
         if(_loc4_)
         {
            this.nextAnimationName = null;
            _loc4_.name = param1.classDefinitionName;
            this.createAnimation(_loc4_,param1.isLooping(),param1.callback);
            if(param3 != null)
            {
               param3();
            }
         }
      }
      
      public function addFrameScriptToAnimation(param1:String, param2:Function) : void
      {
         var _loc3_:int = 0;
         if(this._currentAnimation)
         {
            _loc3_ = int(DCUtils.indexOfLabel(this._currentAnimation.clip,param1));
            this._currentAnimation.clip.addFrameScript(_loc3_,param2);
         }
      }
      
      private function startNextAnimation() : void
      {
         var _loc1_:Function = null;
         var _loc2_:MovieClip = null;
         if(this.currentAnimationCallback != null)
         {
            _loc1_ = this.currentAnimationCallback;
            this.currentAnimationCallback = null;
            _loc1_();
         }
         if(this.nextAnimationName != null)
         {
            _loc2_ = DCResourceManager.instance.getFromSWF(this._swfFileName,this.nextAnimationName);
            this.createAnimation(_loc2_,this.nextAnimLoop,this.nextPlayOnceAndCallThisFunction);
            this.nextAnimationName = null;
            this.nextPlayOnceAndCallThisFunction = null;
            if(this.nextCallThisFunctionWhenAnimationStarts != null)
            {
               this.nextCallThisFunctionWhenAnimationStarts();
               this.nextCallThisFunctionWhenAnimationStarts = null;
            }
         }
      }
      
      public function redrawCurrentClothes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ClothesSlot = null;
         var _loc3_:CurrentClothes = null;
         _loc1_ = 0;
         while(_loc1_ < ClothesSlot.TYPE_NAMES.length)
         {
            _loc2_ = ClothesSlot.getSlotByID(_loc1_);
            _loc3_ = this.currentClothes[_loc2_];
            if(_loc3_)
            {
               this.wearClothes(_loc3_,_loc2_);
            }
            else
            {
               this.unwear(_loc2_);
            }
            _loc1_++;
         }
      }
      
      public function stopAnimation() : void
      {
         if(this._currentAnimation)
         {
            this._currentAnimation.clean();
         }
      }
      
      public function resumeAnimation() : void
      {
         if(this._currentAnimation)
         {
            this._currentAnimation.play();
         }
      }
      
      private function addClothes(param1:String, param2:Vector.<BodyPart>, param3:Array = null) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:BodyPart = null;
         var _loc6_:String = null;
         var _loc7_:MovieClip = null;
         var _loc8_:String = null;
         var _loc9_:MovieClip = null;
         var _loc10_:DisplayObjectContainer = null;
         var _loc11_:Array = [];
         var _loc12_:MovieClip = this._currentAnimation.getChildAt(0) as MovieClip;
         if(_loc12_)
         {
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               _loc5_ = param2[_loc4_];
               _loc6_ = _loc5_.getClipName();
               _loc7_ = DCUtils.getChildByPath(_loc12_,_loc6_) as MovieClip;
               _loc8_ = _loc5_.getClassName();
               _loc9_ = this.getClothClip(param1,_loc8_,param3);
               if(Boolean(_loc7_) && Boolean(_loc9_))
               {
                  _loc7_.addChild(_loc9_);
                  _loc10_ = _loc9_ as DisplayObjectContainer;
                  if(!_loc10_ || _loc10_.numChildren > 0)
                  {
                     _loc11_.push(_loc9_);
                  }
               }
               _loc4_++;
            }
         }
         return _loc11_;
      }
      
      private function getClothClip(param1:String, param2:String, param3:Array = null) : MovieClip
      {
         var _loc5_:* = undefined;
         if(param3)
         {
            for each(_loc5_ in param3)
            {
               if(_loc5_.name == param2)
               {
                  return _loc5_;
               }
            }
         }
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF(param1,param2);
         if(_loc4_)
         {
            _loc4_.name = param2;
         }
         return _loc4_;
      }
      
      public function set color(param1:IAvatarColor) : void
      {
         this._color = param1;
         if(!this._color)
         {
            return;
         }
         this.applyColor(this._currentAnimation,this._color);
      }
      
      public function get color() : IAvatarColor
      {
         return this._color;
      }
      
      private function applyColor(param1:DisplayObjectContainer, param2:IAvatarColor) : void
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         if(!param1)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            this.setColor(_loc4_,param2);
            this.applyColor(_loc4_ as DisplayObjectContainer,param2);
            _loc3_++;
         }
      }
      
      private function setColor(param1:DisplayObject, param2:IAvatarColor) : void
      {
         if(param1.name == "colorable")
         {
            param1.transform.colorTransform = param2.colorTransform;
         }
      }
      
      private function getBodyPartClip(param1:String) : MovieClip
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = this._currentAnimation.getChildAt(0) as MovieClip;
         var _loc5_:* = param1;
         if(_loc5_.indexOf("/") != -1)
         {
            _loc2_ = _loc5_.split("/");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length - 1)
            {
               _loc4_ = _loc4_[_loc2_[_loc3_]];
               if(!_loc4_)
               {
                  return null;
               }
               _loc3_++;
            }
            _loc5_ = _loc2_[_loc3_];
         }
         return _loc4_[_loc5_];
      }
      
      public function getAnimationElapsedPercentage() : int
      {
         return this._currentAnimation.getAnimationElapsedPercentage();
      }
      
      public function get animation() : PaperDollAnimation
      {
         return this._currentAnimation;
      }
      
      public function set gender(param1:int) : void
      {
         this._gender = param1;
      }
      
      public function get gender() : int
      {
         return this._gender;
      }
      
      public function getClothesInSlot(param1:ClothesSlot) : Array
      {
         if(this.currentClothes[param1])
         {
            return this.currentClothes[param1].clips;
         }
         return null;
      }
   }
}

class CurrentClothes
{
   private var _clips:Array;
   
   private var _fileName:String;
   
   public function CurrentClothes(param1:Array, param2:String)
   {
      super();
      this._clips = param1;
      this._fileName = param2;
   }
   
   public function clean() : void
   {
      this._clips = null;
      this._fileName = null;
   }
   
   internal function get clips() : Array
   {
      return this._clips;
   }
   
   internal function get fileName() : String
   {
      return this._fileName;
   }
}
