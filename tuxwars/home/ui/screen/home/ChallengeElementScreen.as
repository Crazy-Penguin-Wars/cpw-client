package tuxwars.home.ui.screen.home
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.*;
   import tuxwars.data.challenges.*;
   import tuxwars.home.states.challenge.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.net.*;
   import tuxwars.states.tutorial.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class ChallengeElementScreen extends TuxUIElementScreen
   {
      private static const BUTTON_CHALLENGES:String = "Button_Challenge_";
      
      private static const DEFAULT_BUTTON:String = "Challenge_Default";
      
      private static const NEW_BUTTON:String = "Challenge_New";
      
      private static const COMPLETED_BUTTON:String = "Challenge_Done";
      
      private static const NUM_BUTTONS:int = 4;
      
      private static const ELEMENT_MAP:Object = {};
      
      ELEMENT_MAP["Battle"] = 0;
      ELEMENT_MAP["Grind"] = 1;
      ELEMENT_MAP["Skill"] = 2;
      ELEMENT_MAP["Impossible"] = 3;
      
      private const challengeButtons:Vector.<IconButton> = new Vector.<IconButton>();
      
      public function ChallengeElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this.createButtons();
         this.setActiveChallenges();
         MessageCenter.addListener("ChallengesUpdated",this.setActiveChallenges);
      }
      
      public function setActiveChallenges(param1:Message = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Challenge = null;
         var _loc6_:IconButton = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            this.challengeButtons[_loc2_].setEnabled(false);
            _loc2_++;
         }
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         var _loc7_:Challenges = ChallengeManager.instance.getPlayerChallenges(game.player.id);
         if(_loc7_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc7_.activeChallenges.length)
            {
               _loc5_ = _loc7_.activeChallenges[_loc4_];
               _loc6_ = this.challengeButtons[ELEMENT_MAP[_loc5_.type]];
               _loc6_.setParameter(_loc5_);
               _loc6_.setIcon(_loc5_.icon);
               _loc6_.setEnabled(true);
               _loc4_++;
            }
            _loc3_ = int(_loc7_.activeChallenges.length);
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         MessageCenter.removeListener("ChallengesUpdated",this.setActiveChallenges);
         for each(_loc1_ in this.challengeButtons)
         {
            _loc1_.dispose();
         }
         this.challengeButtons.splice(0,this.challengeButtons.length);
         super.dispose();
      }
      
      private function createButtons() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:IconButton = null;
         var _loc4_:* = false;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = getDesignMovieClip().getChildByName("Button_Challenge_" + (_loc1_ + 1)) as MovieClip;
            _loc3_ = TuxUiUtils.createButton(IconButton,_loc2_,"Challenge_Default");
            _loc3_.addEventListener("clicked",this.challengesHandler,false,0,true);
            _loc3_.addEventListener("out",this.mouseOut,false,0,true);
            _loc3_.addEventListener("over",this.mouseOver,false,0,true);
            if(Tutorial._tutorial)
            {
               _loc4_ = !(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart");
               _loc3_.setEnabled(_loc4_);
            }
            this.challengeButtons.push(_loc3_);
            _loc5_ = _loc2_.getChildByName("Challenge_New") as MovieClip;
            _loc5_.visible = false;
            DCUtils.stopMovieClip(_loc5_);
            _loc6_ = _loc2_.getChildByName("Challenge_Done") as MovieClip;
            if(_loc6_)
            {
               _loc6_.visible = false;
               DCUtils.stopMovieClip(_loc6_);
            }
            _loc1_++;
         }
      }
      
      public function setEnabledChallengeButtons(param1:Boolean) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.challengeButtons)
         {
            _loc2_.setEnabled(param1);
         }
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         if(param1.getParameter())
         {
            TooltipManager.showTooltip(new ChallengeTooltip(false,ChallengesData.getChallengeData(param1.getParameter().id)),param1.getButton().getDesignMovieClip(),1,1);
         }
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      private function challengesHandler(param1:UIButtonEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || Boolean(Tutorial._tutorial))
         {
            CRMService.sendEvent("Game","Menu","Clicked","Challenges");
            game.homeState.changeState(new ChallengeState(game));
         }
      }
   }
}

