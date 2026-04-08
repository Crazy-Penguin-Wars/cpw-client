package tuxwars.home.ui.screen.tournament
{
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.ui.transitions.*;
   import com.dchoc.ui.utils.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.*;
   import tuxwars.home.states.help.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.states.tournament.*;
   import tuxwars.home.ui.logic.tournament.TournamentLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.items.TournamentRewardItem;
   import tuxwars.net.*;
   import tuxwars.tournament.League;
   import tuxwars.tournament.Tournament;
   import tuxwars.tournament.TournamentPlayer;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
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
      
      public function TournamentScreen(param1:TuxWarsGame)
      {
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/tournament.swf","tournament_list");
         super(param1,_loc2_);
         this._playButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Play",this.playCallback);
         this._playButton.setText(ProjectManager.getText("BUTTON_PLAY"));
         this._playButton.setVisible(false);
         this._closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",this.closeCallback);
         this._helpButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Help",this.helpCallback);
         this._helpButton.setText(ProjectManager.getText("BUTTON_HELP"));
         this.headerText.setTextField(_loc2_.Text_Header);
         this.headerText.setText("");
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this._trofies = (this._design as MovieClip).getChildByName("Trofies") as MovieClip;
         this._trofies.visible = false;
         this.leagueNameText = MovieClip(this._design).getChildByName("Text_League") as TextField;
         this.leagueNameText.text = "";
         this.leagueTimeText = MovieClip(this._design).getChildByName("Text_Time") as TextField;
         this.leagueTimeText.text = ProjectManager.getText("TOURNAMENT_TIME_LEFT");
         this.leagueTimeValueText = MovieClip(this._design).getChildByName("Text_Time_Value") as TextField;
         this.leagueTimeValueText.text = "";
         this.leagueGamesText = MovieClip(this._design).getChildByName("Text_Games") as TextField;
         this.leagueGamesText.text = ProjectManager.getText("TOURNAMENT_GAMES");
         this.leagueGamesValueText = MovieClip(this._design).getChildByName("Text_Games_Value") as TextField;
         this.leagueGamesValueText.text = "";
         this.leaguePointsText = MovieClip(this._design).getChildByName("Text_Points") as TextField;
         this.leaguePointsText.text = ProjectManager.getText("TOURNAMENT_POINTS");
         this.leaguePointsValueText = MovieClip(this._design).getChildByName("Text_Points_Value") as TextField;
         this.leaguePointsValueText.text = "";
         this.leagueRewardsText = MovieClip(this._design).getChildByName("Text_Rewards") as TextField;
         this.leagueRewardsText.text = ProjectManager.getText("TOURNAMENT_REWARDS");
         this.leagueRewards = MovieClip(this._design).getChildByName("Container_Rewards") as MovieClip;
         (this.leagueRewards.getChildByName("Container_Items_1") as MovieClip).visible = false;
         (this.leagueRewards.getChildByName("Container_Items_2") as MovieClip).visible = false;
         (this.leagueRewards.getChildByName("Container_Items_3") as MovieClip).visible = false;
         (this.leagueRewards.getChildByName("Container_Items_4") as MovieClip).visible = false;
         this.textWait = MovieClip(this._design).getChildByName("Text_Wait") as TextField;
         this.textWait.text = "";
         this.textWait.visible = false;
         this.rewardSlots = new Vector.<TournamentRewardSlot>();
         this.initLeagueSlots();
         this.initTournamentInfo();
      }
      
      private function initLeagueSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this._leagueSlots = new Vector.<LeagueSlot>();
         var _loc3_:MovieClip = (this._design as MovieClip).getChildByName("League_Slots") as MovieClip;
         var _loc4_:MovieClip = _loc3_.getChildByName("Container_Slots") as MovieClip;
         this._scrollUpButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Scroll_Left",this.scrollUp);
         this._scrollRightButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Scroll_Right",this.scrollDown);
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = _loc4_.getChildByName("Slot_0" + _loc1_) as MovieClip;
            this._leagueSlots.push(new LeagueSlot(_loc2_));
            _loc1_++;
         }
         _loc2_ = _loc4_.getChildByName("Slot_Top") as MovieClip;
         this._topSlot = new LeagueSlot(_loc2_);
         _loc2_ = _loc4_.getChildByName("Slot_Bottom") as MovieClip;
         this._bottomSlot = new LeagueSlot(_loc2_);
         this._qualification = (this._design as MovieClip).getChildByName("qualification") as MovieClip;
         this._qualification.visible = false;
         this._qualificationText = this._qualification.getChildByName("Text") as TextField;
         this._qualificationText.text = "";
         this.updateScrollStates();
      }
      
      private function initTournamentInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TournamentRewardItem = null;
         var _loc6_:int = 0;
         if(!_game.player.tournament || !_game.player.tournament.league)
         {
            this._qualification.visible = true;
            this._qualificationText.text = ProjectManager.getText("TOURNAMENT_NO_ACTIVE_TOURNAMENT");
            return;
         }
         this._tournament = _game.player.tournament;
         this._league = this._tournament.league;
         this.myIndex = this._league.findMyIndex();
         this.myPlayer = this._league.getPlayers()[this.myIndex];
         if(this.myPlayer.previous_rank > 0)
         {
            this.myPositionChange = this.myPlayer.rank - this.myPlayer.previous_rank;
         }
         else
         {
            this.myPositionChange = 0;
         }
         this.headerText.setText(this._tournament.name);
         this._trofies.visible = true;
         _loc1_ = 0;
         while(_loc1_ < this._trofies.numChildren)
         {
            this._trofies.getChildAt(_loc1_).visible = this._trofies.getChildAt(_loc1_).name == this._league.trophyGraphic;
            _loc1_++;
         }
         this.leagueNameText.text = this._league.name;
         this.leagueGamesValueText.text = this._league.playedGames + "/" + this._tournament.gameMaxAmount;
         this.leaguePointsValueText.text = "" + this._league.points;
         var _loc7_:int = int(this._league.getPositionRewardsAmount());
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            _loc2_ = this.leagueRewards.getChildByName("Container_Items_" + _loc1_) as MovieClip;
            if(_loc1_ == _loc7_)
            {
               _loc2_.visible = true;
               _loc3_ = 1;
               while(_loc3_ <= _loc7_)
               {
                  _loc4_ = _loc2_.getChildByName("Slot_0" + _loc3_) as MovieClip;
                  _loc5_ = this._league.getPositionReward(_loc3_);
                  this.rewardSlots.push(new TournamentRewardSlot(_loc4_,_game,_loc5_,_loc3_,this,true));
                  _loc3_++;
               }
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         if(this._league.getPlayers().length > 5)
         {
            _loc6_ = this.myIndex - 2;
            while(_loc6_ < 0)
            {
               _loc6_++;
            }
            while(_loc6_ + 5 > this._league.getPlayers().length)
            {
               _loc6_--;
            }
            this.cursorPos = _loc6_;
         }
         else
         {
            this.cursorPos = 0;
         }
         this.updateSlots();
         this.myPositionChange = 0;
         if(this._league.playedGames < this._tournament.gameMaxAmount)
         {
            if(this._tournament.getTournamentTimeInSeconds() / 60 > BattleOptions.getMatchTime())
            {
               this._playButton.setVisible(true);
               this.textWait.visible = false;
            }
            else
            {
               this._playButton.setVisible(false);
               this.textWait.visible = true;
               this.textWait.text = ProjectManager.getText("TOURNAMENT_NO_TIME_LEFT");
            }
         }
         else
         {
            this._playButton.setVisible(false);
            this.textWait.visible = true;
            this.textWait.text = ProjectManager.getText("TOURNAMENT_GAMES_PLAYED",[this._tournament.gameMaxAmount]);
         }
      }
      
      private function updateSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._league.playedGames < this._tournament.requiredPlacementForLeague)
         {
            this._qualification.visible = true;
            _loc1_ = this._tournament.requiredPlacementForLeague - this._league.playedGames;
            _loc2_ = _loc1_ > 1 ? "TOURNAMENT_QUALIFICATION_MULTIPLE_GAMES" : "TOURNAMENT_QUALIFICATION_ONE_GAME";
            this._qualificationText.text = ProjectManager.getText(_loc2_,[_loc1_]);
         }
         else if(this._league.status == 0 || this._league.status == 10)
         {
            this._qualification.visible = true;
            this._qualificationText.text = ProjectManager.getText("TOURNAMENT_NOT_ENOUGH_PLAYERS");
         }
         else
         {
            this.myPositionChange = this.myPositionChange < -5 ? -5 : int(this.myPositionChange);
            this.myPositionChange = this.myPositionChange > 5 ? 5 : int(this.myPositionChange);
            _loc3_ = 0;
            _loc4_ = int(this.cursorPos);
            while(_loc3_ < 5 && _loc4_ < this._league.getPlayers().length)
            {
               this._leagueSlots[_loc3_].setPlayer(this._league.getPlayers()[_loc4_],this._tournament,_loc4_);
               if(_loc4_ == this.myIndex)
               {
                  if(this.myPositionChange > 0)
                  {
                     new UITransition(this._leagueSlots[_loc3_].getDesignMovieClip(),UIUtils.getTransition("transition_tournament_" + this.myPositionChange + "_down"),true,true,false);
                  }
                  else if(this.myPositionChange < 0)
                  {
                     new UITransition(this._leagueSlots[_loc3_].getDesignMovieClip(),UIUtils.getTransition("transition_tournament_" + Math.abs(this.myPositionChange) + "_up"),true,true,false);
                  }
               }
               else if(_loc4_ < this.myIndex && _loc4_ >= this.myIndex - this.myPositionChange)
               {
                  new UITransition(this._leagueSlots[_loc3_].getDesignMovieClip(),UIUtils.getTransition("transition_tournament_1_up"),true,true,false);
               }
               else if(_loc4_ > this.myIndex && _loc4_ <= this.myIndex - this.myPositionChange)
               {
                  new UITransition(this._leagueSlots[_loc3_].getDesignMovieClip(),UIUtils.getTransition("transition_tournament_1_down"),true,true,false);
               }
               _loc3_++;
               _loc4_++;
            }
         }
         this.updateScrollStates();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc2_:TuxWarsGame = null;
         super.logicUpdate(param1);
         if(this._tournament)
         {
            this._tournament.updateTournamentTime(param1);
            this.leagueTimeValueText.text = TextUtils.getTournamentTimeTextFromSeconds(this._tournament.getTournamentTimeInSeconds());
            if(Boolean(this._tournament.isTournamentOver()) || Boolean(this._league.isLeagueFinished()))
            {
               _loc2_ = _game;
               close(new TournamentEndState(_loc2_));
            }
         }
      }
      
      private function playCallback(param1:MouseEvent) : void
      {
         LogUtils.clearAll();
         CRMService.sendEvent("Game","Menu","Clicked","TournamentPlay",this._league.id);
         var _loc2_:Object = {};
         _loc2_["tournament"] = true;
         _game.homeState.changeState(new TournamentMatchLoadingSubState(_game,new ServerRequest("PlayNow",_loc2_)));
         TooltipManager.removeTooltip();
      }
      
      private function scrollUp(param1:MouseEvent) : void
      {
         this.cursorPos = Math.max(this.cursorPos - 1,0);
         this.updateSlots();
      }
      
      private function scrollDown(param1:MouseEvent) : void
      {
         this.cursorPos = Math.min(this.cursorPos + 1,this._league.getPlayers().length - 1);
         this.updateSlots();
      }
      
      private function closeCallback(param1:MouseEvent) : void
      {
         super.close();
      }
      
      private function helpCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","TournamentHelp");
         this.tournamentLogic.state.changeState(new HelpState(_game,"Help_8"));
         trace(1);
      }
      
      private function updateScrollStates() : void
      {
         if(!this._league || this._league.playedGames < this._tournament.requiredPlacementForLeague)
         {
            this._scrollUpButton.setEnabled(false);
            this._scrollRightButton.setEnabled(false);
         }
         else if(this._league.status == 0 || this._league.status == 10)
         {
            this._scrollUpButton.setEnabled(false);
            this._scrollRightButton.setEnabled(false);
         }
         else
         {
            this._scrollUpButton.setEnabled(this.cursorPos > 0);
            this._scrollRightButton.setEnabled(this.cursorPos + 5 < this._league.getPlayers().length);
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
         this._playButton.dispose();
         this._playButton = null;
         this._closeButton.dispose();
         this._closeButton = null;
         this._helpButton.dispose();
         this._helpButton = null;
         this._scrollUpButton.dispose();
         this._scrollUpButton = null;
         this._scrollRightButton.dispose();
         this._scrollRightButton = null;
      }
   }
}

