package tuxwars.home.ui.screen.matchloading
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.effects.*;
   import com.dchoc.ui.groups.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.ui.logic.bets.*;
   import tuxwars.data.*;
   import tuxwars.home.ui.logic.matchloading.MatchLoadingLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.items.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.ui.containers.slotitem.*;
   import tuxwars.utils.*;
   
   public class MatchLoadingScreen extends TuxUIScreen
   {
      private static const BET_MAX_AMOUNT:int = 3;
      
      private static const SLOT_OPTION:String = "Slot_Option_0";
      
      private static const SLOT_OPTION_EXTEND_CASH:String = "_Cash";
      
      private static const BETTING_SLOT:String = "Slot_0";
      
      private static const CLOSE_BUTTON:String = "Button_Close";
      
      private static const REMATCH_SLOT_AMOUNT:int = 4;
      
      private const headerText:UIAutoTextField;
      
      private const betTextTitle:UIAutoTextField;
      
      private const betTextDescription:UIAutoTextField;
      
      private const betShopDescription:UIAutoTextField;
      
      private const betCountdown:UIAutoTextField;
      
      private const messageText:UIAutoTextField;
      
      private var _closeButton:UIButton;
      
      private var betSlotData:Vector.<BetData>;
      
      private var betShopSlots:Vector.<SlotElement>;
      
      private var radialGroup:UIRadialGroup;
      
      private var rematchSlots:Vector.<RematchSlot>;
      
      private var rematchDesign:MovieClip;
      
      private var _moneyScreen:MoneyResourceElementScreen;
      
      private var bettingAvailable:Boolean;
      
      public function MatchLoadingScreen(param1:TuxWarsGame)
      {
         var _loc2_:MovieClip = null;
         this.headerText = new UIAutoTextField();
         this.betTextTitle = new UIAutoTextField();
         this.betTextDescription = new UIAutoTextField();
         this.betShopDescription = new UIAutoTextField();
         this.betCountdown = new UIAutoTextField();
         this.messageText = new UIAutoTextField();
         var _loc3_:Boolean = Boolean(RematchData.isRematchSet());
         this.bettingAvailable = BattleManager.customGameName == null && !BattleManager.isPracticeMode() && !BattleManager.isPracticeModeButNotTutorial() && !RematchData.isRematchSet();
         if(_loc3_)
         {
            if(this.bettingAvailable)
            {
               _loc2_ = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_loading_betting_rematch");
            }
            else
            {
               _loc2_ = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_loading_rematch");
            }
         }
         else if(this.bettingAvailable)
         {
            _loc2_ = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_loading_betting");
         }
         else
         {
            _loc2_ = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_loading");
         }
         super(param1,_loc2_);
         this._closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",this.closeCallback);
         this.headerText.setTextField(_loc2_.Text_Header);
         if(_loc3_)
         {
            this.rematchDesign = _loc2_.getChildByName("Rematch_Slots") as MovieClip;
            this.messageText.setTextField(this.rematchDesign.Text);
            this.initRematchSlots();
         }
         else
         {
            this.messageText.setTextField(_loc2_.Text_Message);
         }
         if(this.bettingAvailable)
         {
            this.betTextTitle.setTextField(_loc2_.Text);
            this.betTextDescription.setTextField(_loc2_.Text_Description_Betting);
            this.betShopDescription.setTextField(_loc2_.Text_Description_Winners);
            this.betTextTitle.setText(ProjectManager.getText("MATCH_LOADING_BET_TITLE"));
            this.betTextDescription.setText(ProjectManager.getText("MATCH_LOADING_BET_DESCRIPTION"));
            this.betShopDescription.setText(ProjectManager.getText("MATCH_LOADING_BET_SHOP_DESCRIPTION"));
            this.betCountdown.setTextField(_loc2_.Text_Countdown);
            this.betCountdown.setText("");
         }
         this.headerText.setText(ProjectManager.getText("MATCH_LOADING_HEADER"));
         this.messageText.setText("");
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         if(this.bettingAvailable)
         {
            this.initBets();
            this.initShop();
            this._moneyScreen = new MoneyResourceElementScreen(_loc2_,param1);
         }
      }
      
      override public function set logic(param1:*) : void
      {
         super.logic = param1;
         if(this.showBettingScreen())
         {
            this._moneyScreen.logic = this.loadingLogic.moneyLogic;
         }
      }
      
      private function initBets() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:UIToggleButton = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:UIToggleButton = null;
         var _loc7_:int = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:UIToggleButton = null;
         this.radialGroup = new UIRadialGroup();
         this.betSlotData = BetManager.getBets();
         _loc1_ = 0;
         while(_loc1_ < this.betSlotData.length && _loc1_ < 3)
         {
            _loc2_ = "Slot_Option_0" + (_loc1_ + 1);
            if((this.betSlotData[_loc1_] as BetData).valuePremium > 0)
            {
               _loc3_ = TuxUiUtils.createButton(UIToggleButton,this._design,_loc2_,this.selectBet);
               _loc4_ = int((this.betSlotData[_loc1_] as BetData).valuePremium);
               _loc3_.setText("" + _loc4_);
               _loc3_.setEnabled(_loc4_ <= _game.player.premiumMoney);
               this.radialGroup.add(_loc3_);
               _loc5_ = getDesignMovieClip().getChildByName(_loc2_ + "_Cash") as MovieClip;
               _loc5_.visible = false;
            }
            else if((this.betSlotData[_loc1_] as BetData).valueIngame > 0)
            {
               _loc6_ = TuxUiUtils.createButton(UIToggleButton,this._design,_loc2_,this.selectBet);
               _loc7_ = int((this.betSlotData[_loc1_] as BetData).valueIngame);
               _loc6_.setText("" + _loc7_);
               _loc6_.setEnabled(_loc7_ <= _game.player.ingameMoney);
               this.radialGroup.add(_loc6_);
               _loc8_ = getDesignMovieClip().getChildByName(_loc2_ + "_Cash") as MovieClip;
               _loc8_.visible = false;
            }
            else
            {
               _loc9_ = TuxUiUtils.createButton(UIToggleButton,this._design,_loc2_,this.selectBet);
               _loc9_.setText(ProjectManager.getText("MATCH_LOADING_NO_BET"));
               this.radialGroup.add(_loc9_);
            }
            _loc1_++;
         }
      }
      
      public function animate(param1:Boolean, param2:int) : void
      {
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","text_bet");
         _loc3_.Cash.visible = param1;
         _loc3_.Coins.visible = !param1;
         _loc3_.Text.text = "" + param2;
         BuyingAnimation.startAnimation(this.radialGroup.getSelectedButton().getDesignMovieClip(),0,_loc3_);
      }
      
      private function initShop() : void
      {
         var _loc9_:String = null;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:String = null;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:Row = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Row = null;
         var _loc4_:Object = null;
         var _loc5_:ItemData = null;
         this.betShopSlots = new Vector.<SlotElement>();
         var _loc6_:int = 0;
         var _loc7_:MovieClip = MovieClip(this._design.getChildByName("Slot_0" + (_loc6_ + 1)));
         var _loc8_:Array = new Array(3);
         _loc8_[0] = MathUtils.randomNumber(1,28);
         _loc8_[1] = MathUtils.randomNumber(1,28);
         _loc8_[2] = MathUtils.randomNumber(1,28);
         _loc1_ = 0;
         while(_loc1_ < _loc8_.length)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc8_.length)
            {
               if(_loc8_[_loc1_] == _loc8_[_loc2_])
               {
                  _loc8_[_loc2_] = MathUtils.randomNumber(1,28);
               }
               _loc2_++;
            }
            _loc1_++;
         }
         while(_loc7_)
         {
            _loc9_ = "BettingShopItems";
            _loc10_ = "" + _loc8_[_loc6_];
            _loc11_ = ProjectManager.findTable(_loc9_);
            if(!_loc11_.getCache[_loc10_])
            {
               _loc15_ = DCUtils.find(_loc11_.rows,"id",_loc10_);
               if(!_loc15_)
               {
                  LogUtils.log("No row with name: \'" + _loc10_ + "\' was found in table: \'" + _loc11_.name + "\'",_loc11_,3);
               }
               _loc11_.getCache[_loc10_] = _loc15_;
            }
            _loc3_ = _loc11_.getCache[_loc10_];
            if(!_loc3_)
            {
               LogUtils.log("No betting sale slot found with id: " + (_loc6_ + 1) + " from " + "popup_loading_betting","MatchLoadingScreen",2,"Bet");
               break;
            }
            _loc12_ = "Item";
            _loc13_ = _loc3_;
            if(!_loc13_.getCache[_loc12_])
            {
               _loc13_.getCache[_loc12_] = DCUtils.find(_loc13_.getFields(),"name",_loc12_);
            }
            _loc14_ = _loc13_.getCache[_loc12_];
            _loc4_ = _loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value;
            _loc5_ = ItemManager.getItemData(_loc4_.id);
            this.betShopSlots.push(new SlotElement(_loc7_,_game,new ShopItem(_loc5_),this,true));
            _loc6_++;
            _loc7_ = MovieClip(this._design.getChildByName("Slot_0" + (_loc6_ + 1)));
         }
      }
      
      private function initRematchSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.rematchSlots = new Vector.<RematchSlot>();
         (this._design.getChildByName("Loading_Animiation") as MovieClip).visible = false;
         var _loc3_:Vector.<RematchDataPlayer> = RematchData.getRematchPlayers();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.rematchDesign.getChildByName("Slot_0" + (_loc1_ + 1)) as MovieClip;
            this.rematchSlots.push(new RematchSlot(_loc2_));
            if(Boolean(_loc3_) && _loc1_ < _loc3_.length)
            {
               this.rematchSlots[_loc1_].player = _loc3_[_loc1_];
            }
            _loc1_++;
         }
         RematchData.clearRematchPlayers();
      }
      
      public function updateRematchSlotStatus(param1:String, param2:int) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in this.rematchSlots)
         {
            if(Boolean(_loc3_.player) && _loc3_.player.id == param1)
            {
               _loc3_.status = param2;
               break;
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         if(_game.homeState.screenHandler.screen)
         {
            IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         }
         this._closeButton.dispose();
         this._closeButton = null;
         if(this.showBettingScreen())
         {
            this.radialGroup.dispose();
            this.radialGroup = null;
            for each(_loc1_ in this.betShopSlots)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this._moneyScreen.dispose();
            this._moneyScreen = null;
         }
         RematchData.setCustomGameName(null);
         super.dispose();
      }
      
      public function get closeButton() : UIButton
      {
         return this._closeButton;
      }
      
      public function updateMessage(param1:String) : void
      {
         this.messageText.setText(param1);
      }
      
      private function closeCallback(param1:MouseEvent) : void
      {
         this.loadingLogic.exit();
      }
      
      public function showBettingScreen() : Boolean
      {
         return this.bettingAvailable;
      }
      
      public function updateBettingCountdown(param1:String) : void
      {
         this.betCountdown.setText(param1);
      }
      
      public function getSelectedBetId(param1:int = -1) : String
      {
         if(!this.radialGroup)
         {
            return null;
         }
         if(param1 == -1)
         {
            return this.betSlotData[this.radialGroup.getSelectedIndex()].id;
         }
         return this.betSlotData[param1].id;
      }
      
      private function selectBet(param1:MouseEvent) : void
      {
         this.loadingLogic.setBets(this.getSelectedBetId());
      }
      
      public function bettingSelectionCompleted(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:UIToggleButton = null;
         var _loc4_:int = int(BetManager.getBetIndex(param1));
         if(this.radialGroup)
         {
            _loc2_ = 0;
            while(_loc2_ < this.radialGroup.getButtons().length)
            {
               this.radialGroup.getButtons()[_loc2_].setEnabled(false);
               if(_loc2_ == _loc4_)
               {
                  _loc3_ = this.radialGroup.getButtons()[_loc2_];
                  _loc3_.setState("Selected");
               }
               _loc2_++;
            }
         }
      }
      
      private function get loadingLogic() : MatchLoadingLogic
      {
         return logic;
      }
      
      public function get moneyScreen() : MoneyResourceElementScreen
      {
         return this._moneyScreen;
      }
   }
}

