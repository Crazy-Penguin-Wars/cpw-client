package com.dchoc.ui.groups
{
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import flash.events.EventDispatcher;
   
   public class UIRadialGroup extends EventDispatcher
   {
       
      
      private var buttons:Vector.<UIToggleButton>;
      
      private var selectedIndex:int;
      
      public function UIRadialGroup()
      {
         super();
         buttons = new Vector.<UIToggleButton>();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         for(i = buttons.length - 1; i >= 0; )
         {
            _loc1_ = removeIndex(i);
            _loc1_.dispose();
            i--;
         }
      }
      
      public function add(button:UIToggleButton) : void
      {
         buttons.push(button);
         if(buttons.length == 1)
         {
            setSelectedIndex(0);
         }
         button.addEventListener("clicked",buttonClickedCallback);
      }
      
      public function remove(button:UIToggleButton) : void
      {
         removeIndex(buttons.indexOf(button));
      }
      
      public function removeIndex(index:int) : UIToggleButton
      {
         var _loc2_:* = null;
         if(index >= 0)
         {
            _loc2_ = buttons[index];
            _loc2_.removeEventListener("clicked",buttonClickedCallback);
            buttons.splice(index,1);
            return _loc2_;
         }
         return null;
      }
      
      protected function buttonClickedCallback(event:UIButtonEvent) : void
      {
         setSelectedButtonActive(event.getButton() as UIToggleButton);
      }
      
      private function setSelectedButtonActive(button:UIToggleButton, triggerEvent:Boolean = true) : void
      {
         var currentSelection:int = 0;
         for each(var toggleButton in buttons)
         {
            if(toggleButton == button)
            {
               toggleButton.setSelected(true);
               selectedIndex = currentSelection;
               if(triggerEvent)
               {
                  dispatchEvent(new UIRadialGroupEvent("selection_changed",toggleButton));
               }
            }
            else if(toggleButton.getVisible())
            {
               toggleButton.setSelected(false);
            }
            currentSelection++;
         }
      }
      
      public function getButtons() : Vector.<UIToggleButton>
      {
         return buttons;
      }
      
      public function getButtonAt(index:int) : UIToggleButton
      {
         return buttons[index];
      }
      
      public function getSelectedButton() : UIToggleButton
      {
         return buttons[selectedIndex];
      }
      
      public function getSelectedIndex() : int
      {
         return selectedIndex;
      }
      
      public function setSelectedIndex(value:int, triggerEvent:Boolean = false) : void
      {
         setSelectedButtonActive(getButtonAt(value),triggerEvent);
      }
      
      public function setSelected(button:*, triggerEvent:Boolean = false) : void
      {
         if(getButtons().indexOf(button) != -1)
         {
            setSelectedButtonActive(button,triggerEvent);
         }
      }
      
      public function setEnabled(value:Boolean) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         if(buttons)
         {
            for(i = buttons.length - 1; i >= 0; )
            {
               _loc2_ = buttons[i];
               _loc2_.setEnabled(value);
               i--;
            }
         }
      }
      
      public function setVisible(value:Boolean) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         for(i = buttons.length - 1; i >= 0; )
         {
            _loc2_ = buttons[i];
            _loc2_.setVisible(value);
            i--;
         }
      }
   }
}
