package tuxwars.battle.ui.screen.result
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.states.StateMachine;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.data.BattleOptions;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.battle.net.messages.control.RematchRequestMessage;
   import tuxwars.battle.ui.logic.result.BragFeeds;
   import tuxwars.battle.ui.logic.result.ResultLogic;
   import tuxwars.battle.ui.screen.result.awards.AwardsElement;
   import tuxwars.battle.ui.screen.result.position.PositionElement;
   import tuxwars.battle.ui.screen.result.position.PositionSlot;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.DarkBackgroundElementWindow;
   import tuxwars.home.ui.screen.slotmachine.SecondTextFieldButton;
   import tuxwars.net.CRMService;
   import tuxwars.tournament.TournamentManager;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.components.LoadingIndicatorScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class ResultScreen extends TuxUIScreen
   {
      
      private static const RESULTS_SCREEN:String = "result_screen";
      
      private static const PARTICIPANTS_CONTAINER:String = "Container_Participants";
       
      
      private var darkBackGround:DarkBackgroundElementWindow;
      
      private var resultsScreen:MovieClip;
      
      private var homeButton:UIButton;
      
      private var playAgainButton:SecondTextFieldButton;
      
      private var _shareButton:UIButton;
      
      private var closeButton:UIButton;
      
      private var rematchCounter:int;
      
      private var header:UIAutoTextField;
      
      private var awardsElement:AwardsElement;
      
      private var positionElement:PositionElement;
      
      private var loadingIndicator:LoadingIndicatorScreen;
      
      private var moreGuns:MovieClip;
      
      private var getMoreGunsButton:UIButton;
      
      private var tournamentInfo:MovieClip;
      
      private var tournamentPoints:UIAutoTextField;
      
      private var trophies:MovieClip;
      
      private var playerIsReadyForRematch:Boolean;
      
      private var playerIsWaitingForRematch:Boolean;
      
      public function ResultScreen(game:TuxWarsGame)
      {
         var _loc2_:MovieClip = new MovieClip();
         darkBackGround = new DarkBackgroundElementWindow(_loc2_,game,null,null,true);
         darkBackGround.setVisible(true);
         resultsScreen = DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","result_screen");
         _loc2_.addChild(resultsScreen);
         homeButton = TuxUiUtils.createButton(UIButton,resultsScreen,"Button_Home",homeCallback,"HOME");
         playAgainButton = TuxUiUtils.createButton(SecondTextFieldButton,resultsScreen,"Button_Play_Again",playAgainCallback,"REMATCH");
         playAgainButton.setTextSecond("","Text_Time");
         _shareButton = TuxUiUtils.createButton(UIButton,resultsScreen,"Button_Share",shareCallback,"BUTTON_SHARE");
         closeButton = TuxUiUtils.createButton(UIButton,resultsScreen,"Button_Close",homeCallback,null);
         header = TuxUiUtils.createAutoTextField(resultsScreen.Text_Header,"RESULTS_SCREEN_HEADER");
         awardsElement = new AwardsElement(resultsScreen,game);
         positionElement = new PositionElement(resultsScreen.getChildByName("Container_Participants") as MovieClip,game);
         moreGuns = (resultsScreen as MovieClip).getChildByName("Get_Guns") as MovieClip;
         getMoreGunsButton = TuxUiUtils.createButton(UIButton,moreGuns,"Button_Get",getMoreGunsPressed,"RESULTS_GET_MORE_GUNS_BUTTON");
         tournamentInfo = (resultsScreen as MovieClip).getChildByName("Tournament_Info") as MovieClip;
         TuxUiUtils.createAutoTextField(tournamentInfo.Text_Tournament,"BUTTON_TOURNAMENT");
         trophies = (tournamentInfo as MovieClip).getChildByName("Trofies") as MovieClip;
         TuxUiUtils.createAutoTextField(resultsScreen.Get_Guns.Text,"RESULTS_GET_MORE_GUNS_TEXT");
         super(game,_loc2_);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         awardsElement.init(params);
         positionElement.init(params);
         playerIsReadyForRematch = false;
         playerIsWaitingForRematch = false;
         enableButtons(params);
         tournamentInfoInit(params);
      }
      
      override public function dispose() : void
      {
         awardsElement.dispose();
         awardsElement = null;
         positionElement.dispose();
         positionElement = null;
         homeButton.dispose();
         homeButton = null;
         playAgainButton.dispose();
         playAgainButton = null;
         closeButton.dispose();
         closeButton = null;
         darkBackGround.dispose();
         darkBackGround = null;
         rematchCounter = 0;
         super.dispose();
      }
      
      public function battleCompletedResponseGot(response:ServerResponse) : void
      {
         removeLoadingIndicator();
         if(response.data.internal_code == 1071)
         {
            LogUtils.log("Error code (NoBattleInProgress): " + response.data.internal_code + " Sending get account info call.",this,1,"Server",false);
            MessageCenter.sendEvent(new ServerRequest("GetAccountInformation",null,false,accountCallback));
         }
         else
         {
            LogUtils.log("Had a correct response from service: ConfirmBattleEnded",this,0,"ServerResponse",false,false,false);
            enableButtons(params);
         }
      }
      
      private function accountCallback(response:ServerResponse) : void
      {
         LogUtils.log("Get account info callback: " + response,this,1,"Server",false);
         _game.player.init(response.data);
         enableButtons(params);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         var _loc2_:int = 0;
         super.logicUpdate(deltaTime);
         if(rematchCounter > 0)
         {
            rematchCounter -= deltaTime;
            if(rematchCounter <= 0)
            {
               playAgainButton.setEnabled(false);
               playAgainButton.setTextSecond("-","Text_Time");
               rematchTimeEnded();
               if(playerIsReadyForRematch)
               {
                  playerIsWaitingForRematch = true;
               }
               else
               {
                  MessageCenter.sendEvent(new BattleServerDisconnectMessage());
               }
            }
            else
            {
               _loc2_ = rematchCounter / 1000;
               playAgainButton.setTextSecond("" + _loc2_,"Text_Time");
            }
         }
         if(playerIsWaitingForRematch)
         {
            if(resultLogic.canStartRematch())
            {
               resultLogic.playAgain();
               playerIsWaitingForRematch = false;
            }
         }
      }
      
      public function updateRematchStamp(pId:String, status:int) : void
      {
         var _loc3_:Vector.<PositionSlot> = positionElement.getActivatedPositionSlots();
         for each(var slot in _loc3_)
         {
            if(slot.getSlotPlayer().id == pId)
            {
               slot.setRematchStamp(status);
               break;
            }
         }
      }
      
      private function rematchTimeEnded() : void
      {
         var _loc1_:Vector.<PositionSlot> = positionElement.getActivatedPositionSlots();
         for each(var slot in _loc1_)
         {
            if(slot.getRematchStamp() != 1)
            {
               updateRematchStamp(slot.getSlotPlayer().id,2);
            }
         }
      }
      
      private function noRematchAvailable() : void
      {
         var _loc1_:Vector.<PositionSlot> = positionElement.getActivatedPositionSlots();
         for each(var slot in _loc1_)
         {
            updateRematchStamp(slot.getSlotPlayer().id,3);
         }
      }
      
      public function get resultLogic() : ResultLogic
      {
         return logic as ResultLogic;
      }
      
      public function addLoadingIndicator() : void
      {
         if(!loadingIndicator)
         {
            loadingIndicator = new LoadingIndicatorScreen(tuxGame,"GET_FINAL_RESULTS",250,0);
         }
      }
      
      public function removeLoadingIndicator() : void
      {
         if(loadingIndicator)
         {
            loadingIndicator.dispose();
            loadingIndicator = null;
         }
      }
      
      private function homeCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PressHome");
         resultLogic.openShop();
      }
      
      private function playAgainCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PressReplay");
         playerIsReadyForRematch = true;
         MessageCenter.sendEvent(new RematchRequestMessage(_game.player.id));
         updateRematchStamp(_game.player.id,1);
         playAgainButton.setEnabled(false);
         homeButton.setEnabled(false);
         closeButton.setEnabled(false);
      }
      
      private function shareCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PostBragFeed");
         resultLogic.postBragFeed();
      }
      
      private function getMoreGunsPressed(event:MouseEvent) : void
      {
         resultLogic.openShop();
      }
      
      override public function close(exitState:StateMachine = null) : void
      {
         resultLogic.openShop();
      }
      
      private function enableButtons(results:BattleResults) : void
      {
         var _loc2_:Tutorial = Tutorial;
         homeButton.setEnabled(tuxwars.tutorial.Tutorial._tutorial || results.isPracticeMode || resultLogic.recievedServerResponse());
         var _loc3_:Tutorial = Tutorial;
         closeButton.setEnabled(tuxwars.tutorial.Tutorial._tutorial || results.isPracticeMode || resultLogic.recievedServerResponse());
         getMoreGunsButton.setEnabled(results.isPracticeMode || resultLogic.recievedServerResponse());
         var _loc4_:Tutorial = Tutorial;
         awardsElement.enableButtons(tuxwars.tutorial.Tutorial._tutorial || results.isPracticeMode || resultLogic.recievedServerResponse());
         var _loc5_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            playAgainButton.setEnabled(false);
            getMoreGunsButton.setEnabled(false);
            _shareButton.setEnabled(false);
         }
         else
         {
            if(results.isPracticeMode)
            {
               playAgainButton.setEnabled(false);
               rematchCounter = 0;
               noRematchAvailable();
            }
            else if(resultLogic.recievedServerResponse())
            {
               playAgainButton.setEnabled(true);
               var _loc6_:BattleOptions = BattleOptions;
               rematchCounter = Number(tuxwars.battle.data.BattleOptions.getRow().findField("TimeToStartRematch").value) * 1000;
            }
            _shareButton.setEnabled((results.isPracticeMode || resultLogic.recievedServerResponse()) && BragFeeds.getBragFeedId(results.playerResults) != null && results.getPosition(_game.player.id) == 1);
         }
      }
      
      public function get shareButton() : UIButton
      {
         return _shareButton;
      }
      
      private function tournamentInfoInit(results:BattleResults) : void
      {
         var i:int = 0;
         for(i = 0; i < results.playerResults.length; )
         {
            if(results.playerResults[i].player.id == _game.player.id)
            {
               if(results.isTournamentMode && !results.isZeroPointGame)
               {
                  showTrophy(TournamentManager.getLeagueSortPriority(results.playerResults[i].player.getMatchLeagueInfo()));
                  compareTournamentPoints(this._design,i + 1,results.playerResults[i].player.getMatchLeagueInfo() == null);
                  moreGuns.visible = false;
               }
               else
               {
                  tournamentInfo.visible = false;
               }
            }
            i++;
         }
      }
      
      private function showTrophy(leagueSortPriority:int) : void
      {
         var counter:int = 0;
         var _loc3_:* = null;
         trophies.visible = true;
         for(counter = 1; counter <= 5; )
         {
            _loc3_ = trophies.getChildByName("Trofy_0" + counter) as MovieClip;
            _loc3_.visible = leagueSortPriority == counter;
            counter++;
         }
      }
      
      private function compareTournamentPoints(design:MovieClip, position:int, pointsDisabled:Boolean) : void
      {
         var positionPoints:int = 0;
         var tournamentPoints:* = null;
         switch(position - 1)
         {
            case 0:
               positionPoints = tuxGame.player.tournament.firstPositionPoints;
               break;
            case 1:
               positionPoints = tuxGame.player.tournament.secondPositionPoints;
               break;
            case 2:
               positionPoints = tuxGame.player.tournament.thirdPositionPoints;
               break;
            case 3:
               positionPoints = tuxGame.player.tournament.fourthPositionPoints;
               break;
            default:
               positionPoints = 0;
         }
         tournamentPoints = TuxUiUtils.createAutoTextFieldWithText(tournamentInfo.getChildByName("Text_Points") as TextField,positionPoints + ProjectManager.getText("PTS"));
      }
   }
}
