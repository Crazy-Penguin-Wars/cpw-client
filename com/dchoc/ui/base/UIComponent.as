package com.dchoc.ui.base
{
   import com.dchoc.ui.transitions.UITransition;
   import com.dchoc.ui.utils.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.Event;
   
   public class UIComponent
   {
      private const eventListeners:Object = {};
      
      public var _design:DisplayObject;
      
      private var currentAnimation:String;
      
      private var uiTransition:UITransition;
      
      public function UIComponent(param1:DisplayObject)
      {
         super();
         this._design = param1;
      }
      
      protected function playAnimation(param1:String) : Boolean
      {
         if(UIUtils.movieClipContainsLabel(this.getDesignMovieClip(),param1))
         {
            this.currentAnimation = param1;
            this.getDesignMovieClip().gotoAndPlay(param1);
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc1_:Array = null;
         if(!this.disposed)
         {
            for(_loc2_ in this.eventListeners)
            {
               _loc1_ = this.eventListeners[_loc2_];
               for each(_loc3_ in _loc1_)
               {
                  this._design.removeEventListener(_loc2_,_loc3_);
               }
            }
            DCUtils.deleteProperties(this.eventListeners);
            DCUtils.stopMovieClip(this.getDesignMovieClip());
            this._design = null;
            if(this.getUiTransiotion())
            {
               this.getUiTransiotion().dispose();
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._design == null;
      }
      
      protected function goToFrame(param1:String) : Boolean
      {
         if(UIUtils.movieClipContainsLabel(this.getDesignMovieClip(),param1))
         {
            this.currentAnimation = param1;
            this.getDesignMovieClip().gotoAndStop(param1);
            DCUtils.setBitmapSmoothing(true,this.getDesignMovieClip());
            return true;
         }
         return false;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._design.addEventListener(param1,param2,param3,param4,param5);
         if(!this.eventListeners.hasOwnProperty(param1))
         {
            this.eventListeners[param1] = [];
         }
         this.eventListeners[param1].push(param2);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(this._design)
         {
            this._design.removeEventListener(param1,param2,param3);
         }
      }
      
      public function dispatchEvent(param1:Event) : void
      {
         if(this._design)
         {
            this._design.dispatchEvent(param1);
         }
      }
      
      public function setMouseChildren(param1:Boolean) : void
      {
         this.getDesignMovieClip().mouseChildren = param1;
      }
      
      public function setMouseEnabled(param1:Boolean) : void
      {
         this.getDesignMovieClip().mouseEnabled = param1;
      }
      
      public function getName() : String
      {
         return this._design.name;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this._design.visible = param1;
      }
      
      public function getVisible() : Boolean
      {
         return this._design.visible;
      }
      
      public function getWidth() : Number
      {
         return this._design.width;
      }
      
      public function getHeight() : Number
      {
         return this._design.height;
      }
      
      public function getX() : Number
      {
         return this._design.x;
      }
      
      public function getY() : Number
      {
         return this._design.y;
      }
      
      final public function get design() : *
      {
         return this._design;
      }
      
      final public function getDesignMovieClip() : MovieClip
      {
         return this._design as MovieClip;
      }
      
      public function getCurrentAnimation() : String
      {
         return this.currentAnimation;
      }
      
      public function setX(param1:Number) : void
      {
         this._design.x = param1;
      }
      
      public function setY(param1:Number) : void
      {
         this._design.y = param1;
      }
      
      public function setUiTransition(param1:UITransition) : void
      {
         this.uiTransition = param1;
      }
      
      public function getUiTransiotion() : UITransition
      {
         return this.uiTransition;
      }
   }
}

