package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.utils.TuxUiUtils;
   
   public class InboxNeighbor extends InboxCore
   {
       
      
      private var accept:UIButton;
      
      private var ignore:UIButton;
      
      private var loader:URLResourceLoader;
      
      public function InboxNeighbor(requestDataObj:RequestData, design:MovieClip, parent:UIComponent = null)
      {
         super(requestDataObj,design,"","",null,null,parent);
         accept = TuxUiUtils.createButton(UIButton,design,"Button_Accept",acceptPressed,"Button_Accept");
         ignore = TuxUiUtils.createButton(UIButton,design,"Button_Ignore",ignorePressed,"Button_Ignore");
      }
      
      override public function setFriend(friend:Friend, playerID:String) : void
      {
         super.setFriend(friend,playerID);
         if(friend)
         {
            title = friend.firstName;
            description = ProjectManager.getText("NEIGHBOR_REQUEST_DESCRIPTION",[friend.firstName]);
         }
      }
      
      private function acceptPressed(event:MouseEvent) : void
      {
         MessageCenter.sendMessage("NeighborAccept",requestData);
         requestData.state = "Done";
         dispose();
         MessageCenter.sendMessage("InboxContentUpdate");
      }
      
      private function ignorePressed(event:MouseEvent) : void
      {
         MessageCenter.sendMessage("NeighborIgnore",requestData);
         requestData.state = "Done";
         dispose();
         MessageCenter.sendMessage("InboxContentUpdate");
      }
      
      override public function dispose() : void
      {
         if(accept)
         {
            accept.dispose();
         }
         if(ignore)
         {
            ignore.dispose();
         }
         super.dispose();
      }
   }
}
