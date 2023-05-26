package tuxwars.home.ui.screen.home
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.slotmachine.SlotMachineState;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.home.ui.screen.slotmachine.SlotMachineButton;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.components.ToolsElementScreen;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function FriendsElementScreen(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         friendSlots = new Vector.<FriendSlot>();
         friends = new Vector.<Friend>();
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         DCUtils.stopMovieClip(_loc3_);
         var _loc4_:MovieClip = _loc3_.getChildByName("HUD_Friends_Bar") as MovieClip;
         DCUtils.playMovieClip(_loc4_);
         TuxUiUtils.setMovieClipPosition(_loc4_,"bottom","center");
         whereToAdd.addChild(_loc4_);
         initSlots(_loc4_.getChildByName("Container_Slots") as MovieClip);
         super(_loc4_,game);
         initFriends();
         addData();
         toolsElementWindow = new ToolsElementScreen(_loc4_,game);
         optionsButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Options",toolsElementWindow.optionsCallback,null,"TOOLTIP_SETTINGS");
         optionsButton.addEventListener("out",mouseOut,false,0,true);
         optionsButton.addEventListener("over",mouseOver,false,0,true);
         buttonLeft = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Scroll_Left",leftPressed,null,"TOOLTIP_FRIENDS_BAR_MOVE_1_LEFT");
         buttonLeft.addEventListener("out",mouseOut,false,0,true);
         buttonLeft.addEventListener("over",mouseOver,false,0,true);
         buttonLeftFull = TuxUiUtils.createButton(UIButton,_loc4_,"Button_FastForward_Left",leftPressedFull,null,"TOOLTIP_FRIENDS_BAR_MOVE_PAGE_LEFT");
         buttonLeftFull.addEventListener("out",mouseOut,false,0,true);
         buttonLeftFull.addEventListener("over",mouseOver,false,0,true);
         buttonRight = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Scroll_Right",rightPressed,null,"TOOLTIP_FRIENDS_BAR_MOVE_1_RIGHT");
         buttonRight.addEventListener("out",mouseOut,false,0,true);
         buttonRight.addEventListener("over",mouseOver,false,0,true);
         buttonRightFull = TuxUiUtils.createButton(UIButton,_loc4_,"Button_FastForward_Right",rightPressedFull,null,"TOOLTIP_FRIENDS_BAR_MOVE_PAGE_RIGHT");
         buttonRightFull.addEventListener("out",mouseOut,false,0,true);
         buttonRightFull.addEventListener("over",mouseOver,false,0,true);
         buttonSlotMachine = TuxUiUtils.createButton(UIButton,_loc4_.getChildByName("Button_Slot_Machine") as MovieClip,"Default",slotMachineCallback,null,"TOOLTIP_SLOT_MACHINE");
         buttonSlotMachine.addEventListener("out",mouseOut,false,0,true);
         buttonSlotMachine.addEventListener("over",mouseOver,false,0,true);
         buttonSlotMachineFreeSpins = TuxUiUtils.createButton(SlotMachineButton,_loc4_.getChildByName("Button_Slot_Machine") as MovieClip,"Active",slotMachineCallback,null,"TOOLTIP_SLOT_MACHINE");
         buttonSlotMachineFreeSpins.addEventListener("out",mouseOut,false,0,true);
         buttonSlotMachineFreeSpins.addEventListener("over",mouseOver,false,0,true);
         buttonSlotMachineFreeSpins.init(game.player);
         MessageCenter.addListener("SlotMachineFreeSpinsUsed",setSlotMachineButton);
         setSlotMachineButton();
         var _loc5_:Tutorial = Tutorial;
         setAvailabilityToAllButtons(!tuxwars.tutorial.Tutorial._tutorial);
         updateArrowStates();
         MessageCenter.addListener("LevelUp",levelUp);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("LevelUp",levelUp);
         optionsButton.removeEventListener("out",mouseOut);
         optionsButton.removeEventListener("over",mouseOver);
         buttonSlotMachine.removeEventListener("out",mouseOut);
         buttonSlotMachine.removeEventListener("over",mouseOver);
         buttonSlotMachineFreeSpins.removeEventListener("out",mouseOut);
         buttonSlotMachineFreeSpins.removeEventListener("over",mouseOver);
         MessageCenter.removeListener("SlotMachineFreeSpinsUsed",setSlotMachineButton);
         friends = null;
         friendSlots = null;
         buttonLeft.dispose();
         buttonLeftFull.dispose();
         buttonLeft = null;
         buttonLeftFull = null;
         buttonRight.dispose();
         buttonRight = null;
         buttonRightFull.dispose();
         buttonRightFull = null;
         buttonSlotMachine.dispose();
         buttonSlotMachine = null;
         buttonSlotMachineFreeSpins.dispose();
         buttonSlotMachineFreeSpins = null;
         toolsElementWindow.dispose();
         toolsElementWindow = null;
         optionsButton.dispose();
         optionsButton = null;
         super.dispose();
      }
      
      public function refreshFriends() : void
      {
         initFriends();
         addData();
      }
      
      override public function fullscreenChanged(fullscreen:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(getDesignMovieClip(),"bottom","center");
         toolsElementWindow.fullscreenChanged(fullscreen);
      }
      
      private function initFriends() : void
      {
         var _loc2_:int = 0;
         var centralizedPos:int = 0;
         friends = new Vector.<Friend>();
         for each(var f in game.player.friends.friends)
         {
            if(f.isNeighbor() || f.isMe())
            {
               friends.push(f);
            }
         }
         friends = friends.sort(sortFriendsAccordingLevel);
         cursorPos = 0;
         if(friends.length > 5)
         {
            _loc2_ = friends.indexOf(game.player.friends.findMe());
            centralizedPos = _loc2_ - 2;
            while(centralizedPos < 0)
            {
               centralizedPos++;
            }
            while(centralizedPos + 5 > friends.length)
            {
               centralizedPos--;
            }
            cursorPos = centralizedPos;
         }
      }
      
      public function setAvailabilityToAllButtons(value:Boolean) : void
      {
         buttonLeft.setEnabled(value);
         buttonLeftFull.setEnabled(value);
         buttonRight.setEnabled(value);
         buttonRightFull.setEnabled(value);
         buttonSlotMachine.setEnabled(value);
         buttonSlotMachineFreeSpins.setEnabled(value);
      }
      
      private function sortFriendsAccordingLevel(friend1:Friend, friend2:Friend) : int
      {
         return friend1.level - friend2.level;
      }
      
      private function initSlots(slots:MovieClip) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         totalAmountOfAvailableSlots = slots.numChildren;
         for(i = 0; i < totalAmountOfAvailableSlots; )
         {
            _loc2_ = new FriendSlot(slots.getChildByName("Slot_0" + (i + 1)) as MovieClip);
            friendSlots.push(_loc2_);
            i++;
         }
         slots.visible = true;
      }
      
      private function addData() : void
      {
         var idx:int = cursorPos;
         var i:int = 0;
         while(i < totalAmountOfAvailableSlots)
         {
            if(idx < friends.length && idx >= 0 && i < 5)
            {
               friendSlots[i].setFriend(friends[idx]);
               i++;
               idx++;
            }
            else
            {
               friendSlots[i].setFriend(null);
               i++;
            }
         }
      }
      
      private function leftPressed(e:MouseEvent) : void
      {
         cursorPos = Math.max(cursorPos - 1,0);
         addData();
         updateArrowStates();
         TooltipManager.removeTooltip();
      }
      
      private function leftPressedFull(e:MouseEvent) : void
      {
         cursorPos = 0;
         addData();
         updateArrowStates();
         TooltipManager.removeTooltip();
      }
      
      private function rightPressed(e:MouseEvent) : void
      {
         cursorPos = Math.min(cursorPos + 1,friends.length - 1);
         addData();
         updateArrowStates();
         TooltipManager.removeTooltip();
      }
      
      private function rightPressedFull(e:MouseEvent) : void
      {
         cursorPos = friends.length - 5 > 0 ? friends.length - 5 : 0;
         addData();
         updateArrowStates();
         TooltipManager.removeTooltip();
      }
      
      private function updateArrowStates() : void
      {
         var leftArrowEnabled:Boolean = cursorPos > 0;
         var rightArrowEnabled:Boolean = cursorPos + 5 < friends.length;
         buttonLeft.setEnabled(leftArrowEnabled);
         buttonLeftFull.setEnabled(leftArrowEnabled);
         buttonRight.setEnabled(rightArrowEnabled);
         buttonRightFull.setEnabled(rightArrowEnabled);
      }
      
      private function slotMachineCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","SlotMachine");
         game.homeState.changeState(new SlotMachineState(game));
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function levelUp(msg:Message) : void
      {
         for each(var friend in friends)
         {
            if(friend.isMe())
            {
               friend.level = game.player.level;
            }
         }
         friends = friends.sort(sortFriendsAccordingLevel);
         addData();
         updateArrowStates();
      }
      
      private function setSlotMachineButton(msg:Message = null) : void
      {
         var _loc3_:int = SlotMachineButton.getFreeDailySpins(game.player);
         var oldTransition:Boolean = buttonSlotMachine.getShowTransitions();
         buttonSlotMachine.setShowTransitions(false);
         buttonSlotMachine.setVisible(_loc3_ <= 0);
         buttonSlotMachine.setShowTransitions(oldTransition);
         oldTransition = buttonSlotMachineFreeSpins.getShowTransitions();
         buttonSlotMachineFreeSpins.setShowTransitions(false);
         buttonSlotMachineFreeSpins.setVisible(_loc3_ > 0);
         buttonSlotMachineFreeSpins.setShowTransitions(oldTransition);
         buttonSlotMachineFreeSpins.init(game.player);
      }
   }
}
