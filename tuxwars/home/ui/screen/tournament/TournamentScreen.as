package tuxwars.home.ui.screen.tournament
{
   import com.dchoc.net.ServerRequest;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.transitions.UITransition;
   import com.dchoc.ui.utils.UIUtils;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.TextUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.BattleOptions;
   import tuxwars.home.states.help.HelpState;
   import tuxwars.home.states.matchloading.TournamentMatchLoadingSubState;
   import tuxwars.home.states.tournament.TournamentEndState;
   import tuxwars.home.ui.logic.tournament.TournamentLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.items.TournamentRewardItem;
   import tuxwars.net.CRMService;
   import tuxwars.tournament.League;
   import tuxwars.tournament.Tournament;
   import tuxwars.tournament.TournamentPlayer;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class TournamentScreen extends TuxUIScreen
   {
      
      private static const LEAGUE_SLOT_AMOUNT:int = 5;
      
      private static const CLOSE_BUTTON:String = "Button_Close";
      
      private static const PLAY_BUTTON:String = "Button_Play";
      
      private static const HELP_BUTTON:String = "Button_Help";
       
      
      private var cursorPos:int = 0;
      
      private var myIndex:int;
      
      private var myPlayer:TournamentPlayer;
      
      private var myPositionChange:int;
      
      private var _playButton:UIButton;
      
      private var _closeButton:UIButton;
      
      private var _scrollUpButton:UIButton;
      
      private var _scrollRightButton:UIButton;
      
      private var _helpButton:UIButton;
      
      private const headerText:UIAutoTextField = new UIAutoTextField();
      
      private var leagueNameText:TextField;
      
      private var leagueTimeText:TextField;
      
      private var leagueTimeValueText:TextField;
      
      private var leagueGamesText:TextField;
      
      private var leagueGamesValueText:TextField;
      
      private var leaguePointsText:TextField;
      
      private var leaguePointsValueText:TextField;
      
      private var leagueRewardsText:TextField;
      
      private var leagueRewards:MovieClip;
      
      private var textWait:TextField;
      
      private var _trofies:MovieClip;
      
      private var rewardSlots:Vector.<TournamentRewardSlot>;
      
      private var _leagueSlots:Vector.<LeagueSlot>;
      
      private var _topSlot:LeagueSlot;
      
      private var _bottomSlot:LeagueSlot;
      
      private var _tournament:Tournament;
      
      private var _league:League;
      
      private var _qualification:MovieClip;
      
      private var _qualificationText:TextField;
      
      public function TournamentScreen(game:TuxWarsGame)
      {
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/tournament.swf","tournament_list");
         super(game,_loc2_);
         _playButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Play",playCallback);
         _playButton.setText(ProjectManager.getText("BUTTON_PLAY"));
         _playButton.setVisible(false);
         _closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",closeCallback);
         _helpButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Help",helpCallback);
         _helpButton.setText(ProjectManager.getText("BUTTON_HELP"));
         headerText.setTextField(_loc2_.Text_Header);
         headerText.setText("");
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         _trofies = (this._design as MovieClip).getChildByName("Trofies") as MovieClip;
         _trofies.visible = false;
         leagueNameText = MovieClip(this._design).getChildByName("Text_League") as TextField;
         leagueNameText.text = "";
         leagueTimeText = MovieClip(this._design).getChildByName("Text_Time") as TextField;
         leagueTimeText.text = ProjectManager.getText("TOURNAMENT_TIME_LEFT");
         leagueTimeValueText = MovieClip(this._design).getChildByName("Text_Time_Value") as TextField;
         leagueTimeValueText.text = "";
         leagueGamesText = MovieClip(this._design).getChildByName("Text_Games") as TextField;
         leagueGamesText.text = ProjectManager.getText("TOURNAMENT_GAMES");
         leagueGamesValueText = MovieClip(this._design).getChildByName("Text_Games_Value") as TextField;
         leagueGamesValueText.text = "";
         leaguePointsText = MovieClip(this._design).getChildByName("Text_Points") as TextField;
         leaguePointsText.text = ProjectManager.getText("TOURNAMENT_POINTS");
         leaguePointsValueText = MovieClip(this._design).getChildByName("Text_Points_Value") as TextField;
         leaguePointsValueText.text = "";
         leagueRewardsText = MovieClip(this._design).getChildByName("Text_Rewards") as TextField;
         leagueRewardsText.text = ProjectManager.getText("TOURNAMENT_REWARDS");
         leagueRewards = MovieClip(this._design).getChildByName("Container_Rewards") as MovieClip;
         (leagueRewards.getChildByName("Container_Items_1") as MovieClip).visible = false;
         (leagueRewards.getChildByName("Container_Items_2") as MovieClip).visible = false;
         (leagueRewards.getChildByName("Container_Items_3") as MovieClip).visible = false;
         (leagueRewards.getChildByName("Container_Items_4") as MovieClip).visible = false;
         textWait = MovieClip(this._design).getChildByName("Text_Wait") as TextField;
         textWait.text = "";
         textWait.visible = false;
         rewardSlots = new Vector.<TournamentRewardSlot>();
         initLeagueSlots();
         initTournamentInfo();
      }
      
      private function initLeagueSlots() : void
      {
         var slotCounter:int = 0;
         var slotDesign:* = null;
         _leagueSlots = new Vector.<LeagueSlot>();
         var leagueSlots:MovieClip = (this._design as MovieClip).getChildByName("League_Slots") as MovieClip;
         var slots:MovieClip = leagueSlots.getChildByName("Container_Slots") as MovieClip;
         _scrollUpButton = TuxUiUtils.createButton(UIButton,leagueSlots,"Button_Scroll_Left",scrollUp);
         _scrollRightButton = TuxUiUtils.createButton(UIButton,leagueSlots,"Button_Scroll_Right",scrollDown);
         for(slotCounter = 1; slotCounter <= 5; )
         {
            slotDesign = slots.getChildByName("Slot_0" + slotCounter) as MovieClip;
            _leagueSlots.push(new LeagueSlot(slotDesign));
            slotCounter++;
         }
         slotDesign = slots.getChildByName("Slot_Top") as MovieClip;
         _topSlot = new LeagueSlot(slotDesign);
         slotDesign = slots.getChildByName("Slot_Bottom") as MovieClip;
         _bottomSlot = new LeagueSlot(slotDesign);
         _qualification = (this._design as MovieClip).getChildByName("qualification") as MovieClip;
         _qualification.visible = false;
         _qualificationText = _qualification.getChildByName("Text") as TextField;
         _qualificationText.text = "";
         updateScrollStates();
      }
      
      private function initTournamentInfo() : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         var positionNumber:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var centralizedPos:int = 0;
         if(!_game.player.tournament || !_game.player.tournament.league)
         {
            _qualification.visible = true;
            _qualificationText.text = ProjectManager.getText("TOURNAMENT_NO_ACTIVE_TOURNAMENT");
            return;
         }
         _tournament = _game.player.tournament;
         _league = _tournament.league;
         myIndex = _league.findMyIndex();
         myPlayer = _league.getPlayers()[myIndex];
         if(myPlayer.previous_rank > 0)
         {
            myPositionChange = myPlayer.rank - myPlayer.previous_rank;
         }
         else
         {
            myPositionChange = 0;
         }
         headerText.setText(_tournament.name);
         _trofies.visible = true;
         for(i = 0; i < _trofies.numChildren; )
         {
            _trofies.getChildAt(i).visible = _trofies.getChildAt(i).name == _league.trophyGraphic;
            i++;
         }
         leagueNameText.text = _league.name;
         leagueGamesValueText.text = _league.playedGames + "/" + _tournament.gameMaxAmount;
         leaguePointsValueText.text = "" + _league.points;
         var _loc3_:int = _league.getPositionRewardsAmount();
         for(i = 1; i <= 4; )
         {
            _loc2_ = leagueRewards.getChildByName("Container_Items_" + i) as MovieClip;
            if(i == _loc3_)
            {
               _loc2_.visible = true;
               for(positionNumber = 1; positionNumber <= _loc3_; )
               {
                  _loc1_ = _loc2_.getChildByName("Slot_0" + positionNumber) as MovieClip;
                  _loc4_ = _league.getPositionReward(positionNumber);
                  rewardSlots.push(new TournamentRewardSlot(_loc1_,_game,_loc4_,positionNumber,this,true));
                  positionNumber++;
               }
            }
            else
            {
               _loc2_.visible = false;
            }
            i++;
         }
         if(_league.getPlayers().length > 5)
         {
            centralizedPos = myIndex - 2;
            while(centralizedPos < 0)
            {
               centralizedPos++;
            }
            while(centralizedPos + 5 > _league.getPlayers().length)
            {
               centralizedPos--;
            }
            cursorPos = centralizedPos;
         }
         else
         {
            cursorPos = 0;
         }
         updateSlots();
         myPositionChange = 0;
         if(_league.playedGames < _tournament.gameMaxAmount)
         {
            if(_tournament.getTournamentTimeInSeconds() / 60 > BattleOptions.getMatchTime())
            {
               _playButton.setVisible(true);
               textWait.visible = false;
            }
            else
            {
               _playButton.setVisible(false);
               textWait.visible = true;
               textWait.text = ProjectManager.getText("TOURNAMENT_NO_TIME_LEFT");
            }
         }
         else
         {
            _playButton.setVisible(false);
            textWait.visible = true;
            textWait.text = ProjectManager.getText("TOURNAMENT_GAMES_PLAYED",[_tournament.gameMaxAmount]);
         }
      }
      
      private function updateSlots() : void
      {
         var _loc1_:int = 0;
         var _loc3_:* = null;
         var slotCounter:int = 0;
         var i:int = 0;
         if(_league.playedGames < _tournament.requiredPlacementForLeague)
         {
            _qualification.visible = true;
            _loc1_ = _tournament.requiredPlacementForLeague - _league.playedGames;
            _loc3_ = _loc1_ > 1 ? "TOURNAMENT_QUALIFICATION_MULTIPLE_GAMES" : "TOURNAMENT_QUALIFICATION_ONE_GAME";
            _qualificationText.text = ProjectManager.getText(_loc3_,[_loc1_]);
         }
         else if(_league.status == 0 || _league.status == 10)
         {
            _qualification.visible = true;
            _qualificationText.text = ProjectManager.getText("TOURNAMENT_NOT_ENOUGH_PLAYERS");
         }
         else
         {
            myPositionChange = myPositionChange < -5 ? -5 : myPositionChange;
            myPositionChange = myPositionChange > 5 ? 5 : myPositionChange;
            slotCounter = 0;
            i = cursorPos;
            while(slotCounter < 5 && i < _league.getPlayers().length)
            {
               _leagueSlots[slotCounter].setPlayer(_league.getPlayers()[i],_tournament,i);
               if(i == myIndex)
               {
                  if(myPositionChange > 0)
                  {
                     new UITransition(_leagueSlots[slotCounter].getDesignMovieClip(),UIUtils.getTransition("transition_tournament_" + myPositionChange + "_down"),true,true,false);
                  }
                  else if(myPositionChange < 0)
                  {
                     new UITransition(_leagueSlots[slotCounter].getDesignMovieClip(),UIUtils.getTransition("transition_tournament_" + Math.abs(myPositionChange) + "_up"),true,true,false);
                  }
               }
               else if(i < myIndex && i >= myIndex - myPositionChange)
               {
                  new UITransition(_leagueSlots[slotCounter].getDesignMovieClip(),UIUtils.getTransition("transition_tournament_1_up"),true,true,false);
               }
               else if(i > myIndex && i <= myIndex - myPositionChange)
               {
                  new UITransition(_leagueSlots[slotCounter].getDesignMovieClip(),UIUtils.getTransition("transition_tournament_1_down"),true,true,false);
               }
               slotCounter++;
               i++;
            }
         }
         updateScrollStates();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         var _loc2_:* = null;
         super.logicUpdate(deltaTime);
         if(_tournament)
         {
            _tournament.updateTournamentTime(deltaTime);
            leagueTimeValueText.text = TextUtils.getTournamentTimeTextFromSeconds(_tournament.getTournamentTimeInSeconds());
            if(_tournament.isTournamentOver() || _league.isLeagueFinished())
            {
               _loc2_ = _game;
               close(new TournamentEndState(_loc2_));
            }
         }
      }
      
      private function playCallback(event:MouseEvent) : void
      {
         LogUtils.clearAll();
         CRMService.sendEvent("Game","Menu","Clicked","TournamentPlay",_league.id);
         var _loc2_:Object = {};
         _loc2_["tournament"] = true;
         _game.homeState.changeState(new TournamentMatchLoadingSubState(_game,new ServerRequest("PlayNow",_loc2_)));
         TooltipManager.removeTooltip();
      }
      
      private function scrollUp(event:MouseEvent) : void
      {
         cursorPos = Math.max(cursorPos - 1,0);
         updateSlots();
      }
      
      private function scrollDown(event:MouseEvent) : void
      {
         cursorPos = Math.min(cursorPos + 1,_league.getPlayers().length - 1);
         updateSlots();
      }
      
      private function closeCallback(event:MouseEvent) : void
      {
         super.close();
      }
      
      private function helpCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","TournamentHelp");
         tournamentLogic.state.changeState(new HelpState(_game,"Help_8"));
         trace(1);
      }
      
      private function updateScrollStates() : void
      {
         if(!_league || _league.playedGames < _tournament.requiredPlacementForLeague)
         {
            _scrollUpButton.setEnabled(false);
            _scrollRightButton.setEnabled(false);
         }
         else if(_league.status == 0 || _league.status == 10)
         {
            _scrollUpButton.setEnabled(false);
            _scrollRightButton.setEnabled(false);
         }
         else
         {
            _scrollUpButton.setEnabled(cursorPos > 0);
            _scrollRightButton.setEnabled(cursorPos + 5 < _league.getPlayers().length);
         }
      }
      
      private function get tournamentLogic() : TournamentLogic
      {
         return logic;
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         _playButton.dispose();
         _playButton = null;
         _closeButton.dispose();
         _closeButton = null;
         _helpButton.dispose();
         _helpButton = null;
         _scrollUpButton.dispose();
         _scrollUpButton = null;
         _scrollRightButton.dispose();
         _scrollRightButton = null;
      }
   }
}
