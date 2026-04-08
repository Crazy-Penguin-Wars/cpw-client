package com.dchoc.ui.windows
{
   import com.dchoc.states.StateMachine;
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.ui.events.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.text.*;
   
   public class UIWindow extends UIStateComponent
   {
      public static var isModalWindowOpen:Boolean;
      
      protected static var numberModalWindowsOpen:int = 0;
      
      protected var modalShade:UIModalWindowShade;
      
      protected var mIsModal:Boolean;
      
      protected var parent:DisplayObjectContainer;
      
      public function UIWindow(param1:MovieClip)
      {
         super(param1);
         setState("Close");
      }
      
      public static function isAModalWindowOpen() : Boolean
      {
         return numberModalWindowsOpen > 0;
      }
      
      protected function setModal() : void
      {
         this.mIsModal = true;
         this.modalShade = new UIModalWindowShade(this.parent);
         isModalWindowOpen = true;
         ++numberModalWindowsOpen;
      }
      
      protected function removeModalSquare() : void
      {
         if(this.isModal())
         {
            --numberModalWindowsOpen;
            if(this.modalShade)
            {
               this.modalShade.removeModalSquare();
            }
            this.mIsModal = false;
         }
      }
      
      public function isModal() : Boolean
      {
         return this.mIsModal;
      }
      
      public function open(param1:DisplayObjectContainer, param2:Boolean = false) : void
      {
         this.parent = param1;
         if(param2)
         {
            this.setModal();
         }
         this.parent.addChild(this._design);
         setState("Visible");
      }
      
      public function close(param1:StateMachine = null) : void
      {
         if(setState("Close"))
         {
            this._design.addEventListener("transition_end",this.closeAnimEnded);
         }
         else
         {
            this.clean();
         }
         if(this.modalShade)
         {
            this.modalShade.close();
         }
      }
      
      public function closeAnimEnded(param1:Event) : void
      {
         this._design.removeEventListener("transition_end",this.closeAnimEnded);
         this.clean();
         dispatchEvent(new UIWindowEvent("event_window_closed"));
      }
      
      public function clean() : void
      {
         this.removeModalSquare();
         if(this.parent != null && this.parent.getChildByName(this._design.getName()) != null)
         {
            this.parent.removeChild(this._design);
            this.parent = null;
         }
      }
      
      public function changeTextFieldText(param1:String, param2:String) : void
      {
         var _loc3_:TextField = null;
         if(param2 != null)
         {
            _loc3_ = DisplayObjectContainer(this._design).getChildByName(param1) as TextField;
            if(_loc3_ != null)
            {
               _loc3_.text = param2;
            }
         }
      }
   }
}

