package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.home.states.money.*;
   import tuxwars.home.states.neighbors.*;
   import tuxwars.home.states.slotmachine.*;
   import tuxwars.home.ui.logic.slotmachine.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.items.data.ItemData;
   import tuxwars.net.*;
   import tuxwars.net.objects.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   import tuxwars.ui.popups.states.slotmachineprize.*;
   import tuxwars.utils.*;
   
   public class SlotMachineScreen extends TuxUIScreen
   {
      private const SLOTMACHINE_SCREEN:String = "slot_machine_popup";
      
      private var buttonClose:UIButton;
      
      private var buttonCashSpinContainer:MovieClip;
      
      private var buttonSpin:UIButton;
      
      private var buttonCashSpin:SecondTextFieldButton;
      
      private var buttonHelp:UIButton;
      
      private var buttonAddFriends:UIButton;
      
      private var _display:SlotMachineText;
      
      private var spins:UIAutoTextField;
      
      private var freeSpins:UIAutoTextField;
      
      private const LINE_SEQUENCE:Array;
      
      private const DISPLAY_SEQUENCE:Array;
      
      private var amountOfFriendsToDisplay:Array;
      
      private var spinsLeft:int;
      
      private var spinPending:Boolean = false;
      
      protected var textFriends:TextField;
      
      private const slotReels:Vector.<SlotMachineReel>;
      
      private const slotLines:Vector.<SlotMachineLine>;
      
      private const jackpotStars:Vector.<MovieClip>;
      
      private var backGround:MovieClip;
      
      private var containerButtons:MovieClip;
      
      private var fireWorks:MovieClip;
      
      private var saldoContainer:MovieClip;
      
      private var textCash:UIAutoTextField;
      
      private var addCashButton:UIButton;
      
      private var _game2:TuxWarsGame;
      
      public function SlotMachineScreen(param1:TuxWarsGame)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.LINE_SEQUENCE = [3,2,1,0,4];
         this.DISPLAY_SEQUENCE = [2,1,3,0,4];
         this.amountOfFriendsToDisplay = [];
         this.slotReels = new Vector.<SlotMachineReel>();
         this.slotLines = new Vector.<SlotMachineLine>();
         this.jackpotStars = new Vector.<MovieClip>();
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/slot_machine.swf","slot_machine_popup"));
         this._game2 = param1;
         
         this.amountOfFriendsToDisplay.push(SlotMachineConfReference.getRow().findField("TopLeftToBottomRightActiveFriends").value);
         
         this.amountOfFriendsToDisplay.push(SlotMachineConfReference.getRow().findField("TopRowActiveFriends").value);
         
         this.amountOfFriendsToDisplay.push(SlotMachineConfReference.getRow().findField("CentralRowActiveFriends").value);
         
         this.amountOfFriendsToDisplay.push(SlotMachineConfReference.getRow().findField("BottomRowActiveFriends").value);
         
         this.amountOfFriendsToDisplay.push(SlotMachineConfReference.getRow().findField("BottomLeftToTopRightActiveFriends").value);
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         this.containerButtons = (this._design as MovieClip).getChildByName("Container_Buttons") as MovieClip;
         this.buttonCashSpinContainer = (this.containerButtons as MovieClip).getChildByName("Button_Spin_Cash") as MovieClip;
         this.saldoContainer = (this._design as MovieClip).getChildByName("Saldo_Cash") as MovieClip;
         this.buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",this.closeScreen);
         this.buttonSpin = TuxUiUtils.createButton(UIButton,this.containerButtons,"Button_Spin",this.Spin,"SPIN");
         this.buttonCashSpin = TuxUiUtils.createButton(SecondTextFieldButton,this.containerButtons,"Button_Spin_Cash",this.CashSpin,"SPIN");
         this.buttonHelp = TuxUiUtils.createButton(UIButton,this._design,"Button_Help",this.Help);
         this.buttonAddFriends = TuxUiUtils.createButton(UIButton,this._design,"Button_Add_Friends",this.AddFriends,"ADD_FRIENDS");
         this.textFriends = MovieClip(this._design).getChildByName("Text_Friends") as TextField;
         this.freeSpins = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_Free_Spins") as TextField,ProjectManager.getText("FREE_SPINS"));
         this.textFriends.text = ProjectManager.getText("SLOTMACHINE_FRIENDS");
         this.textFriends.selectable = false;
         this.saldoContainer = (this._design as MovieClip).getChildByName("Saldo_Cash") as MovieClip;
         this.addCashButton = TuxUiUtils.createButton(UIButton,this.saldoContainer,"Button_Add_Cash",this.addCash,"BUTTON_ADD_PREMIUM");
         this.backGround = (this._design as MovieClip).getChildByName("Background") as MovieClip;
         this.backGround.gotoAndStop("Default");
         this.fireWorks = DCResourceManager.instance.getFromSWF("flash/ui/slot_machine.swf","fireworks");
         this.fireWorks.stop();
         this.fireWorks.visible = false;
         getDesignMovieClip().addChild(this.fireWorks);
         _loc2_ = 0;
         while(_loc2_ <= 2)
         {
            this.slotReels.push(new SlotMachineReel((this._design as MovieClip).getChildByName("Drums") as MovieClip,_loc2_));
            _loc2_++;
         }
         _loc3_ = 5;
         while(_loc3_ > 0)
         {
            this.slotLines.push(new SlotMachineLine((this._design as MovieClip).getChildByName("Line_0" + _loc3_) as MovieClip,_loc3_,this.amountOfFriendsToDisplay[_loc3_ - 1]));
            _loc3_--;
         }
         _loc4_ = 1;
         while(_loc4_ <= 9)
         {
            this.jackpotStars.push((this._design as MovieClip).getChildByName("Three_In_A_Row_Slot_0" + _loc4_) as MovieClip);
            this.jackpotStars[_loc4_ - 1].visible = false;
            _loc4_++;
         }
         this._display = new SlotMachineText((this._design as MovieClip).getChildByName("Display") as MovieClip);
         this.spins = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_Spins") as TextField,"" + this.spinsLeft);
         
         this.buttonCashSpin.setTextSecond("" + SlotMachineConfReference.getRow().findField("PlayPriceInCash").value,"Text_Price");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.setSpinsLeft();
         this.spinButtonEnable();
         this.textCash = TuxUiUtils.createAutoTextFieldWithText((this.saldoContainer as MovieClip).getChildByName("Text_Cash") as TextField,"" + this.slotMachineLogic.getPlayerCash());
         this.checkNoSpins();
      }
      
      public function setSpinsLeft() : void
      {
         this.spinsLeft = this.slotMachineLogic.returnMaxDailySpins() - this._game2.player.slotMachineSpinsUsed;
         trace("Spins Left: " + this.spinsLeft);
         if(this.spinsLeft >= 0)
         {
            this.spins.setText("" + this.spinsLeft);
         }
         else
         {
            this.spins.setText("0");
         }
      }
      
      public function playBackGroundRotationAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this.backGround,"Win"));
         this.backGround.addFrameScript(_loc1_,this.stopBackGroundAnim);
         this.backGround.gotoAndPlay("Rotation");
         var _loc2_:SoundReference = Sounds.getSoundReference("SlotMachineSpinLight");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
         }
      }
      
      public function stopBackGroundAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this.backGround,"Stop"));
         this.backGround.addFrameScript(_loc1_,null);
         this.backGround.gotoAndStop("Default");
      }
      
      public function stopBackGroundAnimToWin() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this.backGround,"Stop"));
         this.backGround.addFrameScript(_loc1_,null);
         this.backGround.gotoAndStop("Win");
      }
      
      public function setAward(param1:SlotWinReference, param2:String, param3:ItemData, param4:int) : void
      {
         this.display.gotoWin(param1,param2,param3,param4,this._game2);
      }
      
      public function playBackGroundWinAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this.backGround,"Win"));
         this.backGround.addFrameScript(_loc1_,null);
         _loc1_ = int(DCUtils.indexOfLabel(this.backGround,"Stop"));
         this.backGround.addFrameScript(_loc1_,this.stopBackGroundAnimToWin);
         this.backGround.gotoAndPlay("Win");
      }
      
      public function playStartSound() : void
      {
         var _loc1_:SoundReference = Sounds.getSoundReference("SlotMachineWin");
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
         }
      }
      
      public function getReels() : Vector.<SlotMachineReel>
      {
         return this.slotReels;
      }
      
      public function setLineText() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this.slotLines[_loc1_].setText(this.amountOfFriendsToDisplay[_loc1_]);
            _loc1_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         IHomeScreen(this._game2.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         var _loc1_:int = int(DCUtils.indexOfLabel(this.backGround,"Stop"));
         this.backGround.addFrameScript(_loc1_,null);
         _loc1_ = int(DCUtils.indexOfLabel(this.backGround,"Win"));
         this.backGround.addFrameScript(_loc1_,null);
         super.dispose();
         this.buttonClose.dispose();
         this.buttonClose = null;
         this.buttonSpin.dispose();
         this.buttonSpin = null;
         this.buttonHelp.dispose();
         this.buttonHelp = null;
         this.buttonAddFriends.dispose();
         this.buttonAddFriends = null;
         this._display.dispose();
         this._display = null;
         this.spins = null;
         for each(_loc2_ in this.slotReels)
         {
            _loc2_.dispose();
         }
         this.slotReels.splice(0,this.slotReels.length);
         for each(_loc3_ in this.slotLines)
         {
            _loc3_.dispose();
         }
         this.slotLines.splice(0,this.slotLines.length);
         this.backGround = null;
      }
      
      private function get slotMachineLogic() : SlotMachineLogic
      {
         return logic;
      }
      
      public function setLineStateDefault(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ <= param1)
         {
            this.slotLines[this.DISPLAY_SEQUENCE[_loc2_]].setDefaultState();
            _loc2_++;
         }
      }
      
      public function winLine(param1:int) : void
      {
         this.slotLines[this.LINE_SEQUENCE[param1]].setActiveState();
      }
      
      public function flashLine(param1:int) : void
      {
         this.slotLines[this.LINE_SEQUENCE[param1]].setWinState();
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function closeScreen(param1:MouseEvent) : void
      {
         this.slotMachineLogic.giveAllRewards();
         super.close();
      }
      
      public function enableAllButtons() : void
      {
         this.buttonAddFriends.setEnabled(true);
         this.addCashButton.setEnabled(true);
         this.buttonHelp.setEnabled(true);
         this.buttonSpin.setEnabled(true);
         if(this.spinsLeft > 0)
         {
            this.buttonSpin.setVisible(true);
            this.buttonCashSpin.setVisible(false);
            this.buttonSpin.setEnabled(true);
         }
         else
         {
            this.buttonSpin.setVisible(false);
            this.buttonCashSpin.setVisible(true);
            this.buttonCashSpin.setEnabled(true);
         }
      }
      
      public function disableAllButtons() : void
      {
         this.buttonAddFriends.setEnabled(false);
         this.addCashButton.setEnabled(false);
         this.buttonHelp.setEnabled(false);
         if(this.spinsLeft > 0)
         {
            this.buttonSpin.setVisible(true);
            this.buttonCashSpin.setVisible(false);
            this.buttonSpin.setEnabled(false);
         }
         else
         {
            this.buttonSpin.setVisible(false);
            this.buttonCashSpin.setVisible(true);
            this.buttonCashSpin.setEnabled(false);
         }
      }
      
      public function spinButtonDisable() : void
      {
         this.buttonSpin.setEnabled(false);
      }
      
      public function spinButtonEnable() : void
      {
         this.buttonSpin.setEnabled(this.spinsLeft > 0);
      }
      
      public function checkNoSpins() : void
      {
         if(this.spinsLeft > 0)
         {
            this.buttonSpin.setVisible(true);
            this.buttonCashSpin.setVisible(false);
         }
         else
         {
            this.buttonSpin.setVisible(false);
            this.buttonCashSpin.setVisible(true);
            if(this.slotMachineLogic.checkOutOfCash())
            {
               this.display.gotoNoSpins();
            }
         }
      }
      
      public function displayPressSpin() : void
      {
         this.display.gotoDefault();
      }
      
      private function Spin(param1:MouseEvent) : void
      {
         this._game2.spinPressed = true;
         this.slotMachineLogic.giveAllRewards();
         this.startSpin();
      }
      
      private function CashSpin(param1:MouseEvent) : void
      {
         if(this.slotMachineLogic.cashSpin())
         {
            this.slotMachineLogic.giveAllRewards();
            this.startSpin();
         }
         else
         {
            this.popUpOutOfCash();
         }
      }
      
      private function startSpin() : void
      {
         CRMService.sendEvent("SlotMachine","Play_SlotMachine","Clicked","Pull_Lever");
         if(this.spinsLeft > 0)
         {
            --this.spinsLeft;
            this.spins.setText("" + this.spinsLeft);
         }
         this.textCash.setText("" + this.slotMachineLogic.getPlayerCash());
         this.buttonSpin.setEnabled(false);
         this.disableAllButtons();
         this.stopJackpotStars();
         this.display.gotoRotation();
         this.slotMachineLogic.start();
         this.setLineStateDefault(this.slotMachineLogic.getAmountFriends());
         var _loc1_:SoundReference = Sounds.getSoundReference("SlotMachineSpin");
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
         }
         var _loc2_:SoundReference = Sounds.getSoundReference("SlotMachineStart");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
         }
      }
      
      private function AddFriends(param1:MouseEvent) : void
      {
         this.slotMachineLogic.giveAllRewards();
         this._game2.homeState.changeState(new NeighborState(this._game2));
      }
      
      private function addCash(param1:MouseEvent) : void
      {
         MessageCenter.addListener("showMoneyState",this.openMoneyState);
         this.slotMachineLogic.giveAllRewards();
         CRMService.sendEvent("Game","Menu","Clicked","Add_Cash","SlotMachine");
         JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
      }
      
      private function openMoneyState(param1:Message) : void
      {
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         var _loc2_:* = JSON.parse(param1.data);
         if(_loc2_ != null)
         {
            if(_loc2_.type == "Cash")
            {
               this._game2.homeState.changeState(new MoneyState(this._game2,"popup_get_cash_new"));
            }
            else
            {
               LogUtils.log("sendMessage: No eventListener for type: " + _loc2_.type + " in SLOTMACHINE",null,2,"Messages",false,false,false);
            }
         }
      }
      
      private function popUpOutOfCash() : void
      {
         this.slotMachineLogic.giveAllRewards();
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(this._game2,"Cash"),this._game2.currentState);
      }
      
      public function startJackpotStar(param1:int) : void
      {
         this.jackpotStars[param1 - 1].visible = true;
         this.fireWorks.visible = true;
         this.fireWorks.play();
      }
      
      public function stopJackpotStars() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            this.jackpotStars[_loc1_ - 1].visible = false;
            _loc1_++;
         }
         this.fireWorks.visible = false;
         this.fireWorks.stop();
      }
      
      private function Help(param1:MouseEvent) : void
      {
         this.slotMachineLogic.giveAllRewards();
         var _loc2_:SlotMachineUISubState = this.slotMachineLogic.state as SlotMachineUISubState;
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.triggerPopup(new SlotmachinePrizeSubState(this._game2),_loc2_);
      }
      
      public function get display() : SlotMachineText
      {
         return this._display;
      }
   }
}

