package com.dchoc.ui.buttons
{
   import com.dchoc.ui.events.UIButtonEvent;
   import flash.display.MovieClip;
   
   public class UIToggleButton extends UIButton
   {
       
      
      private var selected:Boolean;
      
      private var selectedText:String;
      
      public function UIToggleButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
         addEventListener("clicked",buttonClickedCallback);
         setSelected(false);
      }
      
      override public function dispose() : void
      {
         removeEventListener("clicked",buttonClickedCallback);
         super.dispose();
      }
      
      protected function buttonClickedCallback(event:UIButtonEvent) : void
      {
         setSelected(!selected);
      }
      
      public function setSelectedText(txt:String) : void
      {
         selectedText = txt;
      }
      
      override protected function updateTextField() : void
      {
         var saveText:* = null;
         if(selected && selectedText)
         {
            saveText = getText();
            text = selectedText;
            super.updateTextField();
            text = saveText;
         }
         else
         {
            super.updateTextField();
         }
      }
      
      override public function setState(state:String, fallBackState:String = null) : Boolean
      {
         if(!selected)
         {
            return super.setState(state,fallBackState);
         }
         switch(state)
         {
            case "Hover":
               return super.setState("Selectedhover");
            case "Down":
               return super.setState("Selecteddown");
            case "Visible":
               return super.setState("Selected");
            default:
               return super.setState(state,fallBackState);
         }
      }
      
      public function getSelected() : Boolean
      {
         return selected;
      }
      
      public function setSelected(value:Boolean) : void
      {
         if(selected != value)
         {
            selected = value;
            if(selected)
            {
               if(isOver())
               {
                  setState("Selectedhover","Selected");
               }
               else
               {
                  setState("Selected");
               }
            }
            else if(isOver())
            {
               setState("Hover");
            }
            else
            {
               setState("Visible");
            }
         }
      }
   }
}
