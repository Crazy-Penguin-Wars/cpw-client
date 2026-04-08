package tuxwars.battle.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import tuxwars.battle.*;
   import tuxwars.battle.ui.states.*;
   import tuxwars.data.SoundReference;
   import tuxwars.states.TuxState;
   import tuxwars.states.tutorial.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   
   public class TuxBattleIdleSubState extends TuxState
   {
      private static const TIME_OF_SILENCE:int = 1000;
      
      private var startTime:int;
      
      private var locationArrowMessageSent:Boolean = false;
      
      private var messageSent:Boolean;
      
      private var endMusicFlag:Boolean;
      
      private var endTurnFlag:Boolean;
      
      private var sendHelpMoveCheck:Boolean = true;
      
      public function TuxBattleIdleSubState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         trace("Ducktape fix: merged this into TuxBattleState except for the practice popup");
         if(Tutorial._tutorial)
         {
            changeState(new TuxTutorialMoveSubState(tuxGame));
         }
         else if(BattleManager.isPracticeMode())
         {
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.addPopup(new PracticeMessagePopUpSubState(tuxGame));
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.showPopUps(this);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
      }
      
      private function setHelpMoveStatus(param1:Message) : void
      {
      }
      
      private function removeHelpMoveStatus(param1:Message) : void
      {
      }
      
      private function sendSoundMessage(param1:String, param2:SoundReference, param3:String) : void
      {
      }
   }
}

