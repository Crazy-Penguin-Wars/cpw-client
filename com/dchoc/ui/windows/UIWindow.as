package com.dchoc.ui.windows
{
   import com.dchoc.states.StateMachine;
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.ui.events.UIWindowEvent;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class UIWindow extends UIStateComponent
   {
      
      public static var isModalWindowOpen:Boolean;
      
      protected static var numberModalWindowsOpen:int = 0;
       
      
      protected var modalShade:UIModalWindowShade;
      
      protected var mIsModal:Boolean;
      
      protected var parent:DisplayObjectContainer;
      
      public function UIWindow(design:MovieClip)
      {
         super(design);
         setState("Close");
      }
      
      public static function isAModalWindowOpen() : Boolean
      {
         return numberModalWindowsOpen > 0;
      }
      
      protected function setModal() : void
      {
         mIsModal = true;
         modalShade = new UIModalWindowShade(parent);
         isModalWindowOpen = true;
         numberModalWindowsOpen++;
      }
      
      protected function removeModalSquare() : void
      {
         if(isModal())
         {
            numberModalWindowsOpen--;
            if(modalShade)
            {
               modalShade.removeModalSquare();
            }
            mIsModal = false;
         }
      }
      
      public function isModal() : Boolean
      {
         return mIsModal;
      }
      
      public function open(parent:DisplayObjectContainer, modal:Boolean = false) : void
      {
         this.parent = parent;
         if(modal)
         {
            setModal();
         }
         this.parent.addChild(this._design);
         setState("Visible");
      }
      
      public function close(exitState:StateMachine = null) : void
      {
         if(setState("Close"))
         {
            this._design.addEventListener("transition_end",closeAnimEnded);
         }
         else
         {
            clean();
         }
         if(modalShade)
         {
            modalShade.close();
         }
      }
      
      public function closeAnimEnded(e:Event) : void
      {
         this._design.removeEventListener("transition_end",closeAnimEnded);
         clean();
         dispatchEvent(new UIWindowEvent("event_window_closed"));
      }
      
      public function clean() : void
      {
         removeModalSquare();
         if(parent != null && parent.getChildByName(this._design.getName()) != null)
         {
            parent.removeChild(this._design);
            parent = null;
         }
      }
      
      public function changeTextFieldText(nameOfTextField:String, newText:String) : void
      {
         var _loc3_:* = null;
         if(newText != null)
         {
            _loc3_ = DisplayObjectContainer(this._design).getChildByName(nameOfTextField) as TextField;
            if(_loc3_ != null)
            {
               _loc3_.text = newText;
            }
         }
      }
   }
}
