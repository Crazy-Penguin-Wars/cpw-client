package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.net.NeighborService;
   import tuxwars.utils.TuxUiUtils;
   
   public class InboxNoNeighbors extends InboxCore
   {
       
      
      private var buttonInviteNeighbors:UIButton;
      
      public function InboxNoNeighbors(requestDataObj:RequestData, design:MovieClip, parent:UIComponent = null)
      {
         super(requestDataObj,design,"No_Neighbors","No_Neighbors_desc",null,null,parent);
         buttonInviteNeighbors = TuxUiUtils.createButton(UIButton,design,"Button_Invite",inviteNeighbors,"Invite");
      }
      
      public function inviteNeighbors(event:MouseEvent) : void
      {
         MessageCenter.sendMessage("InboxUpdateCounter",InboxManager.messageCount);
         NeighborService.sendNeighborRequestSelectFriends("INVITE_NEIGHBOR_TITLE","INVITE_NEIGHBOR_MESSAGE","InboxNoNeighborRequests");
      }
   }
}
