package com.dchoc.ui.base
{
   import com.dchoc.ui.*;
   import com.dchoc.utils.*;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class UIStateComponent extends UIComponent
   {
      protected var state:String;
      
      private var showTransitions:Boolean;
      
      public function UIStateComponent(param1:DisplayObject)
      {
         super(param1);
         this.setShowTransitions(true);
      }
      
      public function isState(param1:String) : Boolean
      {
         return this.state == param1;
      }
      
      override public function setVisible(param1:Boolean) : void
      {
         if(getVisible() != param1)
         {
            if(param1)
            {
               if(this.setState("Visible"))
               {
                  super.setVisible(param1);
                  addEventListener("transition_end",this.showAnimEnded);
                  return;
               }
            }
            else if(this.setState("Hidden"))
            {
               addEventListener("transition_end",this.hideAnimEnded);
               return;
            }
         }
         super.setVisible(param1);
      }
      
      public function hideAnimEnded(param1:Event) : void
      {
         removeEventListener("transition_end",this.hideAnimEnded);
         super.setVisible(false);
      }
      
      public function showAnimEnded(param1:Event) : void
      {
         removeEventListener("transition_end",this.showAnimEnded);
         super.setVisible(true);
      }
      
      override public function dispose() : void
      {
         removeEventListener("transition_end",this.hideAnimEnded);
         removeEventListener("transition_end",this.showAnimEnded);
         removeEventListener("transition_end",this.clipAnimEnded);
         removeEventListener("enterFrame",this.animEnterFrame);
         removeEventListener("frameConstructed",this.frameConstructed);
         super.dispose();
      }
      
      public function setState(param1:String, param2:String = null) : Boolean
      {
         if(this.state == param1)
         {
            return false;
         }
         if(!this.showTransitions)
         {
            this.state = param1;
            return false;
         }
         if(this.state == null)
         {
            this.state = param1;
            super.goToFrame(param1);
            return false;
         }
         var _loc3_:Boolean = true;
         if(playAnimation(this.state + "_To_" + param1))
         {
            addEventListener("transition_end",this.clipAnimEnded);
            addEventListener("enterFrame",this.animEnterFrame);
         }
         else if(!UITransiotionConfig.playTransition(this,this.state,param1))
         {
            if(!super.goToFrame(param1))
            {
               if(param2)
               {
                  return this.setState(param2);
               }
               getDesignMovieClip().gotoAndStop(1);
            }
            this.updateTextField();
            _loc3_ = false;
         }
         this.state = param1;
         return _loc3_;
      }
      
      public function animEnterFrame(param1:Event) : void
      {
         this.updateTextField();
         if(getDesignMovieClip())
         {
            DCUtils.setBitmapSmoothing(true,getDesignMovieClip());
         }
      }
      
      public function clipAnimEnded(param1:Event) : void
      {
         removeEventListener("transition_end",this.clipAnimEnded);
         removeEventListener("enterFrame",this.animEnterFrame);
         addEventListener("frameConstructed",this.frameConstructed);
         super.goToFrame(this.state);
         this.updateTextField();
      }
      
      public function frameConstructed(param1:Event) : void
      {
         removeEventListener("frameConstructed",this.frameConstructed);
         this.updateTextField();
         if(getDesignMovieClip())
         {
            DCUtils.setBitmapSmoothing(true,getDesignMovieClip());
         }
      }
      
      protected function updateTextField() : void
      {
      }
      
      public function setShowTransitions(param1:Boolean) : void
      {
         this.showTransitions = param1;
      }
      
      public function getShowTransitions() : Boolean
      {
         return this.showTransitions;
      }
   }
}

