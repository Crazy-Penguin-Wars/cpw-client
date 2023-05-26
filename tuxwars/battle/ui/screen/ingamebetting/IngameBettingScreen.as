package tuxwars.battle.ui.screen.ingamebetting
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.messages.control.IngameBetMessage;
   import tuxwars.data.IngameBetData;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class IngameBettingScreen extends TuxUIElementScreen
   {
      
      private static const DEFAULT_MULTIPLIER:int = 2;
      
      private static const LAST_SECONDS_TO_DISABLE_BETTING:int = 60;
      
      private static const TEXT_PAYOUT:String = "Text_Payout";
      
      private static const TEXT_BET:String = "Text_Bet";
      
      private static const TEXT_COINS:String = "Text_Coins";
      
      private static const TEXT_CASH:String = "Text_Cash";
      
      private static const BUTTON_BET_CASH:String = "Button_Bet_Cash";
      
      private static const BUTTON_BET_COINS:String = "Button_Bet_Coins";
       
      
      private var saldoCoins:TextField;
      
      private var saldoCash:TextField;
      
      private var multiplierFX:MovieClip;
      
      private var multiplierActive:MovieClip;
      
      private var multiplierDefault:MovieClip;
      
      private var payoutFX:MovieClip;
      
      private var payoutCash:MovieClip;
      
      private var payoutCoins:MovieClip;
      
      private var buttonCash:UIButton;
      
      private var buttonCoins:UIButton;
      
      private var currentBetIsCash:Boolean;
      
      private var currentBet:int;
      
      private var currentMultiplier:int;
      
      private var screenIsInstalled:Boolean;
      
      public function IngameBettingScreen(design:MovieClip, game:TuxWarsGame)
      {
         super(design,game);
         screenIsInstalled = game && game.player && game.player.betData && (game.player.betData.valueIngame > 0 || game.player.betData.valuePremium > 0);
         if(!screenIsInstalled)
         {
            getDesignMovieClip().visible = false;
            return;
         }
         currentBetIsCash = game.player.betData.valuePremium > 0;
         currentMultiplier = 2;
         currentBet = currentBetIsCash ? game.player.betData.valuePremium : game.player.betData.valueIngame;
         MessageCenter.addListener("ingameBetPlaced",bettingCallback);
         MessageCenter.addListener("ingameBetMultiplierChanged",multiplierChangedCallback);
         var tf:TextField = getDesignMovieClip().getChildByName("Text_Payout") as TextField;
         tf.text = ProjectManager.getText("INGAME_BETTING_PAYOUT");
         tf = getDesignMovieClip().getChildByName("Text_Bet") as TextField;
         tf.text = ProjectManager.getText("INGAME_BETTING_BET");
         var mc:MovieClip = getDesignMovieClip().getChildByName("Saldo") as MovieClip;
         saldoCash = mc.getChildByName("Text_Cash") as TextField;
         saldoCoins = mc.getChildByName("Text_Coins") as TextField;
         updateSaldo(game.player.premiumMoney,game.player.ingameMoney);
         MessageCenter.addListener("IngameMoneyChanged",inGameMoneyChanged);
         MessageCenter.addListener("PremiumMoneyChanged",premiumMoneyChanged);
         mc = getDesignMovieClip().getChildByName("Multiplier") as MovieClip;
         multiplierFX = mc.getChildByName("Fx") as MovieClip;
         multiplierFX.addEventListener("enterFrame",playMultiplierEffect);
         multiplierActive = mc.getChildByName("Active") as MovieClip;
         multiplierDefault = mc.getChildByName("Default") as MovieClip;
         updateMultiplier(false,currentMultiplier,false);
         mc = getDesignMovieClip().getChildByName("Payout") as MovieClip;
         payoutFX = mc.getChildByName("Fx") as MovieClip;
         payoutFX.addEventListener("enterFrame",playPayoutEffect);
         payoutCash = mc.getChildByName("Cash") as MovieClip;
         payoutCoins = mc.getChildByName("Coins") as MovieClip;
         updatePayout(false,currentBet * currentMultiplier);
         buttonCash = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Bet_Cash",betCash,null,"TOOLTIP_BET_CASH");
         buttonCoins = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Bet_Coins",betCoins,null,"TOOLTIP_BET_COINS");
         if(currentBetIsCash)
         {
            buttonCash.setText("" + currentBet);
         }
         else
         {
            buttonCoins.setText("" + currentBet);
         }
         buttonCash.setVisible(currentBetIsCash);
         buttonCoins.setVisible(!currentBetIsCash);
         buttonCash.setEnabled(false);
         buttonCoins.setEnabled(false);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
      }
      
      private function updateSaldo(valueCash:int = -1, valueCoins:int = -1) : void
      {
         if(valueCash > -1)
         {
            saldoCash.text = valueCash + "";
         }
         if(valueCoins > -1)
         {
            saldoCoins.text = valueCoins + "";
         }
      }
      
      private function updateMultiplier(isActive:Boolean, value:int, playEffect:Boolean) : void
      {
         var tf:* = null;
         var effectAllowed:Boolean = playEffect && value != currentMultiplier;
         currentMultiplier = value;
         if(isActive)
         {
            multiplierActive.visible = true;
            multiplierDefault.visible = false;
            tf = multiplierActive.getChildByName("Text") as TextField;
            tf.text = "x" + value;
         }
         else
         {
            multiplierActive.visible = false;
            multiplierDefault.visible = true;
            tf = multiplierDefault.getChildByName("Text") as TextField;
            tf.text = "x" + value;
         }
         if(effectAllowed)
         {
            multiplierFX.visible = true;
            multiplierFX.gotoAndPlay(0);
         }
         else
         {
            multiplierFX.visible = false;
            multiplierFX.stop();
         }
      }
      
      private function updatePayout(playEffect:Boolean, addedAmount:int) : void
      {
         var tf:* = null;
         var mc:* = null;
         IngameBetData.addToPayout(addedAmount);
         if(currentBetIsCash)
         {
            payoutCoins.visible = false;
            payoutCash.visible = true;
            tf = payoutCash.getChildByName("Text") as TextField;
            tf.text = "" + IngameBetData.getPayout();
         }
         else
         {
            payoutCash.visible = false;
            payoutCoins.visible = true;
            tf = payoutCoins.getChildByName("Text") as TextField;
            tf.text = "" + IngameBetData.getPayout();
         }
         var popUpText:MovieClip = payoutFX.getChildByName("Popup_Text") as MovieClip;
         if(playEffect)
         {
            if(currentBetIsCash)
            {
               mc = popUpText.getChildByName("Coins") as MovieClip;
               mc.visible = false;
               mc = popUpText.getChildByName("Cash") as MovieClip;
               mc.visible = true;
            }
            else
            {
               mc = popUpText.getChildByName("Cash") as MovieClip;
               mc.visible = false;
               mc = popUpText.getChildByName("Coins") as MovieClip;
               mc.visible = true;
            }
            tf = mc.getChildByName("Text") as TextField;
            tf.text = "" + addedAmount;
            payoutFX.gotoAndPlay(0);
         }
         else
         {
            mc = popUpText.getChildByName("Coins") as MovieClip;
            mc.visible = false;
            mc = popUpText.getChildByName("Cash") as MovieClip;
            mc.visible = false;
            payoutFX.stop();
         }
      }
      
      override public function dispose() : void
      {
         if(screenIsInstalled)
         {
            multiplierFX.removeEventListener("enterFrame",playMultiplierEffect);
            payoutFX.removeEventListener("enterFrame",playPayoutEffect);
            MessageCenter.removeListener("IngameMoneyChanged",inGameMoneyChanged);
            MessageCenter.removeListener("PremiumMoneyChanged",premiumMoneyChanged);
            MessageCenter.removeListener("ingameBetPlaced",bettingCallback);
            MessageCenter.removeListener("ingameBetMultiplierChanged",multiplierChangedCallback);
         }
         super.dispose();
      }
      
      private function betCash(event:MouseEvent) : void
      {
         MessageCenter.sendEvent(new IngameBetMessage(game.player.id));
         buttonCash.setEnabled(false);
      }
      
      private function betCoins(event:MouseEvent) : void
      {
         MessageCenter.sendEvent(new IngameBetMessage(game.player.id));
         buttonCoins.setEnabled(false);
      }
      
      private function bettingCallback(msg:Message) : void
      {
         if(game.player.id == msg.data.id)
         {
            if(currentBetIsCash)
            {
               game.player.addPremiumMoney(-currentBet);
               updateSaldo(game.player.premiumMoney);
            }
            else
            {
               game.player.addIngameMoney(-currentBet);
               updateSaldo(-1,game.player.ingameMoney);
            }
            IngameBetData.addToBetAmount(currentBet);
            updateMultiplier(false,currentMultiplier,false);
            updatePayout(true,currentBet * currentMultiplier);
         }
      }
      
      private function multiplierChangedCallback(msg:Message) : void
      {
         if(game.player.id == msg.data.id)
         {
            updateMultiplier(true,msg.data.multiplier,true);
            if(canAffordBetting())
            {
               if(currentBetIsCash)
               {
                  buttonCash.setEnabled(true);
               }
               else
               {
                  buttonCoins.setEnabled(true);
               }
            }
         }
      }
      
      private function canAffordBetting() : Boolean
      {
         if(currentBetIsCash)
         {
            return currentBet <= game.player.premiumMoney;
         }
         return currentBet <= game.player.ingameMoney;
      }
      
      private function premiumMoneyChanged(msg:PremiumMoneyChangedMessage) : void
      {
         updateSaldo(msg.premiumMoney,-1);
      }
      
      private function inGameMoneyChanged(msg:IngameMoneyChangedMessage) : void
      {
         updateSaldo(-1,msg.ingameMoney);
      }
      
      private function playMultiplierEffect(event:Event) : void
      {
         if(multiplierFX.currentFrameLabel == "end")
         {
            multiplierFX.stop();
         }
         else
         {
            multiplierFX.nextFrame();
         }
      }
      
      private function playPayoutEffect(event:Event) : void
      {
         if(payoutFX.currentFrameLabel == "end")
         {
            payoutFX.stop();
         }
         else
         {
            payoutFX.nextFrame();
         }
      }
   }
}
