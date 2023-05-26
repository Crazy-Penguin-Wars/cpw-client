package tuxwars.home.ui.logic.matchloading
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.battle.ui.logic.bets.BetManager;
   import tuxwars.data.IngameBetData;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.events.TextIDMessage;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.matchloading.MatchLoadingScreen;
   import tuxwars.items.data.BetData;
   import tuxwars.net.CRMService;
   import tuxwars.states.TuxState;
   
   public class MatchLoadingLogic extends TuxUILogic
   {
       
      
      private var betIsReady:Boolean;
      
      private var betCountdownTimer:int;
      
      private var betCountdownTimerPreviousSeconds:int;
      
      private var _moneyLogic:MoneyResourceElementLogicForBetting;
      
      private var selectedId:String;
      
      public function MatchLoadingLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         MessageCenter.addListener("TextID",textIdListener);
         MessageCenter.addListener("BattleServerConnected",battleServerConnected);
         betIsReady = false;
         betCountdownTimer = 0;
         betCountdownTimerPreviousSeconds = 0;
         game.player.betData = null;
         _moneyLogic = new MoneyResourceElementLogicForBetting(game);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         MessageCenter.addListener("BattleResponse",responseCallback);
         IngameBetData.nullValues();
         if(loadingScreen.showBettingScreen())
         {
            betCountdownTimer = BetManager.getBetingTime() * 1000;
            betCountdownTimerPreviousSeconds = 0;
            loadingScreen.updateMessage(ProjectManager.getText("MATCH_LOADING_PLACE_BET"));
         }
         else
         {
            bettingReady();
         }
      }
      
      override public function set screen(screen:*) : void
      {
         super.screen = screen;
         if(loadingScreen.showBettingScreen())
         {
            _moneyLogic.screen = loadingScreen.moneyScreen;
            _moneyLogic.disableButtons();
            _moneyLogic.hideButtons();
            selectedId = loadingScreen.getSelectedBetId();
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("TextID",textIdListener);
         MessageCenter.removeListener("BattleServerConnected",battleServerConnected);
         MessageCenter.removeListener("BattleResponse",responseCallback);
         _moneyLogic.dispose();
         _moneyLogic = null;
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
      
      private function textIdListener(msg:TextIDMessage) : void
      {
         loadingScreen.updateMessage(ProjectManager.getText(msg.tid));
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         var _loc2_:int = 0;
         super.logicUpdate(deltaTime);
         if(betCountdownTimer > 0)
         {
            betCountdownTimer -= deltaTime;
            _loc2_ = betCountdownTimer / 1000;
            if(_loc2_ < 1)
            {
               bettingReady();
            }
            else if(betCountdownTimerPreviousSeconds != _loc2_)
            {
               loadingScreen.updateBettingCountdown(_loc2_.toString());
               betCountdownTimerPreviousSeconds = _loc2_;
            }
         }
      }
      
      public function setBets(newId:String) : void
      {
         var _loc3_:Boolean = false;
         _loc3_ = true;
         var sound:* = null;
         var _loc5_:BetData = BetManager.getBet(selectedId);
         var _loc2_:BetData = BetManager.getBet(newId);
         selectedId = newId;
         IngameBetData.nullValues();
         if(_loc5_.valuePremium > 0)
         {
            loadingScreen.moneyScreen.setPremiumMoney("" + game.player.premiumMoney);
            _moneyLogic.setPremiumBet(0);
         }
         else if(_loc5_.valueIngame > 0)
         {
            loadingScreen.moneyScreen.setInGameMoney("" + game.player.ingameMoney);
            _moneyLogic.setIngameBet(0);
         }
         if(_loc2_.valuePremium > 0)
         {
            loadingScreen.moneyScreen.setPremiumMoney("" + (game.player.premiumMoney - _loc2_.valuePremium));
            loadingScreen.animate(true,_loc2_.valuePremium);
            _moneyLogic.setPremiumBet(_loc2_.valuePremium);
            IngameBetData.addToBetAmount(_loc2_.valuePremium);
         }
         else if(_loc2_.valueIngame > 0)
         {
            loadingScreen.moneyScreen.setInGameMoney("" + (game.player.ingameMoney - _loc2_.valueIngame));
            loadingScreen.animate(false,_loc2_.valueIngame);
            _moneyLogic.setIngameBet(_loc2_.valueIngame);
            IngameBetData.addToBetAmount(_loc2_.valueIngame);
         }
         if(_loc2_.valuePremium > 0 || _loc2_.valueIngame > 0)
         {
            sound = Sounds.getSoundReference("Buy");
            if(sound)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
            }
         }
         bettingReady();
      }
      
      private function battleServerConnected(msg:Message) : void
      {
         loadingScreen.closeButton.setEnabled(false);
      }
      
      public function bettingReady() : void
      {
         betCountdownTimer = 0;
         var _loc1_:BetData = BetManager.getBet(selectedId);
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
         loadingScreen.updateBettingCountdown("");
         loadingScreen.updateMessage("");
         loadingScreen.bettingSelectionCompleted(selectedId);
         betIsReady = true;
      }
      
      public function isBettingReady() : Boolean
      {
         return betIsReady;
      }
      
      public function isRematch() : Boolean
      {
         return false;
      }
      
      public function get moneyLogic() : MoneyResourceElementLogicForBetting
      {
         return _moneyLogic;
      }
      
      private function responseCallback(response:BattleResponse) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         switch(response.responseType - 41)
         {
            case 0:
               LogUtils.log("Rematch response msg: " + response.responseText,this,1,"ReceivedMessage");
               _loc3_ = response.data.ready_clients;
               for each(var c in _loc3_)
               {
                  loadingScreen.updateRematchSlotStatus(c,1);
               }
               _loc2_ = response.data.pending_clients;
               for each(c in _loc2_)
               {
                  loadingScreen.updateRematchSlotStatus(c,0);
               }
               _loc4_ = response.data.left_clients;
               for each(c in _loc4_)
               {
                  loadingScreen.updateRematchSlotStatus(c,2);
               }
               break;
            default:
               LogUtils.log("Unknown message: " + response.responseText,this,2,"ReceivedMessage");
         }
      }
   }
}
