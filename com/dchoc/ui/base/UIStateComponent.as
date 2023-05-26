package com.dchoc.ui.base
{
   import com.dchoc.ui.UITransiotionConfig;
   import com.dchoc.utils.DCUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class UIStateComponent extends UIComponent
   {
       
      
      protected var state:String;
      
      private var showTransitions:Boolean;
      
      public function UIStateComponent(design:DisplayObject)
      {
         super(design);
         setShowTransitions(true);
      }
      
      public function isState(state:String) : Boolean
      {
         return this.state == state;
      }
      
      override public function setVisible(value:Boolean) : void
      {
         if(getVisible() != value)
         {
            if(value)
            {
               if(setState("Visible"))
               {
                  addEventListener("transition_end",showAnimEnded);
                  return;
               }
            }
            else if(setState("Hidden"))
            {
               addEventListener("transition_end",hideAnimEnded);
               return;
            }
         }
         super.setVisible(value);
      }
      
      public function hideAnimEnded(e:Event) : void
      {
         removeEventListener("transition_end",hideAnimEnded);
         super.setVisible(false);
      }
      
      public function showAnimEnded(e:Event) : void
      {
         removeEventListener("transition_end",showAnimEnded);
         super.setVisible(true);
      }
      
      override public function dispose() : void
      {
         removeEventListener("transition_end",hideAnimEnded);
         removeEventListener("transition_end",showAnimEnded);
         removeEventListener("transition_end",clipAnimEnded);
         removeEventListener("enterFrame",animEnterFrame);
         removeEventListener("frameConstructed",frameConstructed);
         super.dispose();
      }
      
      public function setState(newState:String, fallBackState:String = null) : Boolean
      {
         if(state == newState)
         {
            return false;
         }
         if(!showTransitions)
         {
            state = newState;
            return false;
         }
         if(state == null)
         {
            state = newState;
            super.goToFrame(newState);
            return false;
         }
         var transitionFound:Boolean = true;
         if(playAnimation(state + "_To_" + newState))
         {
            addEventListener("transition_end",clipAnimEnded);
            addEventListener("enterFrame",animEnterFrame);
         }
         else if(!UITransiotionConfig.playTransition(this,state,newState))
         {
            if(!super.goToFrame(newState))
            {
               if(fallBackState)
               {
                  return setState(fallBackState);
               }
               getDesignMovieClip().gotoAndStop(1);
            }
            updateTextField();
            transitionFound = false;
         }
         state = newState;
         return transitionFound;
      }
      
      public function animEnterFrame(e:Event) : void
      {
         updateTextField();
         if(getDesignMovieClip())
         {
            DCUtils.setBitmapSmoothing(true,getDesignMovieClip());
         }
      }
      
      public function clipAnimEnded(e:Event) : void
      {
         removeEventListener("transition_end",clipAnimEnded);
         removeEventListener("enterFrame",animEnterFrame);
         addEventListener("frameConstructed",frameConstructed);
         super.goToFrame(state);
         updateTextField();
      }
      
      public function frameConstructed(e:Event) : void
      {
         removeEventListener("frameConstructed",frameConstructed);
         updateTextField();
         if(getDesignMovieClip())
         {
            DCUtils.setBitmapSmoothing(true,getDesignMovieClip());
         }
      }
      
      protected function updateTextField() : void
      {
      }
      
      public function setShowTransitions(show:Boolean) : void
      {
         showTransitions = show;
      }
      
      public function getShowTransitions() : Boolean
      {
         return showTransitions;
      }
   }
}
