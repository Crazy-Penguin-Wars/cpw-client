package com.dchoc.ui.buttons
{
   import com.dchoc.ui.events.UIButtonEvent;
   import flash.display.MovieClip;
   
   public class UIToggleButton extends UIButton
   {
      private var selected:Boolean;
      
      private var selectedText:String;
      
      public function UIToggleButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
         addEventListener("clicked",this.buttonClickedCallback);
         this.setSelected(false);
      }
      
      override public function dispose() : void
      {
         removeEventListener("clicked",this.buttonClickedCallback);
         super.dispose();
      }
      
      protected function buttonClickedCallback(param1:UIButtonEvent) : void
      {
         this.setSelected(!this.selected);
      }
      
      public function setSelectedText(param1:String) : void
      {
         this.selectedText = param1;
      }
      
      override protected function updateTextField() : void
      {
         var _loc1_:String = null;
         if(Boolean(this.selected) && Boolean(this.selectedText))
         {
            _loc1_ = getText();
            text = this.selectedText;
            super.updateTextField();
            text = _loc1_;
         }
         else
         {
            super.updateTextField();
         }
      }
      
      override public function setState(param1:String, param2:String = null) : Boolean
      {
         if(!this.selected)
         {
            return super.setState(param1,param2);
         }
         switch(param1)
         {
            case "Hover":
               return super.setState("Selectedhover");
            case "Down":
               return super.setState("Selecteddown");
            case "Visible":
               return super.setState("Selected");
            default:
               return super.setState(param1,param2);
         }
      }
      
      public function getSelected() : Boolean
      {
         return this.selected;
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(this.selected != param1)
         {
            this.selected = param1;
            if(this.selected)
            {
               if(isOver())
               {
                  this.setState("Selectedhover","Selected");
               }
               else
               {
                  this.setState("Selected");
               }
            }
            else if(isOver())
            {
               this.setState("Hover");
            }
            else
            {
               this.setState("Visible");
            }
         }
      }
   }
}

