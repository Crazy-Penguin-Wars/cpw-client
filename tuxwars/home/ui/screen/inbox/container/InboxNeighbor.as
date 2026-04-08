package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.utils.*;
   
   public class InboxNeighbor extends InboxCore
   {
      private var accept:UIButton;
      
      private var ignore:UIButton;
      
      private var loader:URLResourceLoader;
      
      public function InboxNeighbor(param1:RequestData, param2:MovieClip, param3:UIComponent = null)
      {
         super(param1,param2,"","",null,null,param3);
         this.accept = TuxUiUtils.createButton(UIButton,param2,"Button_Accept",this.acceptPressed,"Button_Accept");
         this.ignore = TuxUiUtils.createButton(UIButton,param2,"Button_Ignore",this.ignorePressed,"Button_Ignore");
      }
      
      override public function setFriend(param1:Friend, param2:String) : void
      {
         super.setFriend(param1,param2);
         if(param1)
         {
            title = param1.firstName;
            description = ProjectManager.getText("NEIGHBOR_REQUEST_DESCRIPTION",[param1.firstName]);
         }
      }
      
      private function acceptPressed(param1:MouseEvent) : void
      {
         MessageCenter.sendMessage("NeighborAccept",requestData);
         requestData.state = "Done";
         this.dispose();
         MessageCenter.sendMessage("InboxContentUpdate");
      }
      
      private function ignorePressed(param1:MouseEvent) : void
      {
         MessageCenter.sendMessage("NeighborIgnore",requestData);
         requestData.state = "Done";
         this.dispose();
         MessageCenter.sendMessage("InboxContentUpdate");
      }
      
      override public function dispose() : void
      {
         if(this.accept)
         {
            this.accept.dispose();
         }
         if(this.ignore)
         {
            this.ignore.dispose();
         }
         super.dispose();
      }
   }
}

