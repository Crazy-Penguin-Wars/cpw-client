package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.home.states.money.MoneyState;
   import tuxwars.home.states.neighbors.NeighborState;
   import tuxwars.home.states.slotmachine.SlotMachineUISubState;
   import tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference;
   import tuxwars.home.ui.logic.slotmachine.SlotMachineLogic;
   import tuxwars.home.ui.logic.slotmachine.SlotWinReference;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.items.data.ItemData;
   import tuxwars.net.CRMService;
   import tuxwars.net.JavaScriptServices;
   import tuxwars.net.objects.ShowPaymentObject;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   import tuxwars.ui.popups.states.slotmachineprize.SlotmachinePrizeSubState;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      private const LINE_SEQUENCE:Array = [3,2,1,0,4];
      
      private const DISPLAY_SEQUENCE:Array = [2,1,3,0,4];
      
      private var amountOfFriendsToDisplay:Array;
      
      private var spinsLeft:int;
      
      private var spinPending:Boolean = false;
      
      protected var textFriends:TextField;
      
      private const slotReels:Vector.<SlotMachineReel> = new Vector.<SlotMachineReel>();
      
      private const slotLines:Vector.<SlotMachineLine> = new Vector.<SlotMachineLine>();
      
      private const jackpotStars:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private var backGround:MovieClip;
      
      private var containerButtons:MovieClip;
      
      private var fireWorks:MovieClip;
      
      private var saldoContainer:MovieClip;
      
      private var textCash:UIAutoTextField;
      
      private var addCashButton:UIButton;
      
      private var _game:TuxWarsGame;
      
      public function SlotMachineScreen(game:TuxWarsGame)
      {
         var i:int = 0;
         var i2:int = 0;
         var i3:int = 0;
         amountOfFriendsToDisplay = [];
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/slot_machine.swf","slot_machine_popup"));
         _game = game;
         var _loc5_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriendsToDisplay.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("TopLeftToBottomRightActiveFriends").value);
         var _loc6_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriendsToDisplay.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("TopRowActiveFriends").value);
         var _loc7_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriendsToDisplay.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("CentralRowActiveFriends").value);
         var _loc8_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriendsToDisplay.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("BottomRowActiveFriends").value);
         var _loc9_:SlotMachineConfReference = SlotMachineConfReference;
         amountOfFriendsToDisplay.push(tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("BottomLeftToTopRightActiveFriends").value);
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         containerButtons = (this._design as MovieClip).getChildByName("Container_Buttons") as MovieClip;
         buttonCashSpinContainer = (containerButtons as MovieClip).getChildByName("Button_Spin_Cash") as MovieClip;
         saldoContainer = (this._design as MovieClip).getChildByName("Saldo_Cash") as MovieClip;
         buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeScreen);
         buttonSpin = TuxUiUtils.createButton(UIButton,containerButtons,"Button_Spin",Spin,"SPIN");
         buttonCashSpin = TuxUiUtils.createButton(SecondTextFieldButton,containerButtons,"Button_Spin_Cash",CashSpin,"SPIN");
         buttonHelp = TuxUiUtils.createButton(UIButton,this._design,"Button_Help",Help);
         buttonAddFriends = TuxUiUtils.createButton(UIButton,this._design,"Button_Add_Friends",AddFriends,"ADD_FRIENDS");
         textFriends = MovieClip(this._design).getChildByName("Text_Friends") as TextField;
         freeSpins = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_Free_Spins") as TextField,ProjectManager.getText("FREE_SPINS"));
         textFriends.text = ProjectManager.getText("SLOTMACHINE_FRIENDS");
         textFriends.selectable = false;
         saldoContainer = (this._design as MovieClip).getChildByName("Saldo_Cash") as MovieClip;
         addCashButton = TuxUiUtils.createButton(UIButton,saldoContainer,"Button_Add_Cash",addCash,"BUTTON_ADD_PREMIUM");
         backGround = (this._design as MovieClip).getChildByName("Background") as MovieClip;
         backGround.gotoAndStop("Default");
         fireWorks = DCResourceManager.instance.getFromSWF("flash/ui/slot_machine.swf","fireworks");
         fireWorks.stop();
         fireWorks.visible = false;
         getDesignMovieClip().addChild(fireWorks);
         for(i = 0; i <= 2; )
         {
            slotReels.push(new SlotMachineReel((this._design as MovieClip).getChildByName("Drums") as MovieClip,i));
            i++;
         }
         for(i2 = 5; i2 > 0; )
         {
            slotLines.push(new SlotMachineLine((this._design as MovieClip).getChildByName("Line_0" + i2) as MovieClip,i2,amountOfFriendsToDisplay[i2 - 1]));
            i2--;
         }
         for(i3 = 1; i3 <= 9; )
         {
            jackpotStars.push((this._design as MovieClip).getChildByName("Three_In_A_Row_Slot_0" + i3) as MovieClip);
            jackpotStars[i3 - 1].visible = false;
            i3++;
         }
         _display = new SlotMachineText((this._design as MovieClip).getChildByName("Display") as MovieClip);
         spins = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_Spins") as TextField,"" + spinsLeft);
         var _loc10_:SlotMachineConfReference = SlotMachineConfReference;
         buttonCashSpin.setTextSecond("" + tuxwars.home.ui.logic.slotmachine.SlotMachineConfReference.getRow().findField("PlayPriceInCash").value,"Text_Price");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         setSpinsLeft();
         spinButtonEnable();
         textCash = TuxUiUtils.createAutoTextFieldWithText((saldoContainer as MovieClip).getChildByName("Text_Cash") as TextField,"" + slotMachineLogic.getPlayerCash());
         checkNoSpins();
      }
      
      public function setSpinsLeft() : void
      {
         spinsLeft = slotMachineLogic.returnMaxDailySpins() - _game.player.slotMachineSpinsUsed;
         if(spinsLeft >= 0)
         {
            spins.setText("" + spinsLeft);
         }
         else
         {
            spins.setText("0");
         }
      }
      
      public function playBackGroundRotationAnim() : void
      {
         var _loc2_:int = DCUtils.indexOfLabel(backGround,"Win");
         backGround.addFrameScript(_loc2_,stopBackGroundAnim);
         backGround.gotoAndPlay("Rotation");
         var spinlightSound:SoundReference = Sounds.getSoundReference("SlotMachineSpinLight");
         if(spinlightSound)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",spinlightSound.getMusicID(),spinlightSound.getStart(),spinlightSound.getType(),"PlaySound"));
         }
      }
      
      public function stopBackGroundAnim() : void
      {
         var _loc1_:int = DCUtils.indexOfLabel(backGround,"Stop");
         backGround.addFrameScript(_loc1_,null);
         backGround.gotoAndStop("Default");
      }
      
      public function stopBackGroundAnimToWin() : void
      {
         var _loc1_:int = DCUtils.indexOfLabel(backGround,"Stop");
         backGround.addFrameScript(_loc1_,null);
         backGround.gotoAndStop("Win");
      }
      
      public function setAward(value:SlotWinReference, type:String, itemIcon:ItemData, itemValue:int) : void
      {
         display.gotoWin(value,type,itemIcon,itemValue,_game);
      }
      
      public function playBackGroundWinAnim() : void
      {
         var index:int = DCUtils.indexOfLabel(backGround,"Win");
         backGround.addFrameScript(index,null);
         index = DCUtils.indexOfLabel(backGround,"Stop");
         backGround.addFrameScript(index,stopBackGroundAnimToWin);
         backGround.gotoAndPlay("Win");
      }
      
      public function playStartSound() : void
      {
         var sound:SoundReference = Sounds.getSoundReference("SlotMachineWin");
         if(sound)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
         }
      }
      
      public function getReels() : Vector.<SlotMachineReel>
      {
         return slotReels;
      }
      
      public function setLineText() : void
      {
         var i:int = 0;
         for(i = 0; i < 5; )
         {
            slotLines[i].setText(amountOfFriendsToDisplay[i]);
            i++;
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         var index:int = DCUtils.indexOfLabel(backGround,"Stop");
         backGround.addFrameScript(index,null);
         index = DCUtils.indexOfLabel(backGround,"Win");
         backGround.addFrameScript(index,null);
         super.dispose();
         buttonClose.dispose();
         buttonClose = null;
         buttonSpin.dispose();
         buttonSpin = null;
         buttonHelp.dispose();
         buttonHelp = null;
         buttonAddFriends.dispose();
         buttonAddFriends = null;
         _display.dispose();
         _display = null;
         spins = null;
         for each(var reel in slotReels)
         {
            reel.dispose();
         }
         slotReels.splice(0,slotReels.length);
         for each(var line in slotLines)
         {
            line.dispose();
         }
         slotLines.splice(0,slotLines.length);
         backGround = null;
      }
      
      private function get slotMachineLogic() : SlotMachineLogic
      {
         return logic;
      }
      
      public function setLineStateDefault(amountFriends:int) : void
      {
         var i:int = 0;
         for(i = 0; i <= amountFriends; )
         {
            slotLines[DISPLAY_SEQUENCE[i]].setDefaultState();
            i++;
         }
      }
      
      public function winLine(line:int) : void
      {
         slotLines[LINE_SEQUENCE[line]].setActiveState();
      }
      
      public function flashLine(line:int) : void
      {
         slotLines[LINE_SEQUENCE[line]].setWinState();
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function closeScreen(event:MouseEvent) : void
      {
         slotMachineLogic.giveAllRewards();
         super.close();
      }
      
      public function enableAllButtons() : void
      {
         buttonAddFriends.setEnabled(true);
         addCashButton.setEnabled(true);
         buttonHelp.setEnabled(true);
         buttonSpin.setEnabled(true);
         if(spinsLeft > 0)
         {
            buttonSpin.setVisible(true);
            buttonCashSpin.setVisible(false);
            buttonSpin.setEnabled(true);
         }
         else
         {
            buttonSpin.setVisible(false);
            buttonCashSpin.setVisible(true);
            buttonCashSpin.setEnabled(true);
         }
      }
      
      public function disableAllButtons() : void
      {
         buttonAddFriends.setEnabled(false);
         addCashButton.setEnabled(false);
         buttonHelp.setEnabled(false);
         if(spinsLeft > 0)
         {
            buttonSpin.setVisible(true);
            buttonCashSpin.setVisible(false);
            buttonSpin.setEnabled(false);
         }
         else
         {
            buttonSpin.setVisible(false);
            buttonCashSpin.setVisible(true);
            buttonCashSpin.setEnabled(false);
         }
      }
      
      public function spinButtonDisable() : void
      {
         buttonSpin.setEnabled(false);
      }
      
      public function spinButtonEnable() : void
      {
         buttonSpin.setEnabled(spinsLeft > 0);
      }
      
      public function checkNoSpins() : void
      {
         if(spinsLeft > 0)
         {
            buttonSpin.setVisible(true);
            buttonCashSpin.setVisible(false);
         }
         else
         {
            buttonSpin.setVisible(false);
            buttonCashSpin.setVisible(true);
            if(slotMachineLogic.checkOutOfCash())
            {
               display.gotoNoSpins();
            }
         }
      }
      
      public function displayPressSpin() : void
      {
         display.gotoDefault();
      }
      
      private function Spin(event:MouseEvent) : void
      {
         _game.spinPressed = true;
         slotMachineLogic.giveAllRewards();
         startSpin();
      }
      
      private function CashSpin(event:MouseEvent) : void
      {
         if(slotMachineLogic.cashSpin())
         {
            slotMachineLogic.giveAllRewards();
            startSpin();
         }
         else
         {
            popUpOutOfCash();
         }
      }
      
      private function startSpin() : void
      {
         CRMService.sendEvent("SlotMachine","Play_SlotMachine","Clicked","Pull_Lever");
         if(spinsLeft > 0)
         {
            spinsLeft--;
            spins.setText("" + spinsLeft);
         }
         textCash.setText("" + slotMachineLogic.getPlayerCash());
         buttonSpin.setEnabled(false);
         disableAllButtons();
         stopJackpotStars();
         display.gotoRotation();
         slotMachineLogic.start();
         setLineStateDefault(slotMachineLogic.getAmountFriends());
         var spinSound:SoundReference = Sounds.getSoundReference("SlotMachineSpin");
         if(spinSound)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",spinSound.getMusicID(),spinSound.getStart(),spinSound.getType(),"PlaySound"));
         }
         var startSound:SoundReference = Sounds.getSoundReference("SlotMachineStart");
         if(startSound)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",startSound.getMusicID(),startSound.getStart(),startSound.getType(),"PlaySound"));
         }
      }
      
      private function AddFriends(event:MouseEvent) : void
      {
         slotMachineLogic.giveAllRewards();
         _game.homeState.changeState(new NeighborState(_game));
      }
      
      private function addCash(event:MouseEvent) : void
      {
         MessageCenter.addListener("showMoneyState",openMoneyState);
         slotMachineLogic.giveAllRewards();
         CRMService.sendEvent("Game","Menu","Clicked","Add_Cash","SlotMachine");
         JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
      }
      
      private function openMoneyState(msg:Message) : void
      {
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         var _loc2_:* = JSON.parse(msg.data);
         if(_loc2_ != null)
         {
            if(_loc2_.type == "Cash")
            {
               _game.homeState.changeState(new MoneyState(_game,"popup_get_cash_new"));
            }
            else
            {
               LogUtils.log("sendMessage: No eventListener for type: " + _loc2_.type + " in SLOTMACHINE",null,2,"Messages",false,false,false);
            }
         }
      }
      
      private function popUpOutOfCash() : void
      {
         slotMachineLogic.giveAllRewards();
         var _loc1_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(_game,"Cash"),_game.currentState);
      }
      
      public function startJackpotStar(value:int) : void
      {
         jackpotStars[value - 1].visible = true;
         fireWorks.visible = true;
         fireWorks.play();
      }
      
      public function stopJackpotStars() : void
      {
         var i3:int = 0;
         for(i3 = 1; i3 <= 9; )
         {
            jackpotStars[i3 - 1].visible = false;
            i3++;
         }
         fireWorks.visible = false;
         fireWorks.stop();
      }
      
      private function Help(event:MouseEvent) : void
      {
         slotMachineLogic.giveAllRewards();
         var state:SlotMachineUISubState = slotMachineLogic.state as SlotMachineUISubState;
         var _loc3_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new SlotmachinePrizeSubState(_game),state);
      }
      
      public function get display() : SlotMachineText
      {
         return _display;
      }
   }
}
