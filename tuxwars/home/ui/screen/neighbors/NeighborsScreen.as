package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class NeighborsScreen extends TuxUIScreen
   {
      
      private static const NEIGHBOR_SCREEN:String = "popup_neighbors";
      
      private static const HEADER:String = "Text_Header";
      
      private static const CONTAINER_SLOTS:String = "Container_Slots";
      
      private static const NEIGHBOR_SLOT:String = "Slot_0";
      
      private static const NEIGHBOR_DEFAULT:String = "Neighbor_Default";
      
      private static const NEIGHBOR_ADD:String = "Neighbor_Add";
      
      private static const NEIGHBOR_PENDING:String = "Neighbor_Pending";
      
      private static const NEIGHBOR_INVITE:String = "Neighbor_Button";
      
      private static const BUTTON_SCROLL_LEFT:String = "Button_Scroll_Left";
      
      private static const BUTTON_SCROLL_RIGHT:String = "Button_Scroll_Right";
       
      
      private var buttonClose:UIButton;
      
      private var buttonLeft:UIButton;
      
      private var buttonRight:UIButton;
      
      private var neighborDefaultSlots:Vector.<NeighborSlotDefault>;
      
      private var neighborPendingSlots:Vector.<NeighborSlotPending>;
      
      private var neighborAddSlots:Vector.<NeighborSlotAdd>;
      
      private var neighborInviteSlots:Vector.<NeighborSlotInvite>;
      
      private var friends:Vector.<Friend>;
      
      private var cursorPos:int = 0;
      
      public function NeighborsScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_neighbors"));
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeScreen);
         cursorPos = 0;
         var _loc2_:TextField = this._design.getChildByName("Text_Header") as TextField;
         _loc2_.text = ProjectManager.getText("NEIGHBOR_SCREEN_HEADER");
         initSlots(this._design.getChildByName("Container_Slots") as MovieClip);
         refreshList();
         buttonLeft = TuxUiUtils.createButton(UIButton,this._design,"Button_Scroll_Left",leftPressed);
         buttonRight = TuxUiUtils.createButton(UIButton,this._design,"Button_Scroll_Right",rightPressed);
         updateArrowStates();
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         buttonClose.dispose();
         buttonClose = null;
         friends = null;
         neighborDefaultSlots = null;
         neighborPendingSlots = null;
         neighborAddSlots = null;
         neighborInviteSlots = null;
      }
      
      private function sortFriendsAccordingStatus(friend1:Friend, friend2:Friend) : int
      {
         if(Friend.STATUS_ORDER.indexOf(friend1.status) < Friend.STATUS_ORDER.indexOf(friend2.status))
         {
            return -1;
         }
         if(Friend.STATUS_ORDER.indexOf(friend1.status) > Friend.STATUS_ORDER.indexOf(friend2.status))
         {
            return 1;
         }
         return friend1.level - friend2.level;
      }
      
      public function refreshList() : void
      {
         var i:int = 0;
         friends = tuxGame.player.friends.getFriends().sort(sortFriendsAccordingStatus);
         for(i = friends.length - 1; i >= 0; )
         {
            if(friends[i].name == null && friends[i].level == 0 && friends[i].status == "NoNeighbor")
            {
               friends.splice(i,1);
            }
            i--;
         }
         addData();
      }
      
      private function initSlots(slots:MovieClip) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         neighborDefaultSlots = new Vector.<NeighborSlotDefault>();
         neighborPendingSlots = new Vector.<NeighborSlotPending>();
         neighborAddSlots = new Vector.<NeighborSlotAdd>();
         neighborInviteSlots = new Vector.<NeighborSlotInvite>();
         for(i = 0; i < slots.numChildren; )
         {
            _loc2_ = MovieClip(slots.getChildByName("Slot_0" + (i + 1)));
            neighborDefaultSlots.push(new NeighborSlotDefault(_loc2_.getChildByName("Neighbor_Default") as MovieClip,tuxGame));
            neighborAddSlots.push(new NeighborSlotAdd(_loc2_.getChildByName("Neighbor_Add") as MovieClip,tuxGame));
            neighborPendingSlots.push(new NeighborSlotPending(_loc2_.getChildByName("Neighbor_Pending") as MovieClip,tuxGame));
            neighborInviteSlots.push(new NeighborSlotInvite(_loc2_.getChildByName("Neighbor_Button") as MovieClip));
            i++;
         }
         slots.visible = true;
      }
      
      private function addData() : void
      {
         var slotIndex:int = 0;
         var friendIndex:int = cursorPos;
         for(slotIndex = 0; slotIndex < neighborDefaultSlots.length; )
         {
            neighborPendingSlots[slotIndex].setFriend(null);
            neighborDefaultSlots[slotIndex].setFriend(null);
            neighborAddSlots[slotIndex].setFriend(null);
            neighborInviteSlots[slotIndex].setVisible(false);
            if(friendIndex == 0 && slotIndex == 0)
            {
               neighborInviteSlots[slotIndex].setVisible(true);
            }
            else if(friendIndex < friends.length && friendIndex >= 0)
            {
               switch(friends[friendIndex].status)
               {
                  case "Pending":
                     neighborPendingSlots[slotIndex].setFriend(friends[friendIndex]);
                     break;
                  case "Neighbor":
                     neighborDefaultSlots[slotIndex].setFriend(friends[friendIndex]);
                     break;
                  case "NoNeighbor":
                     neighborAddSlots[slotIndex].setFriend(friends[friendIndex]);
               }
               friendIndex++;
            }
            slotIndex++;
         }
      }
      
      private function leftPressed(e:MouseEvent) : void
      {
         cursorPos = Math.max(cursorPos - neighborDefaultSlots.length,0);
         addData();
         updateArrowStates();
      }
      
      private function rightPressed(e:MouseEvent) : void
      {
         var posAdd:int = neighborDefaultSlots.length;
         if(cursorPos == 0)
         {
            posAdd--;
         }
         if(cursorPos + posAdd < friends.length)
         {
            cursorPos += posAdd;
         }
         addData();
         updateArrowStates();
      }
      
      private function updateArrowStates() : void
      {
         var leftArrowEnabled:Boolean = cursorPos > 0;
         var rightArrowEnabled:Boolean = cursorPos + neighborDefaultSlots.length < friends.length;
         buttonLeft.setEnabled(leftArrowEnabled);
         buttonRight.setEnabled(rightArrowEnabled);
      }
      
      private function closeScreen(event:MouseEvent) : void
      {
         close();
      }
   }
}
