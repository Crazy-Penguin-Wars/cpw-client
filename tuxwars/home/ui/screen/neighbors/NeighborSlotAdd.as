package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.CRMService;
   import tuxwars.net.NeighborService;
   import tuxwars.utils.TuxUiUtils;
   
   public class NeighborSlotAdd extends NeighborSlot
   {
      
      private static const TEXT_FIELD_DESCRIPTION:String = "Text_Description";
      
      private static const BUTTON_ADD:String = "Button_Add";
       
      
      private var descriptionTextField:TextField;
      
      private var addButton:UIButton;
      
      public function NeighborSlotAdd(design:MovieClip, tuxGame:TuxWarsGame)
      {
         super(design,tuxGame);
         descriptionTextField = design.getChildByName("Text_Description") as TextField;
         descriptionTextField.text = ProjectManager.getText("NEIGHBOR_ADD_ME");
         addButton = TuxUiUtils.createButton(UIButton,design,"Button_Add",addCallback,"BUTTON_NEIGHBOR_ADD");
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
      
      private function addCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","CharacterMenu","Clicked","Invite",null,0,null,true);
         NeighborService.sendNeighborRequest("INVITE_NEIGHBOR_TITLE","INVITE_NEIGHBOR_MESSAGE",[getFriend().platformId],"NeighborsScreen");
      }
   }
}
