package tuxwars.battle.ui.screen
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.Challenges;
   import tuxwars.data.challenges.ChallengesData;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.components.IconButton;
   import tuxwars.ui.tooltips.ChallengeTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class BattleHudChallengesElement extends TuxUIElementScreen
   {
      
      private static const CHALLENGES_CONTAINER:String = "Container_Challenges";
      
      private static const CHALLENGE:String = "Button_Challenge_";
      
      private static const DEFAULT_BUTTON:String = "Challenge_Default";
      
      private static const NEW_BUTTON:String = "Challenge_New";
      
      private static const COMPLETED_BUTTON:String = "Challenge_Done";
      
      private static const NUMBER_OF_CHALLENGES:int = 4;
      
      private static const ELEMENT_MAP:Object = {};
      
      {
         ELEMENT_MAP["Battle"] = 0;
         ELEMENT_MAP["Grind"] = 1;
         ELEMENT_MAP["Skill"] = 2;
         ELEMENT_MAP["Impossible"] = 3;
      }
      
      private const challengeButtonsDefault:Vector.<IconButton> = new Vector.<IconButton>();
      
      private const challengeButtonsCompleted:Vector.<IconButton> = new Vector.<IconButton>();
      
      public function BattleHudChallengesElement(from:MovieClip, game:TuxWarsGame)
      {
         var numChallenges:int = 0;
         var i:int = 0;
         var _loc4_:* = null;
         var button:* = null;
         super(from.getChildByName("Container_Challenges") as MovieClip,game);
         this._design.mouseChildren = true;
         this._design.mouseEnabled = true;
         createButtons();
         var _loc8_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         var _loc3_:Challenges = tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(game.player.id);
         if(_loc3_)
         {
            for(i = 0; i < _loc3_.activeChallenges.length; )
            {
               _loc4_ = _loc3_.activeChallenges[i];
               button = challengeButtonsDefault[ELEMENT_MAP[_loc4_.type]];
               button.setParameter(_loc4_);
               button.setIcon(_loc4_.icon);
               button.setEnabled(true);
               button.setVisible(true);
               button = challengeButtonsCompleted[ELEMENT_MAP[_loc4_.type]];
               button.setParameter(_loc4_);
               button.setIcon(_loc4_.icon);
               button.setEnabled(false);
               button.setVisible(false);
               i++;
            }
            numChallenges = _loc3_.activeChallenges.length;
         }
         MessageCenter.addListener("ChallengeStateChanged",updateChallenges);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ChallengeStateChanged",updateChallenges);
         for each(var iconButton in challengeButtonsDefault)
         {
            iconButton.dispose();
         }
         challengeButtonsDefault.slice(0,challengeButtonsDefault.length);
         for each(iconButton in challengeButtonsCompleted)
         {
            iconButton.dispose();
         }
         challengeButtonsCompleted.slice(0,challengeButtonsCompleted.length);
         super.dispose();
      }
      
      private function createButtons() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         var button:* = null;
         var _loc3_:* = null;
         for(i = 0; i < 4; )
         {
            _loc1_ = getButtonContainer(i);
            button = TuxUiUtils.createButton(IconButton,_loc1_,"Challenge_Default");
            button.setEnabled(false);
            button.setVisible(false);
            button.addEventListener("out",mouseOut,false,0,true);
            button.addEventListener("over",mouseOver,false,0,true);
            challengeButtonsDefault.push(button);
            _loc3_ = _loc1_.getChildByName("Challenge_New") as MovieClip;
            _loc3_.visible = false;
            DCUtils.stopMovieClip(_loc3_);
            button = TuxUiUtils.createButton(IconButton,_loc1_,"Challenge_Done");
            button.setEnabled(false);
            button.setVisible(false);
            button.addEventListener("out",mouseOut,false,0,true);
            button.addEventListener("over",mouseOver,false,0,true);
            challengeButtonsCompleted.push(button);
            i++;
         }
      }
      
      private function getButtonContainer(ndx:int) : MovieClip
      {
         return getDesignMovieClip().getChildByName("Button_Challenge_" + (ndx + 1)) as MovieClip;
      }
      
      private function updateChallenges(msg:Message) : void
      {
         var _loc4_:* = null;
         var i:int = 0;
         var _loc5_:* = null;
         var buttonIndex:int = 0;
         var _loc2_:* = null;
         var completedButtonMC:* = null;
         var defaultButtonMC:* = null;
         if((msg.data as Challenge).playerId == game.player.id)
         {
            var _loc9_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            _loc4_ = tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(game.player.id);
            if(_loc4_)
            {
               for(i = 0; i < _loc4_.activeChallenges.length; )
               {
                  _loc5_ = _loc4_.activeChallenges[i];
                  if(_loc5_.id == (msg.data as Challenge).id)
                  {
                     buttonIndex = int(ELEMENT_MAP[_loc5_.type]);
                     _loc2_ = getButtonContainer(buttonIndex);
                     if((msg.data as Challenge).areCountersCompleted())
                     {
                        if(challengeButtonsDefault[buttonIndex].getVisible() && !challengeButtonsCompleted[buttonIndex].getVisible())
                        {
                           challengeButtonsDefault[buttonIndex].setEnabled(false);
                           challengeButtonsDefault[buttonIndex].setVisible(false);
                           challengeButtonsCompleted[buttonIndex].setEnabled(true);
                           challengeButtonsCompleted[buttonIndex].setVisible(true);
                           completedButtonMC = _loc2_.getChildByName("Challenge_Done") as MovieClip;
                           DCUtils.playMovieClip(completedButtonMC);
                           completedButtonMC.visible = true;
                        }
                     }
                     else if(!challengeButtonsDefault[buttonIndex].getVisible() && challengeButtonsCompleted[buttonIndex].getVisible())
                     {
                        challengeButtonsDefault[buttonIndex].setEnabled(true);
                        challengeButtonsDefault[buttonIndex].setVisible(true);
                        challengeButtonsCompleted[buttonIndex].setEnabled(false);
                        challengeButtonsCompleted[buttonIndex].setVisible(false);
                        defaultButtonMC = _loc2_.getChildByName("Challenge_Default") as MovieClip;
                        defaultButtonMC.visible = true;
                     }
                  }
                  i++;
               }
            }
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
   }
}
