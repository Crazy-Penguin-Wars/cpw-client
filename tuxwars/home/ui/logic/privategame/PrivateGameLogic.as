package tuxwars.home.ui.logic.privategame
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.*;
   import tuxwars.data.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.privategame.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.hostleft.*;
   
   public class PrivateGameLogic extends TuxUILogic
   {
      public function PrivateGameLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         MessageCenter.addListener("BattleResponse",this.responseCallback);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("BattleResponse",this.responseCallback);
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
      
      private function responseCallback(param1:BattleResponse) : void
      {
         var _loc2_:Object = null;
         switch(param1.responseType - 27)
         {
            case 0:
               MessageCenter.sendEvent(new BattleServerDisconnectMessage());
               _loc2_ = param1.data;
               _loc2_["matchKey"] = this.gameModel.matchKey;
               _loc2_["vip_active_for_this_match"] = this.gameModel.vip;
               game.homeState.changeState(new PrivateGameMatchLoadingSubState(game,_loc2_));
               break;
            case 3:
               LogUtils.log("Game settings msg: " + param1.responseText,this,1,"ReceivedMessage");
               this.gameModel.update(param1.data);
               if(this.gameModel.hasOwnerLeft())
               {
                  if(!PopUpManager.instance)
                  {
                     PopUpManager.instance = new PopUpManager();
                  }
                  PopUpManager.instance.addPopup(new HostLeftMessagePopUpSubState(game));
                  if(!PopUpManager.instance)
                  {
                     PopUpManager.instance = new PopUpManager();
                  }
                  PopUpManager.instance.showPopUps(game.homeState);
               }
               else
               {
                  this.privateGameScreen.update();
               }
               break;
            default:
               LogUtils.log("Unknown message: " + param1.responseText,this,2,"ReceivedMessage");
         }
      }
   }
}

