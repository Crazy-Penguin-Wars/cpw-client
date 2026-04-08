package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.utils.*;
   
   public class NeighborSlotPending extends NeighborSlot
   {
      private static const TEXT_FIELD_DESCRIPTION:String = "Text_Description";
      
      private static const BUTTON_SEND:String = "Button_Send";
      
      private static const BUTTON_CANCEL:String = "Button_Cancel";
      
      private static const BUTTON_REMINDER:String = "Button_Reminder";
      
      private var descriptionTextField:TextField;
      
      private var buttonSend:UIButton;
      
      private var buttonCancel:UIButton;
      
      private var buttonReminder:UIButton;
      
      public function NeighborSlotPending(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this.descriptionTextField = param1.getChildByName("Text_Description") as TextField;
         this.descriptionTextField.text = ProjectManager.getText("NEIGHBOR_REQUEST_PENDING");
         this.buttonSend = TuxUiUtils.createButton(UIButton,param1,"Button_Send",this.sendCallback,"BUTTON_NEIGHBOR_SEND");
         this.buttonCancel = TuxUiUtils.createButton(UIButton,param1,"Button_Cancel",this.cancelCallback,"BUTTON_NEIGHBOR_CANCEL");
         this.buttonReminder = TuxUiUtils.createButton(UIButton,param1,"Button_Reminder",this.reminderCallback,"BUTTON_NEIGHBOR_REMINDER");
      }
      
      override public function setFriend(param1:Friend) : void
      {
         super.setFriend(param1);
         if(param1)
         {
            design.visible = true;
         }
         else
         {
            design.visible = false;
         }
      }
      
      private function sendCallback(param1:MouseEvent) : void
      {
         trace("SEND");
      }
      
      private function cancelCallback(param1:MouseEvent) : void
      {
         trace("CANCEL");
      }
      
      private function reminderCallback(param1:MouseEvent) : void
      {
         trace("REMINDER");
      }
   }
}

