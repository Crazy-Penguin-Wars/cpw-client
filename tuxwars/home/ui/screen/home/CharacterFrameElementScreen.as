package tuxwars.home.ui.screen.home
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.customgame.CustomGameState;
   import tuxwars.home.states.matchloading.MultiplayerMatchLoadingSubState;
   import tuxwars.home.states.matchloading.PracticeMatchLoadingSubState;
   import tuxwars.home.states.tournament.TournamentEndState;
   import tuxwars.home.states.tournament.TournamentState;
   import tuxwars.net.CRMService;
   import tuxwars.tournament.TournamentManager;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class CharacterFrameElementScreen extends CharacterAvatarElementScreen
   {
      private static const CHARACTER_FRAME:String = "Character_Frame";
      
      private static const BUTTON_PLAY:String = "Button_Play";
      
      private static const BUTTON_PLAY_TOURNAMENT:String = "Button_Tournament";
      
      private static const BUTTON_PLAY_CUSTOM_GAME:String = "Button_Custom_Game";
      
      private var _play:UIButton;
      
      private var _playTournament:UIButton;
      
      private var _playCustom:UIButton;
      
      public function CharacterFrameElementScreen(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         var playButtonDesing:MovieClip = null;
         var _loc6_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 1 works");
         DCUtils.stopMovieClip(_loc6_);
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 2 works");
         var _loc3_:MovieClip = _loc6_.getChildByName("Character_Frame") as MovieClip;
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 3 works");
         super(_loc3_,game);
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 4 works");
         DCUtils.playMovieClip(_loc3_);
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 5 works");
         var _loc4_:MovieClip = _loc6_.getChildByName("Container_Play_Buttons") as MovieClip;
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 6 works");
         if(game.player.isTournamentAvailable())
         {
            ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 7 works");
            playButtonDesing = _loc4_.getChildByName("Play_Tournament") as MovieClip;
            _playTournament = TuxUiUtils.createButton(UIButton,playButtonDesing,"Button_Tournament",tournamentHandler,"BUTTON_TOURNAMENT","TOOLTIP_TOURNAMENT");
            _playTournament.addEventListener("out",mouseOut,false,0,true);
            _playTournament.addEventListener("over",mouseOver,false,0,true);
            DCUtils.playMovieClip((_playTournament as UIButton).getDesignMovieClip());
            _playTournament.setState("Down");
            _playTournament.setState("Visible");
            if(game.player.tournament.status == 30)
            {
               enableTournamentButton(false);
            }
            ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 8 works");
         }
         else
         {
            ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 9 works");
            playButtonDesing = _loc4_.getChildByName("Play_No_Tournament") as MovieClip;
         }
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 10 works");
         _play = TuxUiUtils.createButton(UIButton,playButtonDesing,"Button_Play",playHandler,"BUTTON_PLAY","TOOLTIP_PLAY");
         _playCustom = TuxUiUtils.createButton(UIButton,playButtonDesing,"Button_Custom_Game",customGameHandler,"BUTTON_CUSTOM_GAME","TOOLTIP_CUSTOM");
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 11 works");
         _play.addEventListener("out",mouseOut,false,0,true);
         _play.addEventListener("over",mouseOver,false,0,true);
         _playCustom.addEventListener("out",mouseOut,false,0,true);
         _playCustom.addEventListener("over",mouseOver,false,0,true);
         whereToAdd.addChild(avatarContainer);
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 12 works");
         var _loc7_:UIButton = _play;
         whereToAdd.addChild(_loc7_._design);
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 13 works");
         var _loc8_:UIButton = _playCustom;
         whereToAdd.addChild(_loc8_._design);
         ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 14 works");
         if(_playTournament)
         {
            var _loc9_:UIButton = _playTournament;
            whereToAdd.addChild(_loc9_._design);
            ExternalInterface.call("console.log","[CharacterFrameElementScreen] Point 15 works");
         }
      }
      
      override public function dispose() : void
      {
         _play.dispose();
         _play = null;
         if(_playTournament)
         {
            _playTournament.dispose();
         }
         _playTournament = null;
         _playCustom.dispose();
         _playCustom = null;
         MessageCenter.removeListener("UpdateTournamentScreen",tournamentHandlerCallback);
         super.dispose();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
      }
      
      public function get playButton() : UIButton
      {
         return _play;
      }
      
      public function enableTournamentButton(enableIt:Boolean) : void
      {
         if(!_playTournament)
         {
            return;
         }
         if(game.player.tournament.status == 30)
         {
            _playTournament.setEnabled(false);
            _playTournament.setText(ProjectManager.getText("TOURNAMENT_PROCESSING"));
         }
         else
         {
            _playTournament.setEnabled(enableIt);
            _playTournament.setText(ProjectManager.getText("BUTTON_TOURNAMENT"));
         }
      }
      
      public function get playCustom() : UIButton
      {
         return _playCustom;
      }
      
      private function playHandler(event:MouseEvent) : void
      {
         _play.setEnabled(false);
         enableTournamentButton(false);
         LogUtils.clearAll();
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial && tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone")
         {
            _play.setEnabled(true);
            CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","PressPlay","PressPlay");
            game.homeState.changeState(new PracticeMatchLoadingSubState(game));
         }
         else
         {
            CRMService.sendEvent("Game","Menu","Clicked","Play");
            game.homeState.changeState(new MultiplayerMatchLoadingSubState(game,new ServerRequest("PlayNow")));
         }
         TooltipManager.removeTooltip();
      }
      
      private function tournamentHandler(event:MouseEvent) : void
      {
         _play.setEnabled(false);
         enableTournamentButton(false);
         MessageCenter.addListener("UpdateTournamentScreen",tournamentHandlerCallback);
         TournamentManager.triggerContentUpdate(true,true,true);
         CRMService.sendEvent("Game","Menu","Clicked","Tournament_Game");
         TooltipManager.removeTooltip();
      }
      
      private function tournamentHandlerCallback(msg:Message) : void
      {
         MessageCenter.removeListener("UpdateTournamentScreen",tournamentHandlerCallback);
         if(game.player.isTournamentFinished())
         {
            game.homeState.changeState(new TournamentEndState(game));
         }
         else
         {
            game.homeState.changeState(new TournamentState(game));
         }
      }
      
      private function customGameHandler(event:MouseEvent) : void
      {
         LogUtils.clearAll();
         CRMService.sendEvent("Game","Menu","Clicked","Custom_Game");
         game.homeState.changeState(new CustomGameState(game));
         TooltipManager.removeTooltip();
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

