package tuxwars.battle.ui.screen.ingamebetting
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.data.*;
   import tuxwars.events.IngameMoneyChangedMessage;
   import tuxwars.events.PremiumMoneyChangedMessage;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.utils.*;
   
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
      
      public function IngameBettingScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this.screenIsInstalled = param2 && param2.player && Boolean(param2.player.betData) && (param2.player.betData.valueIngame > 0 || param2.player.betData.valuePremium > 0);
         if(!this.screenIsInstalled)
         {
            getDesignMovieClip().visible = false;
            return;
         }
         this.currentBetIsCash = param2.player.betData.valuePremium > 0;
         this.currentMultiplier = 2;
         this.currentBet = !!this.currentBetIsCash ? param2.player.betData.valuePremium : param2.player.betData.valueIngame;
         MessageCenter.addListener("ingameBetPlaced",this.bettingCallback);
         MessageCenter.addListener("ingameBetMultiplierChanged",this.multiplierChangedCallback);
         var _loc3_:TextField = getDesignMovieClip().getChildByName("Text_Payout") as TextField;
         _loc3_.text = ProjectManager.getText("INGAME_BETTING_PAYOUT");
         _loc3_ = getDesignMovieClip().getChildByName("Text_Bet") as TextField;
         _loc3_.text = ProjectManager.getText("INGAME_BETTING_BET");
         var _loc4_:MovieClip = getDesignMovieClip().getChildByName("Saldo") as MovieClip;
         this.saldoCash = _loc4_.getChildByName("Text_Cash") as TextField;
         this.saldoCoins = _loc4_.getChildByName("Text_Coins") as TextField;
         this.updateSaldo(param2.player.premiumMoney,param2.player.ingameMoney);
         MessageCenter.addListener("IngameMoneyChanged",this.inGameMoneyChanged);
         MessageCenter.addListener("PremiumMoneyChanged",this.premiumMoneyChanged);
         _loc4_ = getDesignMovieClip().getChildByName("Multiplier") as MovieClip;
         this.multiplierFX = _loc4_.getChildByName("Fx") as MovieClip;
         this.multiplierFX.addEventListener("enterFrame",this.playMultiplierEffect);
         this.multiplierActive = _loc4_.getChildByName("Active") as MovieClip;
         this.multiplierDefault = _loc4_.getChildByName("Default") as MovieClip;
         this.updateMultiplier(false,this.currentMultiplier,false);
         _loc4_ = getDesignMovieClip().getChildByName("Payout") as MovieClip;
         this.payoutFX = _loc4_.getChildByName("Fx") as MovieClip;
         this.payoutFX.addEventListener("enterFrame",this.playPayoutEffect);
         this.payoutCash = _loc4_.getChildByName("Cash") as MovieClip;
         this.payoutCoins = _loc4_.getChildByName("Coins") as MovieClip;
         this.updatePayout(false,this.currentBet * this.currentMultiplier);
         this.buttonCash = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Bet_Cash",this.betCash,null,"TOOLTIP_BET_CASH");
         this.buttonCoins = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Bet_Coins",this.betCoins,null,"TOOLTIP_BET_COINS");
         if(this.currentBetIsCash)
         {
            this.buttonCash.setText("" + this.currentBet);
         }
         else
         {
            this.buttonCoins.setText("" + this.currentBet);
         }
         this.buttonCash.setVisible(this.currentBetIsCash);
         this.buttonCoins.setVisible(!this.currentBetIsCash);
         this.buttonCash.setEnabled(false);
         this.buttonCoins.setEnabled(false);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
      }
      
      private function updateSaldo(param1:int = -1, param2:int = -1) : void
      {
         if(param1 > -1)
         {
            this.saldoCash.text = param1 + "";
         }
         if(param2 > -1)
         {
            this.saldoCoins.text = param2 + "";
         }
      }
      
      private function updateMultiplier(param1:Boolean, param2:int, param3:Boolean) : void
      {
         var _loc4_:TextField = null;
         var _loc5_:Boolean = param3 && param2 != this.currentMultiplier;
         this.currentMultiplier = param2;
         if(param1)
         {
            this.multiplierActive.visible = true;
            this.multiplierDefault.visible = false;
            _loc4_ = this.multiplierActive.getChildByName("Text") as TextField;
            _loc4_.text = "x" + param2;
         }
         else
         {
            this.multiplierActive.visible = false;
            this.multiplierDefault.visible = true;
            _loc4_ = this.multiplierDefault.getChildByName("Text") as TextField;
            _loc4_.text = "x" + param2;
         }
         if(_loc5_)
         {
            this.multiplierFX.visible = true;
            this.multiplierFX.gotoAndPlay(0);
         }
         else
         {
            this.multiplierFX.visible = false;
            this.multiplierFX.stop();
         }
      }
      
      private function updatePayout(param1:Boolean, param2:int) : void
      {
         var _loc3_:TextField = null;
         var _loc4_:MovieClip = null;
         IngameBetData.addToPayout(param2);
         if(this.currentBetIsCash)
         {
            this.payoutCoins.visible = false;
            this.payoutCash.visible = true;
            _loc3_ = this.payoutCash.getChildByName("Text") as TextField;
            _loc3_.text = "" + IngameBetData.getPayout();
         }
         else
         {
            this.payoutCash.visible = false;
            this.payoutCoins.visible = true;
            _loc3_ = this.payoutCoins.getChildByName("Text") as TextField;
            _loc3_.text = "" + IngameBetData.getPayout();
         }
         var _loc5_:MovieClip = this.payoutFX.getChildByName("Popup_Text") as MovieClip;
         if(param1)
         {
            if(this.currentBetIsCash)
            {
               _loc4_ = _loc5_.getChildByName("Coins") as MovieClip;
               _loc4_.visible = false;
               _loc4_ = _loc5_.getChildByName("Cash") as MovieClip;
               _loc4_.visible = true;
            }
            else
            {
               _loc4_ = _loc5_.getChildByName("Cash") as MovieClip;
               _loc4_.visible = false;
               _loc4_ = _loc5_.getChildByName("Coins") as MovieClip;
               _loc4_.visible = true;
            }
            _loc3_ = _loc4_.getChildByName("Text") as TextField;
            _loc3_.text = "" + param2;
            this.payoutFX.gotoAndPlay(0);
         }
         else
         {
            _loc4_ = _loc5_.getChildByName("Coins") as MovieClip;
            _loc4_.visible = false;
            _loc4_ = _loc5_.getChildByName("Cash") as MovieClip;
            _loc4_.visible = false;
            this.payoutFX.stop();
         }
      }
      
      override public function dispose() : void
      {
         if(this.screenIsInstalled)
         {
            this.multiplierFX.removeEventListener("enterFrame",this.playMultiplierEffect);
            this.payoutFX.removeEventListener("enterFrame",this.playPayoutEffect);
            MessageCenter.removeListener("IngameMoneyChanged",this.inGameMoneyChanged);
            MessageCenter.removeListener("PremiumMoneyChanged",this.premiumMoneyChanged);
            MessageCenter.removeListener("ingameBetPlaced",this.bettingCallback);
            MessageCenter.removeListener("ingameBetMultiplierChanged",this.multiplierChangedCallback);
         }
         super.dispose();
      }
      
      private function betCash(param1:MouseEvent) : void
      {
         MessageCenter.sendEvent(new IngameBetMessage(game.player.id));
         this.buttonCash.setEnabled(false);
      }
      
      private function betCoins(param1:MouseEvent) : void
      {
         MessageCenter.sendEvent(new IngameBetMessage(game.player.id));
         this.buttonCoins.setEnabled(false);
      }
      
      private function bettingCallback(param1:Message) : void
      {
         if(game.player.id == param1.data.id)
         {
            if(this.currentBetIsCash)
            {
               game.player.addPremiumMoney(-this.currentBet);
               this.updateSaldo(game.player.premiumMoney);
            }
            else
            {
               game.player.addIngameMoney(-this.currentBet);
               this.updateSaldo(-1,game.player.ingameMoney);
            }
            IngameBetData.addToBetAmount(this.currentBet);
            this.updateMultiplier(false,this.currentMultiplier,false);
            this.updatePayout(true,this.currentBet * this.currentMultiplier);
         }
      }
      
      private function multiplierChangedCallback(param1:Message) : void
      {
         if(game.player.id == param1.data.id)
         {
            this.updateMultiplier(true,param1.data.multiplier,true);
            if(this.canAffordBetting())
            {
               if(this.currentBetIsCash)
               {
                  this.buttonCash.setEnabled(true);
               }
               else
               {
                  this.buttonCoins.setEnabled(true);
               }
            }
         }
      }
      
      private function canAffordBetting() : Boolean
      {
         if(this.currentBetIsCash)
         {
            return this.currentBet <= game.player.premiumMoney;
         }
         return this.currentBet <= game.player.ingameMoney;
      }
      
      private function premiumMoneyChanged(param1:PremiumMoneyChangedMessage) : void
      {
         this.updateSaldo(param1.premiumMoney,-1);
      }
      
      private function inGameMoneyChanged(param1:IngameMoneyChangedMessage) : void
      {
         this.updateSaldo(-1,param1.ingameMoney);
      }
      
      private function playMultiplierEffect(param1:Event) : void
      {
         if(this.multiplierFX.currentFrameLabel == "end")
         {
            this.multiplierFX.stop();
         }
         else
         {
            this.multiplierFX.nextFrame();
         }
      }
      
      private function playPayoutEffect(param1:Event) : void
      {
         if(this.payoutFX.currentFrameLabel == "end")
         {
            this.payoutFX.stop();
         }
         else
         {
            this.payoutFX.nextFrame();
         }
      }
   }
}

