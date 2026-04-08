package tuxwars.battle.ui.screen.result
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.states.StateMachine;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.data.*;
   import tuxwars.battle.net.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.battle.ui.logic.result.*;
   import tuxwars.battle.ui.screen.result.awards.*;
   import tuxwars.battle.ui.screen.result.position.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.home.ui.screen.slotmachine.*;
   import tuxwars.net.*;
   import tuxwars.tournament.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
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
      
      public function ResultScreen(param1:TuxWarsGame)
      {
         var _loc2_:MovieClip = new MovieClip();
         this.darkBackGround = new DarkBackgroundElementWindow(_loc2_,param1,null,null,true);
         this.darkBackGround.setVisible(true);
         this.resultsScreen = DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","result_screen");
         _loc2_.addChild(this.resultsScreen);
         this.homeButton = TuxUiUtils.createButton(UIButton,this.resultsScreen,"Button_Home",this.homeCallback,"HOME");
         this.playAgainButton = TuxUiUtils.createButton(SecondTextFieldButton,this.resultsScreen,"Button_Play_Again",this.playAgainCallback,"REMATCH");
         this.playAgainButton.setTextSecond("","Text_Time");
         this._shareButton = TuxUiUtils.createButton(UIButton,this.resultsScreen,"Button_Share",this.shareCallback,"BUTTON_SHARE");
         this.closeButton = TuxUiUtils.createButton(UIButton,this.resultsScreen,"Button_Close",this.homeCallback,null);
         this.header = TuxUiUtils.createAutoTextField(this.resultsScreen.Text_Header,"RESULTS_SCREEN_HEADER");
         this.awardsElement = new AwardsElement(this.resultsScreen,param1);
         this.positionElement = new PositionElement(this.resultsScreen.getChildByName("Container_Participants") as MovieClip,param1);
         this.moreGuns = (this.resultsScreen as MovieClip).getChildByName("Get_Guns") as MovieClip;
         this.getMoreGunsButton = TuxUiUtils.createButton(UIButton,this.moreGuns,"Button_Get",this.getMoreGunsPressed,"RESULTS_GET_MORE_GUNS_BUTTON");
         this.tournamentInfo = (this.resultsScreen as MovieClip).getChildByName("Tournament_Info") as MovieClip;
         TuxUiUtils.createAutoTextField(this.tournamentInfo.Text_Tournament,"BUTTON_TOURNAMENT");
         this.trophies = (this.tournamentInfo as MovieClip).getChildByName("Trofies") as MovieClip;
         TuxUiUtils.createAutoTextField(this.resultsScreen.Get_Guns.Text,"RESULTS_GET_MORE_GUNS_TEXT");
         super(param1,_loc2_);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.awardsElement.init(param1);
         this.positionElement.init(param1);
         this.playerIsReadyForRematch = false;
         this.playerIsWaitingForRematch = false;
         this.enableButtons(param1);
         this.tournamentInfoInit(param1);
      }
      
      override public function dispose() : void
      {
         this.awardsElement.dispose();
         this.awardsElement = null;
         this.positionElement.dispose();
         this.positionElement = null;
         this.homeButton.dispose();
         this.homeButton = null;
         this.playAgainButton.dispose();
         this.playAgainButton = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.darkBackGround.dispose();
         this.darkBackGround = null;
         this.rematchCounter = 0;
         super.dispose();
      }
      
      public function battleCompletedResponseGot(param1:ServerResponse) : void
      {
         this.removeLoadingIndicator();
         if(param1.data.internal_code == 1071)
         {
            LogUtils.log("Error code (NoBattleInProgress): " + param1.data.internal_code + " Sending get account info call.",this,1,"Server",false);
            MessageCenter.sendEvent(new ServerRequest("GetAccountInformation",null,false,this.accountCallback));
         }
         else
         {
            LogUtils.log("Had a correct response from service: ConfirmBattleEnded",this,0,"ServerResponse",false,false,false);
            this.enableButtons(params);
         }
      }
      
      private function accountCallback(param1:ServerResponse) : void
      {
         LogUtils.log("Get account info callback: " + param1,this,1,"Server",false);
         _game.player.init(param1.data);
         this.enableButtons(params);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc2_:int = 0;
         super.logicUpdate(param1);
         if(this.rematchCounter > 0)
         {
            this.rematchCounter -= param1;
            if(this.rematchCounter <= 0)
            {
               this.playAgainButton.setEnabled(false);
               this.playAgainButton.setTextSecond("-","Text_Time");
               this.rematchTimeEnded();
               if(this.playerIsReadyForRematch)
               {
                  this.playerIsWaitingForRematch = true;
               }
               else
               {
                  MessageCenter.sendEvent(new BattleServerDisconnectMessage());
               }
            }
            else
            {
               _loc2_ = this.rematchCounter / 1000;
               this.playAgainButton.setTextSecond("" + _loc2_,"Text_Time");
            }
         }
         if(this.playerIsWaitingForRematch)
         {
            if(this.resultLogic.canStartRematch())
            {
               this.resultLogic.playAgain();
               this.playerIsWaitingForRematch = false;
            }
         }
      }
      
      public function updateRematchStamp(param1:String, param2:int) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:Vector.<PositionSlot> = this.positionElement.getActivatedPositionSlots();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.getSlotPlayer().id == param1)
            {
               _loc4_.setRematchStamp(param2);
               break;
            }
         }
      }
      
      private function rematchTimeEnded() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<PositionSlot> = this.positionElement.getActivatedPositionSlots();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.getRematchStamp() != 1)
            {
               this.updateRematchStamp(_loc2_.getSlotPlayer().id,2);
            }
         }
      }
      
      private function noRematchAvailable() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<PositionSlot> = this.positionElement.getActivatedPositionSlots();
         for each(_loc2_ in _loc1_)
         {
            this.updateRematchStamp(_loc2_.getSlotPlayer().id,3);
         }
      }
      
      public function get resultLogic() : ResultLogic
      {
         return logic as ResultLogic;
      }
      
      public function addLoadingIndicator() : void
      {
         if(!this.loadingIndicator)
         {
            this.loadingIndicator = new LoadingIndicatorScreen(tuxGame,"GET_FINAL_RESULTS",250,0);
         }
      }
      
      public function removeLoadingIndicator() : void
      {
         if(this.loadingIndicator)
         {
            this.loadingIndicator.dispose();
            this.loadingIndicator = null;
         }
      }
      
      private function homeCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PressHome");
         this.resultLogic.openShop();
      }
      
      private function playAgainCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PressReplay");
         this.playerIsReadyForRematch = true;
         MessageCenter.sendEvent(new RematchRequestMessage(_game.player.id));
         this.updateRematchStamp(_game.player.id,1);
         this.playAgainButton.setEnabled(false);
         this.homeButton.setEnabled(false);
         this.closeButton.setEnabled(false);
      }
      
      private function shareCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PostBragFeed");
         this.resultLogic.postBragFeed();
      }
      
      private function getMoreGunsPressed(param1:MouseEvent) : void
      {
         this.resultLogic.openShop();
      }
      
      override public function close(param1:StateMachine = null) : void
      {
         this.resultLogic.openShop();
      }
      
      private function enableButtons(param1:BattleResults) : void
      {
         this.homeButton.setEnabled(Boolean(Tutorial._tutorial) || param1.isPracticeMode || this.resultLogic.recievedServerResponse());
         this.closeButton.setEnabled(Boolean(Tutorial._tutorial) || param1.isPracticeMode || this.resultLogic.recievedServerResponse());
         this.getMoreGunsButton.setEnabled(param1.isPracticeMode || this.resultLogic.recievedServerResponse());
         this.awardsElement.enableButtons(Boolean(Tutorial._tutorial) || param1.isPracticeMode || this.resultLogic.recievedServerResponse());
         if(Tutorial._tutorial)
         {
            this.playAgainButton.setEnabled(false);
            this.getMoreGunsButton.setEnabled(false);
            this._shareButton.setEnabled(false);
         }
         else
         {
            if(param1.isPracticeMode)
            {
               this.playAgainButton.setEnabled(false);
               this.rematchCounter = 0;
               this.noRematchAvailable();
            }
            else if(this.resultLogic.recievedServerResponse())
            {
               this.playAgainButton.setEnabled(true);
               this.rematchCounter = BattleOptions.getRow().findField("TimeToStartRematch").value * 1000;
            }
            this._shareButton.setEnabled((param1.isPracticeMode || this.resultLogic.recievedServerResponse()) && BragFeeds.getBragFeedId(param1.playerResults) != null && param1.getPosition(_game.player.id) == 1);
         }
      }
      
      public function get shareButton() : UIButton
      {
         return this._shareButton;
      }
      
      private function tournamentInfoInit(param1:BattleResults) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.playerResults.length)
         {
            if(param1.playerResults[_loc2_].player.id == _game.player.id)
            {
               if(param1.isTournamentMode && !param1.isZeroPointGame)
               {
                  this.showTrophy(TournamentManager.getLeagueSortPriority(param1.playerResults[_loc2_].player.getMatchLeagueInfo()));
                  this.compareTournamentPoints(this._design,_loc2_ + 1,param1.playerResults[_loc2_].player.getMatchLeagueInfo() == null);
                  this.moreGuns.visible = false;
               }
               else
               {
                  this.tournamentInfo.visible = false;
               }
            }
            _loc2_++;
         }
      }
      
      private function showTrophy(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.trophies.visible = true;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc3_ = this.trophies.getChildByName("Trofy_0" + _loc2_) as MovieClip;
            _loc3_.visible = param1 == _loc2_;
            _loc2_++;
         }
      }
      
      private function compareTournamentPoints(param1:MovieClip, param2:int, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:UIAutoTextField = null;
         switch(param2 - 1)
         {
            case 0:
               _loc4_ = tuxGame.player.tournament.firstPositionPoints;
               break;
            case 1:
               _loc4_ = tuxGame.player.tournament.secondPositionPoints;
               break;
            case 2:
               _loc4_ = tuxGame.player.tournament.thirdPositionPoints;
               break;
            case 3:
               _loc4_ = tuxGame.player.tournament.fourthPositionPoints;
               break;
            default:
               _loc4_ = 0;
         }
         _loc5_ = TuxUiUtils.createAutoTextFieldWithText(this.tournamentInfo.getChildByName("Text_Points") as TextField,_loc4_ + ProjectManager.getText("PTS"));
      }
   }
}

