package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.net.*;
   import tuxwars.utils.*;
   
   public class InboxNoNeighbors extends InboxCore
   {
      private var buttonInviteNeighbors:UIButton;
      
      public function InboxNoNeighbors(param1:RequestData, param2:MovieClip, param3:UIComponent = null)
      {
         super(param1,param2,"No_Neighbors","No_Neighbors_desc",null,null,param3);
         this.buttonInviteNeighbors = TuxUiUtils.createButton(UIButton,param2,"Button_Invite",this.inviteNeighbors,"Invite");
      }
      
      public function inviteNeighbors(param1:MouseEvent) : void
      {
         MessageCenter.sendMessage("InboxUpdateCounter",InboxManager.messageCount);
         NeighborService.sendNeighborRequestSelectFriends("INVITE_NEIGHBOR_TITLE","INVITE_NEIGHBOR_MESSAGE","InboxNoNeighborRequests");
      }
   }
}

