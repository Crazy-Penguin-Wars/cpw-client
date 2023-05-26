package tuxwars.home.ui.logic.privategame
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.matchloading.PrivateGameMatchLoadingSubState;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.privategame.PrivateGameScreen;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.hostleft.HostLeftMessagePopUpSubState;
   
   public class PrivateGameLogic extends TuxUILogic
   {
       
      
      public function PrivateGameLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         MessageCenter.addListener("BattleResponse",responseCallback);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("BattleResponse",responseCallback);
         super.dispose();
      }
      
      public function exit() : void
      {
         MessageCenter.sendEvent(new BattleServerDisconnectMessage());
         super.close();
      }
      
      public function get privateGameScreen() : PrivateGameScreen
      {
         return screen as PrivateGameScreen;
      }
      
      protected function get gameModel() : PrivateGameModel
      {
         return params as PrivateGameModel;
      }
      
      private function responseCallback(response:BattleResponse) : void
      {
         var _loc2_:* = null;
         switch(response.responseType - 27)
         {
            case 0:
               MessageCenter.sendEvent(new BattleServerDisconnectMessage());
               _loc2_ = response.data;
               _loc2_["matchKey"] = gameModel.matchKey;
               _loc2_["vip_active_for_this_match"] = gameModel.vip;
               game.homeState.changeState(new PrivateGameMatchLoadingSubState(game,_loc2_));
               break;
            case 3:
               LogUtils.log("Game settings msg: " + response.responseText,this,1,"ReceivedMessage");
               gameModel.update(response.data);
               if(gameModel.hasOwnerLeft())
               {
                  var _loc3_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.addPopup(new HostLeftMessagePopUpSubState(game));
                  var _loc4_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.showPopUps(game.homeState);
                  break;
               }
               privateGameScreen.update();
               break;
            default:
               LogUtils.log("Unknown message: " + response.responseText,this,2,"ReceivedMessage");
         }
      }
   }
}
