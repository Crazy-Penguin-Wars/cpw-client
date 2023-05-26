package tuxwars.home.ui.screen.matchloading
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.effects.BuyingAnimation;
   import com.dchoc.ui.groups.UIRadialGroup;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.ui.logic.bets.BetManager;
   import tuxwars.data.RematchData;
   import tuxwars.data.RematchDataPlayer;
   import tuxwars.home.ui.logic.matchloading.MatchLoadingLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.home.ui.screen.home.MoneyResourceElementScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.BetData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.utils.TuxUiUtils;
   
   public class MatchLoadingScreen extends TuxUIScreen
   {
      
      private static const BET_MAX_AMOUNT:int = 3;
      
      private static const SLOT_OPTION:String = "Slot_Option_0";
      
      private static const SLOT_OPTION_EXTEND_CASH:String = "_Cash";
      
      private static const BETTING_SLOT:String = "Slot_0";
      
      private static const CLOSE_BUTTON:String = "Button_Close";
      
      private static const REMATCH_SLOT_AMOUNT:int = 4;
       
      
      private const headerText:UIAutoTextField = new UIAutoTextField();
      
      private const betTextTitle:UIAutoTextField = new UIAutoTextField();
      
      private const betTextDescription:UIAutoTextField = new UIAutoTextField();
      
      private const betShopDescription:UIAutoTextField = new UIAutoTextField();
      
      private const betCountdown:UIAutoTextField = new UIAutoTextField();
      
      private const messageText:UIAutoTextField = new UIAutoTextField();
      
      private var _closeButton:UIButton;
      
      private var betSlotData:Vector.<BetData>;
      
      private var betShopSlots:Vector.<SlotElement>;
      
      private var radialGroup:UIRadialGroup;
      
      private var rematchSlots:Vector.<RematchSlot>;
      
      private var rematchDesign:MovieClip;
      
      private var _moneyScreen:MoneyResourceElementScreen;
      
      private var bettingAvailable:Boolean;
      
      public function MatchLoadingScreen(game:TuxWarsGame)
      {
         var design:* = null;
         var _loc2_:Boolean = RematchData.isRematchSet();
         var _loc4_:BattleManager = BattleManager;
         bettingAvailable = tuxwars.battle.BattleManager._customGameName == null && !BattleManager.isPracticeMode() && !BattleManager.isPracticeModeButNotTutorial() && !RematchData.isRematchSet();
         if(_loc2_)
         {
            if(bettingAvailable)
            {
               design = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_loading_betting_rematch");
            }
            else
            {
               design = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_loading_rematch");
            }
         }
         else if(bettingAvailable)
         {
            design = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_loading_betting");
         }
         else
         {
            design = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_loading");
         }
         super(game,design);
         _closeButton = TuxUiUtils.createButton(UIButton,design,"Button_Close",closeCallback);
         headerText.setTextField(design.Text_Header);
         if(_loc2_)
         {
            rematchDesign = design.getChildByName("Rematch_Slots") as MovieClip;
            messageText.setTextField(rematchDesign.Text);
            initRematchSlots();
         }
         else
         {
            messageText.setTextField(design.Text_Message);
         }
         if(bettingAvailable)
         {
            betTextTitle.setTextField(design.Text);
            betTextDescription.setTextField(design.Text_Description_Betting);
            betShopDescription.setTextField(design.Text_Description_Winners);
            betTextTitle.setText(ProjectManager.getText("MATCH_LOADING_BET_TITLE"));
            betTextDescription.setText(ProjectManager.getText("MATCH_LOADING_BET_DESCRIPTION"));
            betShopDescription.setText(ProjectManager.getText("MATCH_LOADING_BET_SHOP_DESCRIPTION"));
            betCountdown.setTextField(design.Text_Countdown);
            betCountdown.setText("");
         }
         headerText.setText(ProjectManager.getText("MATCH_LOADING_HEADER"));
         messageText.setText("");
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         if(bettingAvailable)
         {
            initBets();
            initShop();
            _moneyScreen = new MoneyResourceElementScreen(design,game);
         }
      }
      
      override public function set logic(logic:*) : void
      {
         super.logic = logic;
         if(showBettingScreen())
         {
            _moneyScreen.logic = loadingLogic.moneyLogic;
         }
      }
      
      private function initBets() : void
      {
         var i:int = 0;
         var mcName:* = null;
         var slotButtonPremium:* = null;
         var _loc1_:int = 0;
         var c:* = null;
         var slotButton:* = null;
         var _loc2_:int = 0;
         var cash:* = null;
         var slotButtonNoBet:* = null;
         radialGroup = new UIRadialGroup();
         betSlotData = BetManager.getBets();
         i = 0;
         while(i < betSlotData.length && i < 3)
         {
            mcName = "Slot_Option_0" + (i + 1);
            if((betSlotData[i] as BetData).valuePremium > 0)
            {
               slotButtonPremium = TuxUiUtils.createButton(UIToggleButton,this._design,mcName + "_Cash",selectBet);
               _loc1_ = (betSlotData[i] as BetData).valuePremium;
               slotButtonPremium.setText("" + _loc1_);
               slotButtonPremium.setEnabled(_loc1_ <= _game.player.premiumMoney);
               radialGroup.add(slotButtonPremium);
               c = getDesignMovieClip().getChildByName(mcName) as MovieClip;
               c.visible = false;
            }
            else if((betSlotData[i] as BetData).valueIngame > 0)
            {
               slotButton = TuxUiUtils.createButton(UIToggleButton,this._design,mcName,selectBet);
               _loc2_ = (betSlotData[i] as BetData).valueIngame;
               slotButton.setText("" + _loc2_);
               slotButton.setEnabled(_loc2_ <= _game.player.ingameMoney);
               radialGroup.add(slotButton);
               cash = getDesignMovieClip().getChildByName(mcName + "_Cash") as MovieClip;
               cash.visible = false;
            }
            else
            {
               slotButtonNoBet = TuxUiUtils.createButton(UIToggleButton,this._design,mcName,selectBet);
               slotButtonNoBet.setText(ProjectManager.getText("MATCH_LOADING_NO_BET"));
               radialGroup.add(slotButtonNoBet);
            }
            i++;
         }
         radialGroup.setSelectedIndex(0);
      }
      
      public function animate(cash:Boolean, amount:int) : void
      {
         var animateMC:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","text_bet");
         animateMC.Cash.visible = cash;
         animateMC.Coins.visible = !cash;
         animateMC.Text.text = "" + amount;
         BuyingAnimation.startAnimation(radialGroup.getSelectedButton().getDesignMovieClip(),0,animateMC);
      }
      
      private function initShop() : void
      {
         var i:int = 0;
         var j:int = 0;
         var shopRow:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         betShopSlots = new Vector.<SlotElement>();
         var slotCounter:int = 0;
         var slotMC:MovieClip = MovieClip(this._design.getChildByName("Slot_0" + (slotCounter + 1)));
         var randomArray:Array = new Array(3);
         randomArray[0] = MathUtils.randomNumber(1,28);
         randomArray[1] = MathUtils.randomNumber(1,28);
         randomArray[2] = MathUtils.randomNumber(1,28);
         for(i = 0; i < randomArray.length; )
         {
            for(j = 0; j < randomArray.length; )
            {
               if(randomArray[i] == randomArray[j])
               {
                  randomArray[j] = MathUtils.randomNumber(1,28);
               }
               j++;
            }
            i++;
         }
         while(slotMC)
         {
            var _loc9_:ProjectManager = ProjectManager;
            var _loc14_:* = "" + randomArray[slotCounter];
            var _loc10_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("BettingShopItems");
            if(!_loc10_._cache[_loc14_])
            {
               var _loc15_:Row = com.dchoc.utils.DCUtils.find(_loc10_.rows,"id",_loc14_);
               if(!_loc15_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc14_ + "\' was found in table: \'" + _loc10_.name + "\'",_loc10_,3);
               }
               _loc10_._cache[_loc14_] = _loc15_;
            }
            shopRow = _loc10_._cache[_loc14_];
            if(!shopRow)
            {
               LogUtils.log("No betting sale slot found with id: " + (slotCounter + 1) + " from " + "popup_loading_betting","MatchLoadingScreen",2,"Bet");
               break;
            }
            var _loc11_:* = shopRow;
            if(!_loc11_._cache["Item"])
            {
               _loc11_._cache["Item"] = com.dchoc.utils.DCUtils.find(_loc11_._fields,"name","Item");
            }
            var _loc12_:* = _loc11_._cache["Item"];
            _loc3_ = _loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value;
            _loc2_ = ItemManager.getItemData(_loc3_.id);
            betShopSlots.push(new SlotElement(slotMC,_game,new ShopItem(_loc2_),this,true));
            slotCounter++;
            slotMC = MovieClip(this._design.getChildByName("Slot_0" + (slotCounter + 1)));
         }
      }
      
      private function initRematchSlots() : void
      {
         var index:int = 0;
         var slotDesign:* = null;
         rematchSlots = new Vector.<RematchSlot>();
         (this._design.getChildByName("Loading_Animiation") as MovieClip).visible = false;
         var _loc3_:Vector.<RematchDataPlayer> = RematchData.getRematchPlayers();
         for(index = 0; index < 4; )
         {
            slotDesign = rematchDesign.getChildByName("Slot_0" + (index + 1)) as MovieClip;
            rematchSlots.push(new RematchSlot(slotDesign));
            if(_loc3_ && index < _loc3_.length)
            {
               rematchSlots[index].player = _loc3_[index];
            }
            index++;
         }
         RematchData.clearRematchPlayers();
      }
      
      public function updateRematchSlotStatus(playerID:String, status:int) : void
      {
         for each(var slot in rematchSlots)
         {
            if(slot.player && slot.player.id == playerID)
            {
               slot.status = status;
               break;
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_game.homeState.screenHandler.screen)
         {
            IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         }
         _closeButton.dispose();
         _closeButton = null;
         if(showBettingScreen())
         {
            radialGroup.dispose();
            radialGroup = null;
            for each(var slotElement in betShopSlots)
            {
               slotElement.dispose();
               slotElement = null;
            }
            _moneyScreen.dispose();
            _moneyScreen = null;
         }
         RematchData.setCustomGameName(null);
         super.dispose();
      }
      
      public function get closeButton() : UIButton
      {
         return _closeButton;
      }
      
      public function updateMessage(text:String) : void
      {
         messageText.setText(text);
      }
      
      private function closeCallback(event:MouseEvent) : void
      {
         loadingLogic.exit();
      }
      
      public function showBettingScreen() : Boolean
      {
         return bettingAvailable;
      }
      
      public function updateBettingCountdown(text:String) : void
      {
         betCountdown.setText(text);
      }
      
      public function getSelectedBetId(index:int = -1) : String
      {
         if(!radialGroup)
         {
            return null;
         }
         if(index == -1)
         {
            return betSlotData[radialGroup.getSelectedIndex()].id;
         }
         return betSlotData[index].id;
      }
      
      private function selectBet(event:MouseEvent) : void
      {
         loadingLogic.setBets(getSelectedBetId());
      }
      
      public function bettingSelectionCompleted(betId:String) : void
      {
         var i:int = 0;
         var selectedButton:* = null;
         var _loc2_:int = BetManager.getBetIndex(betId);
         if(radialGroup)
         {
            for(i = 0; i < radialGroup.getButtons().length; )
            {
               radialGroup.getButtons()[i].setEnabled(false);
               if(i == _loc2_)
               {
                  selectedButton = radialGroup.getButtons()[i];
                  selectedButton.setState("Selected");
               }
               i++;
            }
         }
      }
      
      private function get loadingLogic() : MatchLoadingLogic
      {
         return logic;
      }
      
      public function get moneyScreen() : MoneyResourceElementScreen
      {
         return _moneyScreen;
      }
   }
}
