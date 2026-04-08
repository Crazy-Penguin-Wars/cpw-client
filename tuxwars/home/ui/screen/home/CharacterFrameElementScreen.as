package tuxwars.home.ui.screen.home
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.customgame.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.states.tournament.*;
   import tuxwars.net.*;
   import tuxwars.tournament.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class CharacterFrameElementScreen extends CharacterAvatarElementScreen
   {
      private static const CHARACTER_FRAME:String = "Character_Frame";
      
      private static const BUTTON_PLAY:String = "Button_Play";
      
      private static const BUTTON_PLAY_TOURNAMENT:String = "Button_Tournament";
      
      private static const BUTTON_PLAY_CUSTOM_GAME:String = "Button_Custom_Game";
      
      private var _play:UIButton;
      
      private var _playTournament:UIButton;
      
      private var _playCustom:UIButton;
      
      public function CharacterFrameElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc9_:UIButton = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         DCUtils.stopMovieClip(_loc4_);
         var _loc5_:MovieClip = _loc4_.getChildByName("Character_Frame") as MovieClip;
         super(_loc5_,param2);
         DCUtils.playMovieClip(_loc5_);
         var _loc6_:MovieClip = _loc4_.getChildByName("Container_Play_Buttons") as MovieClip;
         if(param2.player.isTournamentAvailable())
         {
            _loc3_ = _loc6_.getChildByName("Play_Tournament") as MovieClip;
            this._playTournament = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Tournament",this.tournamentHandler,"BUTTON_TOURNAMENT","TOOLTIP_TOURNAMENT");
            this._playTournament.addEventListener("out",this.mouseOut,false,0,true);
            this._playTournament.addEventListener("over",this.mouseOver,false,0,true);
            DCUtils.playMovieClip((this._playTournament as UIButton).getDesignMovieClip());
            this._playTournament.setState("Down");
            this._playTournament.setState("Visible");
            if(param2.player.tournament.status == 30)
            {
               this.enableTournamentButton(false);
            }
         }
         else
         {
            _loc3_ = _loc6_.getChildByName("Play_No_Tournament") as MovieClip;
         }
         this._play = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Play",this.playHandler,"BUTTON_PLAY","TOOLTIP_PLAY");
         this._playCustom = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Custom_Game",this.customGameHandler,"BUTTON_CUSTOM_GAME","TOOLTIP_CUSTOM");
         this._play.addEventListener("out",this.mouseOut,false,0,true);
         this._play.addEventListener("over",this.mouseOver,false,0,true);
         this._playCustom.addEventListener("out",this.mouseOut,false,0,true);
         this._playCustom.addEventListener("over",this.mouseOver,false,0,true);
         param1.addChild(avatarContainer);
         var _loc7_:UIButton = this._play;
         param1.addChild(_loc7_._design);
         var _loc8_:UIButton = this._playCustom;
         param1.addChild(_loc8_._design);
         if(this._playTournament)
         {
            _loc9_ = this._playTournament;
            param1.addChild(_loc9_._design);
         }
      }
      
      override public function dispose() : void
      {
         this._play.dispose();
         this._play = null;
         if(this._playTournament)
         {
            this._playTournament.dispose();
         }
         this._playTournament = null;
         this._playCustom.dispose();
         this._playCustom = null;
         MessageCenter.removeListener("UpdateTournamentScreen",this.tournamentHandlerCallback);
         super.dispose();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
      }
      
      public function get playButton() : UIButton
      {
         return this._play;
      }
      
      public function enableTournamentButton(param1:Boolean) : void
      {
         if(!this._playTournament)
         {
            return;
         }
         if(game.player.tournament.status == 30)
         {
            this._playTournament.setEnabled(false);
            this._playTournament.setText(ProjectManager.getText("TOURNAMENT_PROCESSING"));
         }
         else
         {
            this._playTournament.setEnabled(param1);
            this._playTournament.setText(ProjectManager.getText("BUTTON_TOURNAMENT"));
         }
      }
      
      public function get playCustom() : UIButton
      {
         return this._playCustom;
      }
      
      private function playHandler(param1:MouseEvent) : void
      {
         this._play.setEnabled(false);
         this.enableTournamentButton(false);
         LogUtils.clearAll();
         if(Boolean(Tutorial._tutorial) && Tutorial._tutorialStep == "TutorialCustomizationDone")
         {
            this._play.setEnabled(true);
            CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","PressPlay","PressPlay");
            game.homeState.changeState(new PracticeMatchLoadingSubState(game));
         }
         else
         {
            CRMService.sendEvent("Game","Menu","Clicked","Play");
            game.homeState.changeState(new MultiplayerMatchLoadingSubState(game,new ServerRequest("PlayNow")));
         }
         TooltipManager.removeTooltip();
      }
      
      private function tournamentHandler(param1:MouseEvent) : void
      {
         this._play.setEnabled(false);
         this.enableTournamentButton(false);
         MessageCenter.addListener("UpdateTournamentScreen",this.tournamentHandlerCallback);
         TournamentManager.triggerContentUpdate(true,true,true);
         CRMService.sendEvent("Game","Menu","Clicked","Tournament_Game");
         TooltipManager.removeTooltip();
      }
      
      private function tournamentHandlerCallback(param1:Message) : void
      {
         MessageCenter.removeListener("UpdateTournamentScreen",this.tournamentHandlerCallback);
         if(game.player.isTournamentFinished())
         {
            game.homeState.changeState(new TournamentEndState(game));
         }
         else
         {
            game.homeState.changeState(new TournamentState(game));
         }
      }
      
      private function customGameHandler(param1:MouseEvent) : void
      {
         LogUtils.clearAll();
         CRMService.sendEvent("Game","Menu","Clicked","Custom_Game");
         game.homeState.changeState(new CustomGameState(game));
         TooltipManager.removeTooltip();
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

