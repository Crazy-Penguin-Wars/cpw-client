package com.dchoc.ui.groups
{
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.*;
   import flash.events.EventDispatcher;
   
   public class UIRadialGroup extends EventDispatcher
   {
      private var buttons:Vector.<UIToggleButton>;
      
      private var selectedIndex:int;
      
      public function UIRadialGroup()
      {
         super();
         this.buttons = new Vector.<UIToggleButton>();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:UIToggleButton = null;
         _loc1_ = this.buttons.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.removeIndex(_loc1_);
            _loc2_.dispose();
            _loc1_--;
         }
      }
      
      public function add(param1:UIToggleButton) : void
      {
         this.buttons.push(param1);
         if(this.buttons.length == 1)
         {
            this.setSelectedIndex(0);
         }
         param1.addEventListener("clicked",this.buttonClickedCallback);
      }
      
      public function remove(param1:UIToggleButton) : void
      {
         this.removeIndex(this.buttons.indexOf(param1));
      }
      
      public function removeIndex(param1:int) : UIToggleButton
      {
         var _loc2_:UIToggleButton = null;
         if(param1 >= 0)
         {
            _loc2_ = this.buttons[param1];
            _loc2_.removeEventListener("clicked",this.buttonClickedCallback);
            this.buttons.splice(param1,1);
            return _loc2_;
         }
         return null;
      }
      
      protected function buttonClickedCallback(param1:UIButtonEvent) : void
      {
         this.setSelectedButtonActive(param1.getButton() as UIToggleButton);
      }
      
      private function setSelectedButtonActive(param1:UIToggleButton, param2:Boolean = true) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:int = 0;
         for each(_loc4_ in this.buttons)
         {
            if(_loc4_ == param1)
            {
               _loc4_.setSelected(true);
               this.selectedIndex = _loc3_;
               if(param2)
               {
                  dispatchEvent(new UIRadialGroupEvent("selection_changed",_loc4_));
               }
            }
            else if(_loc4_.getVisible())
            {
               _loc4_.setSelected(false);
            }
            _loc3_++;
         }
      }
      
      public function getButtons() : Vector.<UIToggleButton>
      {
         return this.buttons;
      }
      
      public function getButtonAt(param1:int) : UIToggleButton
      {
         return this.buttons[param1];
      }
      
      public function getSelectedButton() : UIToggleButton
      {
         return this.buttons[this.selectedIndex];
      }
      
      public function getSelectedIndex() : int
      {
         return this.selectedIndex;
      }
      
      public function setSelectedIndex(param1:int, param2:Boolean = false) : void
      {
         this.setSelectedButtonActive(this.getButtonAt(param1),param2);
      }
      
      public function setSelected(param1:*, param2:Boolean = false) : void
      {
         if(this.getButtons().indexOf(param1) != -1)
         {
            this.setSelectedButtonActive(param1,param2);
         }
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:UIToggleButton = null;
         if(this.buttons)
         {
            _loc2_ = this.buttons.length - 1;
            while(_loc2_ >= 0)
            {
               _loc3_ = this.buttons[_loc2_];
               _loc3_.setEnabled(param1);
               _loc2_--;
            }
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:UIToggleButton = null;
         _loc2_ = this.buttons.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this.buttons[_loc2_];
            _loc3_.setVisible(param1);
            _loc2_--;
         }
      }
   }
}

