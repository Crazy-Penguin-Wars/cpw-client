package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.*;
   import tuxwars.utils.*;
   
   public class NeighborSlotAdd extends NeighborSlot
   {
      private static const TEXT_FIELD_DESCRIPTION:String = "Text_Description";
      
      private static const BUTTON_ADD:String = "Button_Add";
      
      private var descriptionTextField:TextField;
      
      private var addButton:UIButton;
      
      public function NeighborSlotAdd(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this.descriptionTextField = param1.getChildByName("Text_Description") as TextField;
         this.descriptionTextField.text = ProjectManager.getText("NEIGHBOR_ADD_ME");
         this.addButton = TuxUiUtils.createButton(UIButton,param1,"Button_Add",this.addCallback,"BUTTON_NEIGHBOR_ADD");
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
      
      private function addCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","CharacterMenu","Clicked","Invite",null,0,null,true);
         NeighborService.sendNeighborRequest("INVITE_NEIGHBOR_TITLE","INVITE_NEIGHBOR_MESSAGE",[getFriend().platformId],"NeighborsScreen");
      }
   }
}

