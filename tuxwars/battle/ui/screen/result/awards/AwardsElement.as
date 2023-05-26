package tuxwars.battle.ui.screen.result.awards
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.PlayerResult;
   import tuxwars.battle.rewards.LootItem;
   import tuxwars.battle.ui.screen.result.awards.container.ItemContainers;
   import tuxwars.data.IngameBetData;
   import tuxwars.data.VIPData;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.states.vip.VIPState;
   import tuxwars.items.data.BetData;
   import tuxwars.items.data.CashData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function AwardsElement(design:MovieClip, game:TuxWarsGame)
      {
         super();
         this.game = game;
         TuxUiUtils.createAutoTextField(design.Text_Coins_and_XP,"RESULTS_COINS_AND_EXP");
         TuxUiUtils.createAutoTextField(design.Text_Membership,"RESULTS_MEMBERSHIP_BONUS");
         TuxUiUtils.createAutoTextField(design.Text_Total,"TOTAL_TEXT");
         positionBonusField = TuxUiUtils.createAutoTextFieldWithText(design.Text_Place,"");
         var _loc3_:MovieClip = design.Container_Award;
         coinsAwardField = TuxUiUtils.createAutoTextFieldWithText(_loc3_.Text_Coins_Number,"");
         expAwardField = TuxUiUtils.createAutoTextFieldWithText(_loc3_.Text_Exp_Number,"");
         var _loc5_:MovieClip = design.Container_Award_Place;
         coinsAwardBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc5_.Text_Coins_Number,"");
         expAwardBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc5_.Text_Exp_Number,"");
         var _loc6_:MovieClip = design.Container_Award_Total;
         coinsAwardTotalField = TuxUiUtils.createAutoTextFieldWithText(_loc6_.Text_Coins_Number,"");
         expAwardTotalField = TuxUiUtils.createAutoTextFieldWithText(_loc6_.Text_Exp_Number,"");
         betContainer = design.Bet;
         betContainerNoBet = betContainer.Bet_Nobet;
         betContainerWin = betContainer.Bet_Win;
         betContainerLose = betContainer.Bet_Lose;
         betContainerLose.visible = false;
         betContainerWin.visible = false;
         betContainerNoBet.visible = false;
         awardBetContainerWinCash = betContainerWin.Container_Award_Bet_Cash;
         awardBetContainerWinCoin = betContainerWin.Container_Award_Bet_Coins;
         awardBetContainerLoseCash = betContainerLose.Container_Award_Bet_Cash;
         awardBetContainerLoseCoin = betContainerLose.Container_Award_Bet_Coins;
         betBonusWinText = TuxUiUtils.createAutoTextFieldWithText((betContainerWin as MovieClip).getChildByName("Text") as TextField,ProjectManager.getText("BETWON"));
         betBonusLoseText = TuxUiUtils.createAutoTextFieldWithText((betContainerLose as MovieClip).getChildByName("Text") as TextField,ProjectManager.getText("BETLOST"));
         betBonusNoBetText = TuxUiUtils.createAutoTextFieldWithText((betContainerNoBet as MovieClip).getChildByName("Text") as TextField,ProjectManager.getText("NOBET"));
         bettingText = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Betting") as TextField,ProjectManager.getText("BETTING_TEXT"));
         rewardsText = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Rewards") as TextField,ProjectManager.getText("REWARDS_TEXT"));
         cashBetBonusWinField = TuxUiUtils.createAutoTextFieldWithText(awardBetContainerWinCash.Text_Cash_Number,"");
         coinBetBonusWinField = TuxUiUtils.createAutoTextFieldWithText(awardBetContainerWinCoin.Text_Coins_Number,"");
         cashBetBonusLoseField = TuxUiUtils.createAutoTextFieldWithText(awardBetContainerLoseCash.Text_Cash_Number,"");
         coinBetBonusLoseField = TuxUiUtils.createAutoTextFieldWithText(awardBetContainerLoseCoin.Text_Coins_Number,"");
         var _loc4_:MovieClip = design.Container_Bonus;
         membershipContainer = _loc4_.Selected;
         noMembershipContainer = _loc4_.Default;
         membershipContainer.visible = false;
         noMembershipContainer.visible = false;
         itemContainer = new ItemContainers(design.Container_Items,game);
      }
      
      public function init(results:BattleResults) : void
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc11_:* = null;
         coinsAwardField.setText(results.coinsGained.toString());
         expAwardField.setText(results.expGained.toString());
         positionBonusField.setText(ProjectManager.getText("RESULTS_POSITION_BONUS_" + results.getPosition(game.player.id)));
         if(BattleManager.isPracticeMode() || BattleManager.isZeroPointGame())
         {
            coinsAwardBonusField.setText("0");
            expAwardBonusField.setText("0");
            coinsAwardTotalField.setText("0");
            expAwardTotalField.setText("0");
         }
         else
         {
            coinsAwardBonusField.setText(results.getCoinsPositionBonus(game.player.id).toString());
            expAwardBonusField.setText(results.getExpPositionBonus(game.player.id).toString());
         }
         var _loc12_:Tutorial = Tutorial;
         LogUtils.log("Setting up awards, vip: " + BattleManager.isVIP() + " tutorial: " + tuxwars.tutorial.Tutorial._tutorial,this,1,"Game",false);
         addButton = TuxUiUtils.createButton(UIButton,noMembershipContainer,"Button_Get",getButtonCallback,"RESULTS_GET_MEMBERSHIP_BUTTON");
         if(BattleManager.isVIP() && !tuxwars.tutorial.Tutorial._tutorial)
         {
            _loc6_ = ((results.coinsGained + results.getCoinsPositionBonus(game.player.id)) * VIPData.getIngameMoneyMultiplier() - results.coinsGained - results.getCoinsPositionBonus(game.player.id)).toString();
            _loc3_ = ((results.expGained + results.getExpPositionBonus(game.player.id)) * VIPData.getExpMultiplier() - results.expGained - results.getExpPositionBonus(game.player.id)).toString();
            setUpMembershipAwards(membershipContainer,_loc6_,_loc3_);
            addButton.setVisible(false);
         }
         else
         {
            _loc7_ = ((results.coinsGained + results.getCoinsPositionBonus(game.player.id)) * VIPData.getIngameMoneyMultiplier() - results.coinsGained - results.getCoinsPositionBonus(game.player.id)).toString();
            _loc4_ = ((results.expGained + results.getExpPositionBonus(game.player.id)) * VIPData.getExpMultiplier() - results.expGained - results.getExpPositionBonus(game.player.id)).toString();
            setUpMembershipAwards(noMembershipContainer,_loc7_,_loc4_);
            var _loc14_:Tutorial = Tutorial;
            addButton.setVisible(!tuxwars.tutorial.Tutorial._tutorial);
            var _loc15_:Tutorial = Tutorial;
            addButton.setEnabled(!tuxwars.tutorial.Tutorial._tutorial);
         }
         var _loc5_:Vector.<ItemData> = new Vector.<ItemData>();
         if(results.cashGained > 0)
         {
            _loc2_ = new CashData();
            _loc2_.setAmount(results.cashGained);
            _loc5_.push(_loc2_);
         }
         if(!BattleManager.isPracticeMode() && !BattleManager.isZeroPointGame())
         {
            resultCoins = results.coinsGained;
            resultExp = results.expGained;
            positionCoins = results.getCoinsPositionBonus(game.player.id);
            positionExp = results.getExpPositionBonus(game.player.id);
            if(BattleManager.isVIP() && !tuxwars.tutorial.Tutorial._tutorial)
            {
               vipCoins = (results.coinsGained + results.getCoinsPositionBonus(game.player.id)) * VIPData.getIngameMoneyMultiplier() - results.coinsGained - results.getCoinsPositionBonus(game.player.id);
               vipExp = (results.expGained + results.getExpPositionBonus(game.player.id)) * VIPData.getExpMultiplier() - results.expGained - results.getExpPositionBonus(game.player.id);
            }
            else
            {
               vipCoins = 0;
               vipExp = 0;
            }
         }
         else
         {
            resultCoins = 0;
            resultExp = 0;
            positionCoins = 0;
            positionExp = 0;
            vipCoins = 0;
            vipExp = 0;
         }
         coinsAwardTotalField.setText("" + (positionCoins + resultCoins + vipCoins));
         expAwardTotalField.setText("" + (positionExp + resultExp + vipExp));
         for each(var lootItem in results.itemsLooted)
         {
            _loc9_ = ItemManager.getItemData(lootItem.id);
            if(_loc9_)
            {
               _loc5_.push(_loc9_);
            }
         }
         _loc5_.sort(ItemManager.sortByItemTypeAndPriority);
         itemContainer.init(_loc5_);
         cashBetBonusLoseField.setText("0");
         coinBetBonusLoseField.setText("0");
         cashBetBonusWinField.setText("0");
         coinBetBonusWinField.setText("0");
         if(BattleManager.isPracticeMode() || tuxwars.battle.BattleManager._customGameName != null || BattleManager.isZeroPointGame())
         {
            betContainerNoBet.visible = true;
            betContainerWin.visible = false;
            betContainerLose.visible = false;
         }
         else
         {
            for each(var playerResult in results.playerResults)
            {
               if(playerResult.player.isMe())
               {
                  _loc11_ = playerResult.player.betData;
                  if(_loc11_)
                  {
                     if(results.getPosition(game.player.id) == 1)
                     {
                        if(_loc11_.valuePremium > 0)
                        {
                           betContainerWin.visible = true;
                           cashBetBonusWinField.setText("" + IngameBetData.getPayout());
                           awardBetContainerWinCash.visible = true;
                           awardBetContainerWinCoin.visible = false;
                           break;
                        }
                        if(_loc11_.valueIngame > 0)
                        {
                           betContainerWin.visible = true;
                           coinBetBonusWinField.setText("" + IngameBetData.getPayout());
                           awardBetContainerWinCash.visible = false;
                           awardBetContainerWinCoin.visible = true;
                           break;
                        }
                        betContainerNoBet.visible = true;
                        break;
                     }
                     if(_loc11_.valuePremium > 0 && IngameBetData.getBetAmount() > 0)
                     {
                        betContainerLose.visible = true;
                        cashBetBonusLoseField.setText("-" + IngameBetData.getBetAmount());
                        awardBetContainerLoseCash.visible = true;
                        awardBetContainerLoseCoin.visible = false;
                        break;
                     }
                     if(_loc11_.valueIngame > 0 && IngameBetData.getBetAmount() > 0)
                     {
                        betContainerLose.visible = true;
                        coinBetBonusLoseField.setText("-" + IngameBetData.getBetAmount());
                        awardBetContainerLoseCash.visible = false;
                        awardBetContainerLoseCoin.visible = true;
                        break;
                     }
                     betContainerNoBet.visible = true;
                     break;
                  }
                  betContainerNoBet.visible = true;
                  break;
               }
            }
         }
      }
      
      private function setUpMembershipAwards(container:MovieClip, coins:String, exp:String) : void
      {
         var _loc4_:MovieClip = container.Container_Award;
         if(BattleManager.isPracticeMode() || BattleManager.isZeroPointGame())
         {
            coinsBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Coins_Number,"0");
            expBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Exp_Number,"0");
         }
         else
         {
            coinsBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Coins_Number,coins);
            expBonusField = TuxUiUtils.createAutoTextFieldWithText(_loc4_.Text_Exp_Number,exp);
         }
         container.visible = true;
      }
      
      public function dispose() : void
      {
         addButton.dispose();
         addButton = null;
         coinsAwardField = null;
         expAwardField = null;
         coinsBonusField = null;
         expBonusField = null;
         game = null;
      }
      
      private function getButtonCallback(event:MouseEvent) : void
      {
         var _loc2_:TuxWarsGame = game;
         _loc2_.changeState(new HomeState(_loc2_),true);
         _loc2_.homeState.changeState(new VIPState(_loc2_));
      }
      
      public function enableButtons(value:Boolean) : void
      {
         addButton.setEnabled(value);
      }
   }
}
