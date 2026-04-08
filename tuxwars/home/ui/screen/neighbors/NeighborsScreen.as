package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.utils.*;
   
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
      
      public function NeighborsScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_neighbors"));
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         this.buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",this.closeScreen);
         this.cursorPos = 0;
         var _loc2_:TextField = this._design.getChildByName("Text_Header") as TextField;
         _loc2_.text = ProjectManager.getText("NEIGHBOR_SCREEN_HEADER");
         this.initSlots(this._design.getChildByName("Container_Slots") as MovieClip);
         this.refreshList();
         this.buttonLeft = TuxUiUtils.createButton(UIButton,this._design,"Button_Scroll_Left",this.leftPressed);
         this.buttonRight = TuxUiUtils.createButton(UIButton,this._design,"Button_Scroll_Right",this.rightPressed);
         this.updateArrowStates();
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         this.buttonClose.dispose();
         this.buttonClose = null;
         this.friends = null;
         this.neighborDefaultSlots = null;
         this.neighborPendingSlots = null;
         this.neighborAddSlots = null;
         this.neighborInviteSlots = null;
      }
      
      private function sortFriendsAccordingStatus(param1:Friend, param2:Friend) : int
      {
         if(Friend.STATUS_ORDER.indexOf(param1.status) < Friend.STATUS_ORDER.indexOf(param2.status))
         {
            return -1;
         }
         if(Friend.STATUS_ORDER.indexOf(param1.status) > Friend.STATUS_ORDER.indexOf(param2.status))
         {
            return 1;
         }
         return param1.level - param2.level;
      }
      
      public function refreshList() : void
      {
         var _loc1_:int = 0;
         this.friends = tuxGame.player.friends.getFriends().sort(this.sortFriendsAccordingStatus);
         _loc1_ = this.friends.length - 1;
         while(_loc1_ >= 0)
         {
            if(this.friends[_loc1_].name == null && this.friends[_loc1_].level == 0 && this.friends[_loc1_].status == "NoNeighbor")
            {
               this.friends.splice(_loc1_,1);
            }
            _loc1_--;
         }
         this.addData();
      }
      
      private function initSlots(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.neighborDefaultSlots = new Vector.<NeighborSlotDefault>();
         this.neighborPendingSlots = new Vector.<NeighborSlotPending>();
         this.neighborAddSlots = new Vector.<NeighborSlotAdd>();
         this.neighborInviteSlots = new Vector.<NeighborSlotInvite>();
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = MovieClip(param1.getChildByName("Slot_0" + (_loc2_ + 1)));
            this.neighborDefaultSlots.push(new NeighborSlotDefault(_loc3_.getChildByName("Neighbor_Default") as MovieClip,tuxGame));
            this.neighborAddSlots.push(new NeighborSlotAdd(_loc3_.getChildByName("Neighbor_Add") as MovieClip,tuxGame));
            this.neighborPendingSlots.push(new NeighborSlotPending(_loc3_.getChildByName("Neighbor_Pending") as MovieClip,tuxGame));
            this.neighborInviteSlots.push(new NeighborSlotInvite(_loc3_.getChildByName("Neighbor_Button") as MovieClip));
            _loc2_++;
         }
         param1.visible = true;
      }
      
      private function addData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(this.cursorPos);
         _loc1_ = 0;
         while(_loc1_ < this.neighborDefaultSlots.length)
         {
            this.neighborPendingSlots[_loc1_].setFriend(null);
            this.neighborDefaultSlots[_loc1_].setFriend(null);
            this.neighborAddSlots[_loc1_].setFriend(null);
            this.neighborInviteSlots[_loc1_].setVisible(false);
            if(_loc2_ == 0 && _loc1_ == 0)
            {
               this.neighborInviteSlots[_loc1_].setVisible(true);
            }
            else if(_loc2_ < this.friends.length && _loc2_ >= 0)
            {
               switch(this.friends[_loc2_].status)
               {
                  case "Pending":
                     this.neighborPendingSlots[_loc1_].setFriend(this.friends[_loc2_]);
                     break;
                  case "Neighbor":
                     this.neighborDefaultSlots[_loc1_].setFriend(this.friends[_loc2_]);
                     break;
                  case "NoNeighbor":
                     this.neighborAddSlots[_loc1_].setFriend(this.friends[_loc2_]);
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function leftPressed(param1:MouseEvent) : void
      {
         this.cursorPos = Math.max(this.cursorPos - this.neighborDefaultSlots.length,0);
         this.addData();
         this.updateArrowStates();
      }
      
      private function rightPressed(param1:MouseEvent) : void
      {
         var _loc2_:int = int(this.neighborDefaultSlots.length);
         if(this.cursorPos == 0)
         {
            _loc2_--;
         }
         if(this.cursorPos + _loc2_ < this.friends.length)
         {
            this.cursorPos += _loc2_;
         }
         this.addData();
         this.updateArrowStates();
      }
      
      private function updateArrowStates() : void
      {
         var _loc1_:* = this.cursorPos > 0;
         var _loc2_:* = this.cursorPos + this.neighborDefaultSlots.length < this.friends.length;
         this.buttonLeft.setEnabled(_loc1_);
         this.buttonRight.setEnabled(_loc2_);
      }
      
      private function closeScreen(param1:MouseEvent) : void
      {
         close();
      }
   }
}

