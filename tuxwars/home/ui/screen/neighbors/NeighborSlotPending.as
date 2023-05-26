package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function NeighborSlotPending(design:MovieClip, tuxGame:TuxWarsGame)
      {
         super(design,tuxGame);
         descriptionTextField = design.getChildByName("Text_Description") as TextField;
         descriptionTextField.text = ProjectManager.getText("NEIGHBOR_REQUEST_PENDING");
         buttonSend = TuxUiUtils.createButton(UIButton,design,"Button_Send",sendCallback,"BUTTON_NEIGHBOR_SEND");
         buttonCancel = TuxUiUtils.createButton(UIButton,design,"Button_Cancel",cancelCallback,"BUTTON_NEIGHBOR_CANCEL");
         buttonReminder = TuxUiUtils.createButton(UIButton,design,"Button_Reminder",reminderCallback,"BUTTON_NEIGHBOR_REMINDER");
      }
      
      override public function setFriend(f:Friend) : void
      {
         super.setFriend(f);
         if(f)
         {
            design.visible = true;
         }
         else
         {
            design.visible = false;
         }
      }
      
      private function sendCallback(event:MouseEvent) : void
      {
         trace("SEND");
      }
      
      private function cancelCallback(event:MouseEvent) : void
      {
         trace("CANCEL");
      }
      
      private function reminderCallback(event:MouseEvent) : void
      {
         trace("REMINDER");
      }
   }
}
