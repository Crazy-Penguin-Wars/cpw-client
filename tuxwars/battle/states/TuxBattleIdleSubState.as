package tuxwars.battle.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.ui.states.PracticeMessagePopUpSubState;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.states.TuxState;
   import tuxwars.states.tutorial.TuxTutorialMoveSubState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   
   public class TuxBattleIdleSubState extends TuxState
   {
      
      private static const TIME_OF_SILENCE:int = 1000;
       
      
      private var startTime:int;
      
      private var locationArrowMessageSent:Boolean = false;
      
      private var messageSent:Boolean;
      
      private var endMusicFlag:Boolean;
      
      private var endTurnFlag:Boolean;
      
      private var sendHelpMoveCheck:Boolean = true;
      
      public function TuxBattleIdleSubState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         startTime = DCGame.getTime();
         var _loc1_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            changeState(new TuxTutorialMoveSubState(tuxGame));
         }
         else if(BattleManager.isPracticeMode())
         {
            var _loc2_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.addPopup(new PracticeMessagePopUpSubState(tuxGame));
            var _loc3_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.showPopUps(this);
         }
         MessageCenter.addListener("HelpHudStartMoveTimer",setHelpMoveStatus);
         MessageCenter.addListener("HelpHudCancelMoveTimer",removeHelpMoveStatus);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("HelpHudStartMoveTimer",setHelpMoveStatus);
         MessageCenter.removeListener("HelpHudCancelMoveTimer",removeHelpMoveStatus);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(!messageSent && startTime + 1000 < DCGame.getTime())
         {
            MessageCenter.sendMessage("StartCollisionPlayback");
            messageSent = true;
         }
         if(locationArrowMessageSent == true && BattleManager.getTurnTimeUsed() < 500)
         {
            locationArrowMessageSent = false;
         }
         if(!endMusicFlag && BattleManager.getMatchTimeLeft() < 13000 && BattleManager.getMatchTimeLeft() > 12500)
         {
            endMusicFlag = true;
            if(Sounds.getSoundReference("BattleMusic"))
            {
               sendSoundMessage("StopSound",Sounds.getSoundReference("BattleMusic"),"LoopSound");
            }
            if(Sounds.getSoundReference("GameAlmostOver"))
            {
               sendSoundMessage("PlaySound",Sounds.getSoundReference("GameAlmostOver"),"PlaySound");
            }
         }
         if(BattleManager.getTurnTimeLeft() < 7000 && BattleManager.getTurnTimeLeft() > 6800)
         {
            if(Sounds.getSoundReference("TurnEnd"))
            {
               sendSoundMessage("PlaySound",Sounds.getSoundReference("TurnEnd"),"PlaySound");
            }
         }
         var _loc2_:PlayerGameObject = BattleManager.getCurrentActivePlayer();
         if(_loc2_)
         {
            if(!locationArrowMessageSent && BattleManager.getTurnDuration() - BattleManager.getTurnTimeLeft() > 2000)
            {
               locationArrowMessageSent = true;
               MessageCenter.sendMessage("HelpHudEndInfoArrow");
            }
            if(sendHelpMoveCheck && BattleManager.getTurnDuration() - BattleManager.getTurnTimeLeft() > 9000)
            {
               sendHelpMoveCheck = false;
               MessageCenter.sendMessage("HelpHudStartMove");
            }
            if(!_loc2_.fired && BattleManager.isLocalPlayersTurn())
            {
               _loc2_.infoContainer.playCountDownTimer(BattleManager.getTurnTimeLeft());
            }
         }
      }
      
      private function setHelpMoveStatus(msg:Message) : void
      {
         sendHelpMoveCheck = true;
      }
      
      private function removeHelpMoveStatus(msg:Message) : void
      {
         sendHelpMoveCheck = false;
         MessageCenter.sendMessage("HelpHudEndMove");
      }
      
      private function sendSoundMessage(type:String, sound:SoundReference, playType:String) : void
      {
         MessageCenter.sendEvent(new SoundMessage(type,sound.getMusicID(),sound.getLoop(),sound.getType(),playType));
      }
   }
}
