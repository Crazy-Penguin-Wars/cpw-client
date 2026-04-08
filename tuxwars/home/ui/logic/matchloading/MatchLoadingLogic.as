package tuxwars.home.ui.logic.matchloading
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.*;
   import tuxwars.battle.ui.logic.bets.*;
   import tuxwars.data.*;
   import tuxwars.events.TextIDMessage;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.matchloading.MatchLoadingScreen;
   import tuxwars.items.data.BetData;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   
   public class MatchLoadingLogic extends TuxUILogic
   {
      private var betIsReady:Boolean;
      
      private var betCountdownTimer:int;
      
      private var betCountdownTimerPreviousSeconds:int;
      
      private var _moneyLogic:MoneyResourceElementLogicForBetting;
      
      private var selectedId:String;
      
      public function MatchLoadingLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         MessageCenter.addListener("TextID",this.textIdListener);
         MessageCenter.addListener("BattleServerConnected",this.battleServerConnected);
         this.betIsReady = false;
         this.betCountdownTimer = 0;
         this.betCountdownTimerPreviousSeconds = 0;
         param1.player.betData = null;
         this._moneyLogic = new MoneyResourceElementLogicForBetting(param1);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         MessageCenter.addListener("BattleResponse",this.responseCallback);
         IngameBetData.nullValues();
         if(this.loadingScreen.showBettingScreen())
         {
            this.betCountdownTimer = BetManager.getBetingTime() * 1000;
            this.betCountdownTimerPreviousSeconds = 0;
            this.loadingScreen.updateMessage(ProjectManager.getText("MATCH_LOADING_PLACE_BET"));
         }
         else
         {
            this.bettingReady();
         }
      }
      
      override public function set screen(param1:*) : void
      {
         super.screen = param1;
         if(this.loadingScreen.showBettingScreen())
         {
            this._moneyLogic.screen = this.loadingScreen.moneyScreen;
            this._moneyLogic.disableButtons();
            this._moneyLogic.hideButtons();
            this.selectedId = this.loadingScreen.getSelectedBetId();
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("TextID",this.textIdListener);
         MessageCenter.removeListener("BattleServerConnected",this.battleServerConnected);
         MessageCenter.removeListener("BattleResponse",this.responseCallback);
         this._moneyLogic.dispose();
         this._moneyLogic = null;
         super.dispose();
      }
      
      public function exit() : void
      {
         if(game.battleServer.isConnected())
         {
            MessageCenter.sendEvent(new BattleServerDisconnectMessage());
            MessageCenter.sendEvent(new ServerRequest("ConfirmBattleEnded"));
         }
         MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
         Sounds.playTheme();
         super.close();
      }
      
      protected function get loadingScreen() : MatchLoadingScreen
      {
         return screen;
      }
      
      private function textIdListener(param1:TextIDMessage) : void
      {
         this.loadingScreen.updateMessage(ProjectManager.getText(param1.tid));
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc2_:int = 0;
         super.logicUpdate(param1);
         if(this.betCountdownTimer > 0)
         {
            this.betCountdownTimer -= param1;
            _loc2_ = this.betCountdownTimer / 1000;
            if(_loc2_ < 1)
            {
               this.bettingReady();
            }
            else if(this.betCountdownTimerPreviousSeconds != _loc2_)
            {
               this.loadingScreen.updateBettingCountdown(_loc2_.toString());
               this.betCountdownTimerPreviousSeconds = _loc2_;
            }
         }
      }
      
      public function setBets(param1:String) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = true;
         var _loc3_:SoundReference = null;
         var _loc4_:BetData = BetManager.getBet(this.selectedId);
         var _loc5_:BetData = BetManager.getBet(param1);
         this.selectedId = param1;
         IngameBetData.nullValues();
         if(true || _loc4_.id != _loc5_.id)
         {
            if(_loc4_.valuePremium > 0)
            {
               this.loadingScreen.moneyScreen.setPremiumMoney("" + game.player.premiumMoney);
               this._moneyLogic.setPremiumBet(0);
            }
            else if(_loc4_.valueIngame > 0)
            {
               this.loadingScreen.moneyScreen.setInGameMoney("" + game.player.ingameMoney);
               this._moneyLogic.setIngameBet(0);
            }
            if(_loc5_.valuePremium > 0)
            {
               this.loadingScreen.moneyScreen.setPremiumMoney("" + (game.player.premiumMoney - _loc5_.valuePremium));
               this.loadingScreen.animate(true,_loc5_.valuePremium);
               this._moneyLogic.setPremiumBet(_loc5_.valuePremium);
               IngameBetData.addToBetAmount(_loc5_.valuePremium);
            }
            else if(_loc5_.valueIngame > 0)
            {
               this.loadingScreen.moneyScreen.setInGameMoney("" + (game.player.ingameMoney - _loc5_.valueIngame));
               this.loadingScreen.animate(false,_loc5_.valueIngame);
               this._moneyLogic.setIngameBet(_loc5_.valueIngame);
               IngameBetData.addToBetAmount(_loc5_.valueIngame);
            }
            if(_loc5_.valuePremium > 0 || _loc5_.valueIngame > 0)
            {
               _loc3_ = Sounds.getSoundReference("Buy");
               if(_loc3_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
               }
            }
            this.bettingReady();
         }
      }
      
      private function battleServerConnected(param1:Message) : void
      {
         this.loadingScreen.closeButton.setEnabled(false);
      }
      
      public function bettingReady() : void
      {
         this.betCountdownTimer = 0;
         var _loc1_:BetData = BetManager.getBet(this.selectedId);
         if(_loc1_)
         {
            if(_loc1_.valuePremium > 0)
            {
               game.player.addPremiumMoney(-_loc1_.valuePremium);
               CRMService.sendEvent("Economy","Spend PC","Confirmed","Betting",null,_loc1_.valuePremium);
            }
            else if(_loc1_.valueIngame > 0)
            {
               game.player.addIngameMoney(-_loc1_.valueIngame);
               CRMService.sendEvent("Economy","Spend GC","Confirmed","Betting",null,_loc1_.valueIngame);
            }
         }
         game.player.betData = _loc1_;
         this.loadingScreen.updateBettingCountdown("");
         this.loadingScreen.updateMessage("");
         this.loadingScreen.bettingSelectionCompleted(this.selectedId);
         this.betIsReady = true;
      }
      
      public function isBettingReady() : Boolean
      {
         return this.betIsReady;
      }
      
      public function isRematch() : Boolean
      {
         return false;
      }
      
      public function get moneyLogic() : MoneyResourceElementLogicForBetting
      {
         return this._moneyLogic;
      }
      
      private function responseCallback(param1:BattleResponse) : void
      {
         var _loc5_:* = undefined;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         switch(param1.responseType - 41)
         {
            case 0:
               LogUtils.log("Rematch response msg: " + param1.responseText,this,1,"ReceivedMessage");
               _loc2_ = param1.data.ready_clients;
               for each(_loc5_ in _loc2_)
               {
                  this.loadingScreen.updateRematchSlotStatus(_loc5_,1);
               }
               _loc3_ = param1.data.pending_clients;
               for each(_loc5_ in _loc3_)
               {
                  this.loadingScreen.updateRematchSlotStatus(_loc5_,0);
               }
               _loc4_ = param1.data.left_clients;
               for each(_loc5_ in _loc4_)
               {
                  this.loadingScreen.updateRematchSlotStatus(_loc5_,2);
               }
               break;
            default:
               LogUtils.log("Unknown message: " + param1.responseText,this,2,"ReceivedMessage");
         }
      }
   }
}

