package tuxwars.home.ui.screen.home
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.Challenges;
   import tuxwars.data.challenges.ChallengesData;
   import tuxwars.home.states.challenge.ChallengeState;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.net.CRMService;
   import tuxwars.states.tutorial.TuxTutorialSubState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.components.IconButton;
   import tuxwars.ui.tooltips.ChallengeTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class ChallengeElementScreen extends TuxUIElementScreen
   {
      
      private static const BUTTON_CHALLENGES:String = "Button_Challenge_";
      
      private static const DEFAULT_BUTTON:String = "Challenge_Default";
      
      private static const NEW_BUTTON:String = "Challenge_New";
      
      private static const COMPLETED_BUTTON:String = "Challenge_Done";
      
      private static const NUM_BUTTONS:int = 4;
      
      private static const ELEMENT_MAP:Object = {};
      
      {
         ELEMENT_MAP["Battle"] = 0;
         ELEMENT_MAP["Grind"] = 1;
         ELEMENT_MAP["Skill"] = 2;
         ELEMENT_MAP["Impossible"] = 3;
      }
      
      private const challengeButtons:Vector.<IconButton> = new Vector.<IconButton>();
      
      public function ChallengeElementScreen(design:MovieClip, game:TuxWarsGame)
      {
         super(design,game);
         createButtons();
         setActiveChallenges();
         MessageCenter.addListener("ChallengesUpdated",setActiveChallenges);
      }
      
      public function setActiveChallenges(msg:Message = null) : void
      {
         var j:int = 0;
         var numChallenges:int = 0;
         var i:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         for(j = 0; j < 4; )
         {
            challengeButtons[j].setEnabled(false);
            j++;
         }
         var _loc8_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         var _loc2_:Challenges = tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(game.player.id);
         if(_loc2_)
         {
            for(i = 0; i < _loc2_.activeChallenges.length; )
            {
               _loc3_ = _loc2_.activeChallenges[i];
               _loc4_ = challengeButtons[ELEMENT_MAP[_loc3_.type]];
               _loc4_.setParameter(_loc3_);
               _loc4_.setIcon(_loc3_.icon);
               _loc4_.setEnabled(true);
               i++;
            }
            numChallenges = _loc2_.activeChallenges.length;
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ChallengesUpdated",setActiveChallenges);
         for each(var button in challengeButtons)
         {
            button.dispose();
         }
         challengeButtons.splice(0,challengeButtons.length);
         super.dispose();
      }
      
      private function createButtons() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:* = null;
         for(i = 0; i < 4; )
         {
            _loc1_ = getDesignMovieClip().getChildByName("Button_Challenge_" + (i + 1)) as MovieClip;
            _loc3_ = TuxUiUtils.createButton(IconButton,_loc1_,"Challenge_Default");
            _loc3_.addEventListener("clicked",challengesHandler,false,0,true);
            _loc3_.addEventListener("out",mouseOut,false,0,true);
            _loc3_.addEventListener("over",mouseOver,false,0,true);
            var _loc7_:Tutorial = Tutorial;
            if(tuxwars.tutorial.Tutorial._tutorial)
            {
               var _loc8_:Tutorial = Tutorial;
               _loc2_ = !(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart");
               _loc3_.setEnabled(_loc2_);
            }
            challengeButtons.push(_loc3_);
            _loc4_ = _loc1_.getChildByName("Challenge_New") as MovieClip;
            _loc4_.visible = false;
            DCUtils.stopMovieClip(_loc4_);
            _loc5_ = _loc1_.getChildByName("Challenge_Done") as MovieClip;
            if(_loc5_)
            {
               _loc5_.visible = false;
               DCUtils.stopMovieClip(_loc5_);
            }
            i++;
         }
      }
      
      public function setEnabledChallengeButtons(value:Boolean) : void
      {
         for each(var button in challengeButtons)
         {
            button.setEnabled(value);
         }
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         if(event.getParameter())
         {
            TooltipManager.showTooltip(new ChallengeTooltip(false,ChallengesData.getChallengeData(event.getParameter().id)),event.getButton().getDesignMovieClip(),1,1);
         }
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      private function challengesHandler(event:UIButtonEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || tuxwars.tutorial.Tutorial._tutorial)
         {
            CRMService.sendEvent("Game","Menu","Clicked","Challenges");
            game.homeState.changeState(new ChallengeState(game));
         }
      }
   }
}
