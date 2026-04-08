package tuxwars.home.ui.screen.home
{
   import com.dchoc.friends.*;
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.slotmachine.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.home.ui.screen.slotmachine.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class FriendsElementScreen extends TuxUIElementScreen
   {
      private static const FRIEND_SLOTS_AMOUNT:int = 5;
      
      private static const FRIEND_BAR:String = "HUD_Friends_Bar";
      
      private static const BUTTON_INVITE:String = "Button_Invite";
      
      private static const BUTTON_SCROLL_LEFT:String = "Button_Scroll_Left";
      
      private static const BUTTON_FAST_FORWARD_LEFT:String = "Button_FastForward_Left";
      
      private static const BUTTON_SCROLL_RIGHT:String = "Button_Scroll_Right";
      
      private static const BUTTON_FAST_FORWARD_RIGHT:String = "Button_FastForward_Right";
      
      private static const BUTTON_SLOT_MACHINE:String = "Button_Slot_Machine";
      
      private static const BUTTON_SLOT_MACHINE_DEFAULT:String = "Default";
      
      private static const BUTTON_SLOT_MACHINE_ACTIVE:String = "Active";
      
      private static const BUTTON_OPTIONS:String = "Button_Options";
      
      private static const CONTAINER_SLOTS:String = "Container_Slots";
      
      private static const FRIEND_SLOT:String = "Slot_0";
      
      private var totalAmountOfAvailableSlots:int;
      
      private var buttonLeft:UIButton;
      
      private var buttonLeftFull:UIButton;
      
      private var buttonRight:UIButton;
      
      private var buttonRightFull:UIButton;
      
      private var buttonSlotMachine:UIButton;
      
      private var buttonSlotMachineFreeSpins:SlotMachineButton;
      
      private var friendSlots:Vector.<FriendSlot>;
      
      private var friends:Vector.<Friend>;
      
      private var cursorPos:int = 0;
      
      private var toolsElementWindow:ToolsElementScreen;
      
      private var optionsButton:UIButton;
      
      public function FriendsElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         this.friendSlots = new Vector.<FriendSlot>();
         this.friends = new Vector.<Friend>();
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         DCUtils.stopMovieClip(_loc3_);
         var _loc4_:MovieClip = _loc3_.getChildByName("HUD_Friends_Bar") as MovieClip;
         DCUtils.playMovieClip(_loc4_);
         TuxUiUtils.setMovieClipPosition(_loc4_,"bottom","center");
         param1.addChild(_loc4_);
         this.initSlots(_loc4_.getChildByName("Container_Slots") as MovieClip);
         super(_loc4_,param2);
         this.initFriends();
         this.addData();
         this.toolsElementWindow = new ToolsElementScreen(_loc4_,param2);
         this.optionsButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Options",this.toolsElementWindow.optionsCallback,null,"TOOLTIP_SETTINGS");
         this.optionsButton.addEventListener("out",this.mouseOut,false,0,true);
         this.optionsButton.addEventListener("over",this.mouseOver,false,0,true);
         this.buttonLeft = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Scroll_Left",this.leftPressed,null,"TOOLTIP_FRIENDS_BAR_MOVE_1_LEFT");
         this.buttonLeft.addEventListener("out",this.mouseOut,false,0,true);
         this.buttonLeft.addEventListener("over",this.mouseOver,false,0,true);
         this.buttonLeftFull = TuxUiUtils.createButton(UIButton,_loc4_,"Button_FastForward_Left",this.leftPressedFull,null,"TOOLTIP_FRIENDS_BAR_MOVE_PAGE_LEFT");
         this.buttonLeftFull.addEventListener("out",this.mouseOut,false,0,true);
         this.buttonLeftFull.addEventListener("over",this.mouseOver,false,0,true);
         this.buttonRight = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Scroll_Right",this.rightPressed,null,"TOOLTIP_FRIENDS_BAR_MOVE_1_RIGHT");
         this.buttonRight.addEventListener("out",this.mouseOut,false,0,true);
         this.buttonRight.addEventListener("over",this.mouseOver,false,0,true);
         this.buttonRightFull = TuxUiUtils.createButton(UIButton,_loc4_,"Button_FastForward_Right",this.rightPressedFull,null,"TOOLTIP_FRIENDS_BAR_MOVE_PAGE_RIGHT");
         this.buttonRightFull.addEventListener("out",this.mouseOut,false,0,true);
         this.buttonRightFull.addEventListener("over",this.mouseOver,false,0,true);
         this.buttonSlotMachine = TuxUiUtils.createButton(UIButton,_loc4_.getChildByName("Button_Slot_Machine") as MovieClip,"Default",this.slotMachineCallback,null,"TOOLTIP_SLOT_MACHINE");
         this.buttonSlotMachine.addEventListener("out",this.mouseOut,false,0,true);
         this.buttonSlotMachine.addEventListener("over",this.mouseOver,false,0,true);
         this.buttonSlotMachineFreeSpins = TuxUiUtils.createButton(SlotMachineButton,_loc4_.getChildByName("Button_Slot_Machine") as MovieClip,"Active",this.slotMachineCallback,null,"TOOLTIP_SLOT_MACHINE");
         this.buttonSlotMachineFreeSpins.addEventListener("out",this.mouseOut,false,0,true);
         this.buttonSlotMachineFreeSpins.addEventListener("over",this.mouseOver,false,0,true);
         this.buttonSlotMachineFreeSpins.init(param2.player);
         MessageCenter.addListener("SlotMachineFreeSpinsUsed",this.setSlotMachineButton);
         this.setSlotMachineButton();
         this.setAvailabilityToAllButtons(!Tutorial._tutorial);
         this.updateArrowStates();
         MessageCenter.addListener("LevelUp",this.levelUp);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("LevelUp",this.levelUp);
         this.optionsButton.removeEventListener("out",this.mouseOut);
         this.optionsButton.removeEventListener("over",this.mouseOver);
         this.buttonSlotMachine.removeEventListener("out",this.mouseOut);
         this.buttonSlotMachine.removeEventListener("over",this.mouseOver);
         this.buttonSlotMachineFreeSpins.removeEventListener("out",this.mouseOut);
         this.buttonSlotMachineFreeSpins.removeEventListener("over",this.mouseOver);
         MessageCenter.removeListener("SlotMachineFreeSpinsUsed",this.setSlotMachineButton);
         this.friends = null;
         this.friendSlots = null;
         this.buttonLeft.dispose();
         this.buttonLeftFull.dispose();
         this.buttonLeft = null;
         this.buttonLeftFull = null;
         this.buttonRight.dispose();
         this.buttonRight = null;
         this.buttonRightFull.dispose();
         this.buttonRightFull = null;
         this.buttonSlotMachine.dispose();
         this.buttonSlotMachine = null;
         this.buttonSlotMachineFreeSpins.dispose();
         this.buttonSlotMachineFreeSpins = null;
         this.toolsElementWindow.dispose();
         this.toolsElementWindow = null;
         this.optionsButton.dispose();
         this.optionsButton = null;
         super.dispose();
      }
      
      public function refreshFriends() : void
      {
         this.initFriends();
         this.addData();
      }
      
      override public function fullscreenChanged(param1:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(getDesignMovieClip(),"bottom","center");
         this.toolsElementWindow.fullscreenChanged(param1);
      }
      
      private function initFriends() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.friends = new Vector.<Friend>();
         for each(_loc3_ in game.player.friends.friends)
         {
            if(Boolean(_loc3_.isNeighbor()) || Boolean(_loc3_.isMe()))
            {
               this.friends.push(_loc3_);
            }
         }
         this.friends = this.friends.sort(this.sortFriendsAccordingLevel);
         this.cursorPos = 0;
         if(this.friends.length > 5)
         {
            _loc1_ = int(this.friends.indexOf(game.player.friends.findMe()));
            _loc2_ = _loc1_ - 2;
            while(_loc2_ < 0)
            {
               _loc2_++;
            }
            while(_loc2_ + 5 > this.friends.length)
            {
               _loc2_--;
            }
            this.cursorPos = _loc2_;
         }
      }
      
      public function setAvailabilityToAllButtons(param1:Boolean) : void
      {
         this.buttonLeft.setEnabled(param1);
         this.buttonLeftFull.setEnabled(param1);
         this.buttonRight.setEnabled(param1);
         this.buttonRightFull.setEnabled(param1);
         this.buttonSlotMachine.setEnabled(param1);
         this.buttonSlotMachineFreeSpins.setEnabled(param1);
      }
      
      private function sortFriendsAccordingLevel(param1:Friend, param2:Friend) : int
      {
         return param1.level - param2.level;
      }
      
      private function initSlots(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:FriendSlot = null;
         this.totalAmountOfAvailableSlots = param1.numChildren;
         _loc2_ = 0;
         while(_loc2_ < this.totalAmountOfAvailableSlots)
         {
            _loc3_ = new FriendSlot(param1.getChildByName("Slot_0" + (_loc2_ + 1)) as MovieClip);
            this.friendSlots.push(_loc3_);
            _loc2_++;
         }
         param1.visible = true;
      }
      
      private function addData() : void
      {
         var _loc1_:int = int(this.cursorPos);
         var _loc2_:int = 0;
         while(_loc2_ < this.totalAmountOfAvailableSlots)
         {
            if(_loc1_ < this.friends.length && _loc1_ >= 0 && _loc2_ < 5)
            {
               this.friendSlots[_loc2_].setFriend(this.friends[_loc1_]);
               _loc2_++;
               _loc1_++;
            }
            else
            {
               this.friendSlots[_loc2_].setFriend(null);
               _loc2_++;
            }
         }
      }
      
      private function leftPressed(param1:MouseEvent) : void
      {
         this.cursorPos = Math.max(this.cursorPos - 1,0);
         this.addData();
         this.updateArrowStates();
         TooltipManager.removeTooltip();
      }
      
      private function leftPressedFull(param1:MouseEvent) : void
      {
         this.cursorPos = 0;
         this.addData();
         this.updateArrowStates();
         TooltipManager.removeTooltip();
      }
      
      private function rightPressed(param1:MouseEvent) : void
      {
         this.cursorPos = Math.min(this.cursorPos + 1,this.friends.length - 1);
         this.addData();
         this.updateArrowStates();
         TooltipManager.removeTooltip();
      }
      
      private function rightPressedFull(param1:MouseEvent) : void
      {
         this.cursorPos = this.friends.length - 5 > 0 ? int(this.friends.length - 5) : 0;
         this.addData();
         this.updateArrowStates();
         TooltipManager.removeTooltip();
      }
      
      private function updateArrowStates() : void
      {
         var _loc1_:* = this.cursorPos > 0;
         var _loc2_:* = this.cursorPos + 5 < this.friends.length;
         this.buttonLeft.setEnabled(_loc1_);
         this.buttonLeftFull.setEnabled(_loc1_);
         this.buttonRight.setEnabled(_loc2_);
         this.buttonRightFull.setEnabled(_loc2_);
      }
      
      private function slotMachineCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","SlotMachine");
         game.homeState.changeState(new SlotMachineState(game));
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function levelUp(param1:Message) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.friends)
         {
            if(_loc2_.isMe())
            {
               _loc2_.level = game.player.level;
            }
         }
         this.friends = this.friends.sort(this.sortFriendsAccordingLevel);
         this.addData();
         this.updateArrowStates();
      }
      
      private function setSlotMachineButton(param1:Message = null) : void
      {
         var _loc2_:int = int(SlotMachineButton.getFreeDailySpins(game.player));
         var _loc3_:Boolean = Boolean(this.buttonSlotMachine.getShowTransitions());
         this.buttonSlotMachine.setShowTransitions(false);
         this.buttonSlotMachine.setVisible(_loc2_ <= 0);
         this.buttonSlotMachine.setShowTransitions(_loc3_);
         _loc3_ = Boolean(this.buttonSlotMachineFreeSpins.getShowTransitions());
         this.buttonSlotMachineFreeSpins.setShowTransitions(false);
         this.buttonSlotMachineFreeSpins.setVisible(_loc2_ > 0);
         this.buttonSlotMachineFreeSpins.setShowTransitions(_loc3_);
         this.buttonSlotMachineFreeSpins.init(game.player);
      }
   }
}

