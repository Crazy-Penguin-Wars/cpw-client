package tuxwars.battle.ui.screen.result.awards
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.ui.screen.result.awards.container.*;
   import tuxwars.data.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.states.vip.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.tutorial.*;
   import tuxwars.utils.*;
   
   public class AwardsElement
   {
      private static const BUTTON_LEFT:String = "Button_Scroll_Left";
      
      private static const BUTTON_RIGHT:String = "Button_Scroll_Right";
      
      private static const BUTTON_GET:String = "Button_Get";
      
      private static const POSITION_BONUS_TEXT:String = "RESULTS_POSITION_BONUS_";
      
      private var addButton:UIButton;
      
      private var coinsAwardField:UIAutoTextField;
      
      private var expAwardField:UIAutoTextField;
      
      private var coinsAwardBonusField:UIAutoTextField;
      
      private var expAwardBonusField:UIAutoTextField;
      
      private var totalTextField:UIAutoTextField;
      
      private var coinsAwardTotalField:UIAutoTextField;
      
      private var expAwardTotalField:UIAutoTextField;
      
      private var coinsBonusField:UIAutoTextField;
      
      private var expBonusField:UIAutoTextField;
      
      private var positionBonusField:UIAutoTextField;
      
      private var membershipContainer:MovieClip;
      
      private var noMembershipContainer:MovieClip;
      
      private var itemContainer:ItemContainers;
      
      private var betBonusNoBetText:UIAutoTextField;
      
      private var betBonusWinText:UIAutoTextField;
      
      private var betBonusLoseText:UIAutoTextField;
      
      private var bettingText:UIAutoTextField;
      
      private var rewardsText:UIAutoTextField;
      
      private var coinBetBonusWinField:UIAutoTextField;
      
      private var cashBetBonusWinField:UIAutoTextField;
      
      private var coinBetBonusLoseField:UIAutoTextField;
      
      private var cashBetBonusLoseField:UIAutoTextField;
      
      private var betContainer:MovieClip;
      
      private var betContainerNoBet:MovieClip;
      
      private var betContainerWin:MovieClip;
      
      private var betContainerLose:MovieClip;
      
      private var awardBetContainerWinCoin:MovieClip;
      
      private var awardBetContainerWinCash:MovieClip;
      
      private var awardBetContainerLoseCoin:MovieClip;
      
      private var awardBetContainerLoseCash:MovieClip;
      
      private var resultCoins:int;
      
      private var resultExp:int;
      
      private var positionCoins:int;
      
      private var positionExp:int;
      
      private var vipCoins:int;
      
      private var vipExp:int;
      
      private var game:TuxWarsGame;
      
      public function AwardsElement(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         this.game = param2;
         TuxUiUtils.createAutoTextField(param1.Text_Coins_and_XP,"RESULTS_COINS_AND_EXP");
         TuxUiUtils.createAutoTextField(param1.Text_Membership,"RESULTS_MEMBERSHIP_BONUS");
         TuxUiUtils.createAutoTextField(param1.Text_Total,"TOTAL_TEXT");
         this.positionBonusField = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Place,"");
         var _loc3_:MovieClip = param1.Container_Award;
         this.coinsAwardField = TuxUiUtils.createAutoTextFieldWithText(_loc3_.Text_Coins_Number,"");
         this.expAwardField = TuxUiUtils.createAutoTextFieldWithText(_loc3_.Text_Exp_Number,"");
         var _loc4_:MovieClip = param1.Container_Award_Place;
         this.coinsAwardBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Coins_Number,"");
         this.expAwardBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Exp_Number,"");
         var _loc5_:MovieClip = param1.Container_Award_Total;
         this.coinsAwardTotalField = TuxUiUtils.createAutoTextFieldWithText(_loc5_.Text_Coins_Number,"");
         this.expAwardTotalField = TuxUiUtils.createAutoTextFieldWithText(_loc5_.Text_Exp_Number,"");
         this.betContainer = param1.Bet;
         this.betContainerNoBet = this.betContainer.Bet_Nobet;
         this.betContainerWin = this.betContainer.Bet_Win;
         this.betContainerLose = this.betContainer.Bet_Lose;
         this.betContainerLose.visible = false;
         this.betContainerWin.visible = false;
         this.betContainerNoBet.visible = false;
         this.awardBetContainerWinCash = this.betContainerWin.Container_Award_Bet_Cash;
         this.awardBetContainerWinCoin = this.betContainerWin.Container_Award_Bet_Coins;
         this.awardBetContainerLoseCash = this.betContainerLose.Container_Award_Bet_Cash;
         this.awardBetContainerLoseCoin = this.betContainerLose.Container_Award_Bet_Coins;
         this.betBonusWinText = TuxUiUtils.createAutoTextFieldWithText((this.betContainerWin as MovieClip).getChildByName("Text") as TextField,ProjectManager.getText("BETWON"));
         this.betBonusLoseText = TuxUiUtils.createAutoTextFieldWithText((this.betContainerLose as MovieClip).getChildByName("Text") as TextField,ProjectManager.getText("BETLOST"));
         this.betBonusNoBetText = TuxUiUtils.createAutoTextFieldWithText((this.betContainerNoBet as MovieClip).getChildByName("Text") as TextField,ProjectManager.getText("NOBET"));
         this.bettingText = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Betting") as TextField,ProjectManager.getText("BETTING_TEXT"));
         this.rewardsText = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Rewards") as TextField,ProjectManager.getText("REWARDS_TEXT"));
         this.cashBetBonusWinField = TuxUiUtils.createAutoTextFieldWithText(this.awardBetContainerWinCash.Text_Cash_Number,"");
         this.coinBetBonusWinField = TuxUiUtils.createAutoTextFieldWithText(this.awardBetContainerWinCoin.Text_Coins_Number,"");
         this.cashBetBonusLoseField = TuxUiUtils.createAutoTextFieldWithText(this.awardBetContainerLoseCash.Text_Cash_Number,"");
         this.coinBetBonusLoseField = TuxUiUtils.createAutoTextFieldWithText(this.awardBetContainerLoseCoin.Text_Coins_Number,"");
         var _loc6_:MovieClip = param1.Container_Bonus;
         this.membershipContainer = _loc6_.Selected;
         this.noMembershipContainer = _loc6_.Default;
         this.membershipContainer.visible = false;
         this.noMembershipContainer.visible = false;
         this.itemContainer = new ItemContainers(param1.Container_Items,param2);
      }
      
      public function init(param1:BattleResults) : void
      {
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:CashData = null;
         var _loc7_:ItemData = null;
         var _loc8_:BetData = null;
         this.coinsAwardField.setText(param1.coinsGained.toString());
         this.expAwardField.setText(param1.expGained.toString());
         this.positionBonusField.setText(ProjectManager.getText("RESULTS_POSITION_BONUS_" + param1.getPosition(this.game.player.id)));
         if(Boolean(BattleManager.isPracticeMode()) || Boolean(BattleManager.isZeroPointGame()))
         {
            this.coinsAwardBonusField.setText("0");
            this.expAwardBonusField.setText("0");
            this.coinsAwardTotalField.setText("0");
            this.expAwardTotalField.setText("0");
         }
         else
         {
            this.coinsAwardBonusField.setText(param1.getCoinsPositionBonus(this.game.player.id).toString());
            this.expAwardBonusField.setText(param1.getExpPositionBonus(this.game.player.id).toString());
         }
         LogUtils.log("Setting up awards, vip: " + BattleManager.isVIP() + " tutorial: " + Tutorial._tutorial,this,1,"Game",false);
         this.addButton = TuxUiUtils.createButton(UIButton,this.noMembershipContainer,"Button_Get",this.getButtonCallback,"RESULTS_GET_MEMBERSHIP_BUTTON");
         if(Boolean(BattleManager.isVIP()) && !Tutorial._tutorial)
         {
            _loc2_ = int((param1.coinsGained + param1.getCoinsPositionBonus(this.game.player.id)) * VIPData.getIngameMoneyMultiplier() - param1.coinsGained - param1.getCoinsPositionBonus(this.game.player.id)).toString();
            _loc3_ = int((param1.expGained + param1.getExpPositionBonus(this.game.player.id)) * VIPData.getExpMultiplier() - param1.expGained - param1.getExpPositionBonus(this.game.player.id)).toString();
            this.setUpMembershipAwards(this.membershipContainer,_loc2_,_loc3_);
            this.addButton.setVisible(false);
         }
         else
         {
            _loc4_ = int((param1.coinsGained + param1.getCoinsPositionBonus(this.game.player.id)) * VIPData.getIngameMoneyMultiplier() - param1.coinsGained - param1.getCoinsPositionBonus(this.game.player.id)).toString();
            _loc5_ = int((param1.expGained + param1.getExpPositionBonus(this.game.player.id)) * VIPData.getExpMultiplier() - param1.expGained - param1.getExpPositionBonus(this.game.player.id)).toString();
            this.setUpMembershipAwards(this.noMembershipContainer,_loc4_,_loc5_);
            this.addButton.setVisible(!Tutorial._tutorial);
            this.addButton.setEnabled(!Tutorial._tutorial);
         }
         var _loc9_:Vector.<ItemData> = new Vector.<ItemData>();
         if(param1.cashGained > 0)
         {
            _loc6_ = new CashData();
            _loc6_.setAmount(param1.cashGained);
            _loc9_.push(_loc6_);
         }
         if(!BattleManager.isPracticeMode() && !BattleManager.isZeroPointGame())
         {
            this.resultCoins = param1.coinsGained;
            this.resultExp = param1.expGained;
            this.positionCoins = param1.getCoinsPositionBonus(this.game.player.id);
            this.positionExp = param1.getExpPositionBonus(this.game.player.id);
            if(Boolean(BattleManager.isVIP()) && !Tutorial._tutorial)
            {
               this.vipCoins = (param1.coinsGained + param1.getCoinsPositionBonus(this.game.player.id)) * VIPData.getIngameMoneyMultiplier() - param1.coinsGained - param1.getCoinsPositionBonus(this.game.player.id);
               this.vipExp = (param1.expGained + param1.getExpPositionBonus(this.game.player.id)) * VIPData.getExpMultiplier() - param1.expGained - param1.getExpPositionBonus(this.game.player.id);
            }
            else
            {
               this.vipCoins = 0;
               this.vipExp = 0;
            }
         }
         else
         {
            this.resultCoins = 0;
            this.resultExp = 0;
            this.positionCoins = 0;
            this.positionExp = 0;
            this.vipCoins = 0;
            this.vipExp = 0;
         }
         this.coinsAwardTotalField.setText("" + (this.positionCoins + this.resultCoins + this.vipCoins));
         this.expAwardTotalField.setText("" + (this.positionExp + this.resultExp + this.vipExp));
         for each(_loc10_ in param1.itemsLooted)
         {
            _loc7_ = ItemManager.getItemData(_loc10_.id);
            if(_loc7_)
            {
               _loc9_.push(_loc7_);
            }
         }
         _loc9_.sort(ItemManager.sortByItemTypeAndPriority);
         this.itemContainer.init(_loc9_);
         this.cashBetBonusLoseField.setText("0");
         this.coinBetBonusLoseField.setText("0");
         this.cashBetBonusWinField.setText("0");
         this.coinBetBonusWinField.setText("0");
         if(Boolean(BattleManager.isPracticeMode()) || BattleManager.customGameName != null || Boolean(BattleManager.isZeroPointGame()))
         {
            this.betContainerNoBet.visible = true;
            this.betContainerWin.visible = false;
            this.betContainerLose.visible = false;
         }
         else
         {
            for each(_loc11_ in param1.playerResults)
            {
               if(_loc11_.player.isMe())
               {
                  _loc8_ = _loc11_.player.betData;
                  if(_loc8_)
                  {
                     if(param1.getPosition(this.game.player.id) == 1)
                     {
                        if(_loc8_.valuePremium > 0)
                        {
                           this.betContainerWin.visible = true;
                           this.cashBetBonusWinField.setText("" + IngameBetData.getPayout());
                           this.awardBetContainerWinCash.visible = true;
                           this.awardBetContainerWinCoin.visible = false;
                        }
                        else if(_loc8_.valueIngame > 0)
                        {
                           this.betContainerWin.visible = true;
                           this.coinBetBonusWinField.setText("" + IngameBetData.getPayout());
                           this.awardBetContainerWinCash.visible = false;
                           this.awardBetContainerWinCoin.visible = true;
                        }
                        else
                        {
                           this.betContainerNoBet.visible = true;
                        }
                     }
                     else if(_loc8_.valuePremium > 0 && IngameBetData.getBetAmount() > 0)
                     {
                        this.betContainerLose.visible = true;
                        this.cashBetBonusLoseField.setText("-" + IngameBetData.getBetAmount());
                        this.awardBetContainerLoseCash.visible = true;
                        this.awardBetContainerLoseCoin.visible = false;
                     }
                     else if(_loc8_.valueIngame > 0 && IngameBetData.getBetAmount() > 0)
                     {
                        this.betContainerLose.visible = true;
                        this.coinBetBonusLoseField.setText("-" + IngameBetData.getBetAmount());
                        this.awardBetContainerLoseCash.visible = false;
                        this.awardBetContainerLoseCoin.visible = true;
                     }
                     else
                     {
                        this.betContainerNoBet.visible = true;
                     }
                  }
                  else
                  {
                     this.betContainerNoBet.visible = true;
                  }
                  break;
               }
            }
         }
      }
      
      private function setUpMembershipAwards(param1:MovieClip, param2:String, param3:String) : void
      {
         var _loc4_:MovieClip = param1.Container_Award;
         if(Boolean(BattleManager.isPracticeMode()) || Boolean(BattleManager.isZeroPointGame()))
         {
            this.coinsBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Coins_Number,"0");
            this.expBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Exp_Number,"0");
         }
         else
         {
            this.coinsBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Coins_Number,param2);
            this.expBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Exp_Number,param3);
         }
         param1.visible = true;
      }
      
      public function dispose() : void
      {
         this.addButton.dispose();
         this.addButton = null;
         this.coinsAwardField = null;
         this.expAwardField = null;
         this.coinsBonusField = null;
         this.expBonusField = null;
         this.game = null;
      }
      
      private function getButtonCallback(param1:MouseEvent) : void
      {
         var _loc2_:TuxWarsGame = this.game;
         _loc2_.changeState(new HomeState(_loc2_),true);
         _loc2_.homeState.changeState(new VIPState(_loc2_));
      }
      
      public function enableButtons(param1:Boolean) : void
      {
         this.addButton.setEnabled(param1);
      }
   }
}

