package com.dchoc.ui.base
{
   import com.dchoc.ui.transitions.UITransition;
   import com.dchoc.ui.utils.UIUtils;
   import com.dchoc.utils.DCUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class UIComponent
   {
       
      
      private const eventListeners:Object = {};
      
      private var _design:DisplayObject;
      
      private var currentAnimation:String;
      
      private var uiTransition:UITransition;
      
      public function UIComponent(design:DisplayObject)
      {
         super();
         _design = design;
      }
      
      protected function playAnimation(frameLabel:String) : Boolean
      {
         if(UIUtils.movieClipContainsLabel(getDesignMovieClip(),frameLabel))
         {
            currentAnimation = frameLabel;
            getDesignMovieClip().gotoAndPlay(frameLabel);
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(!disposed)
         {
            for(var type in eventListeners)
            {
               _loc1_ = eventListeners[type];
               for each(var listener in _loc1_)
               {
                  _design.removeEventListener(type,listener);
               }
            }
            DCUtils.deleteProperties(eventListeners);
            DCUtils.stopMovieClip(getDesignMovieClip());
            _design = null;
            if(getUiTransiotion())
            {
               getUiTransiotion().dispose();
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return _design == null;
      }
      
      protected function goToFrame(frameLabel:String) : Boolean
      {
         if(UIUtils.movieClipContainsLabel(getDesignMovieClip(),frameLabel))
         {
            currentAnimation = frameLabel;
            getDesignMovieClip().gotoAndStop(frameLabel);
            DCUtils.setBitmapSmoothing(true,getDesignMovieClip());
            return true;
         }
         return false;
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         _design.addEventListener(type,listener,useCapture,priority,useWeakReference);
         if(!eventListeners.hasOwnProperty(type))
         {
            eventListeners[type] = [];
         }
         eventListeners[type].push(listener);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         if(_design)
         {
            _design.removeEventListener(type,listener,useCapture);
         }
      }
      
      public function dispatchEvent(event:Event) : void
      {
         if(_design)
         {
            _design.dispatchEvent(event);
         }
      }
      
      public function setMouseChildren(enable:Boolean) : void
      {
         getDesignMovieClip().mouseChildren = enable;
      }
      
      public function setMouseEnabled(enabled:Boolean) : void
      {
         getDesignMovieClip().mouseEnabled = enabled;
      }
      
      public function getName() : String
      {
         return _design.name;
      }
      
      public function setVisible(value:Boolean) : void
      {
         _design.visible = value;
      }
      
      public function getVisible() : Boolean
      {
         return _design.visible;
      }
      
      public function getWidth() : Number
      {
         return _design.width;
      }
      
      public function getHeight() : Number
      {
         return _design.height;
      }
      
      public function getX() : Number
      {
         return _design.x;
      }
      
      public function getY() : Number
      {
         return _design.y;
      }
      
      final public function get design() : *
      {
         return _design;
      }
      
      final public function getDesignMovieClip() : MovieClip
      {
         return _design as MovieClip;
      }
      
      public function getCurrentAnimation() : String
      {
         return currentAnimation;
      }
      
      public function setX(x:Number) : void
      {
         _design.x = x;
      }
      
      public function setY(y:Number) : void
      {
         _design.y = y;
      }
      
      public function setUiTransition(value:UITransition) : void
      {
         uiTransition = value;
      }
      
      public function getUiTransiotion() : UITransition
      {
         return uiTransition;
      }
   }
}
