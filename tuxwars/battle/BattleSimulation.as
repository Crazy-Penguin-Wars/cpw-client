package tuxwars.battle
{
   import com.dchoc.game.DCGame;
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import tuxwars.battle.data.BattleOptions;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.SocketMessageTypes;
   import tuxwars.battle.net.messages.control.EnableBoostersMessage;
   import tuxwars.battle.net.messages.control.EndGameMessage;
   import tuxwars.battle.net.messages.control.EndTurnMessage;
   import tuxwars.battle.net.messages.control.StartTurnMessage;
   import tuxwars.battle.net.messages.control.UpdateWorldMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.utils.DeadPlayerTimer;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
   public final class BattleSimulation
   {
       
      
      private const practiceDeadPlayerTimers:Vector.<DeadPlayerTimer> = new Vector.<DeadPlayerTimer>();
      
      private const practiceRespawnPlayers:Array = [];
      
      private const practiceResumePlayers:Array = [];
      
      private var practiceBoosterTimer:Timer;
      
      private var practiceUpdateDeltaTime:int;
      
      private var battleDuration:int;
      
      private var battleStartTime:int;
      
      private var turnDuration:int;
      
      private var _turnStartTime:int;
      
      private var turnTimeLeft:int;
      
      private var clientTrackingElapsedTurnTime:int;
      
      private var matchTimeLeft:int;
      
      private var players:Array;
      
      private var numReadyPlayers:int;
      
      private var curPlayerIndex:int;
      
      private var turnChange:Boolean;
      
      private var _matchEnd:Boolean;
      
      private var turnComplete:Boolean;
      
      private var actionDone:Boolean;
      
      private var practiceMode:Boolean;
      
      private var tournamentMode:Boolean;
      
      private var practiceTurnTimeLeft:int;
      
      private var practiceMatchTimeLeft:int;
      
      private var pauseBattleTimeLeft:int;
      
      private var paused:Boolean;
      
      private var pauseTurnTimeLeft:int;
      
      public function BattleSimulation(battleDuration:int, turnDuration:int, players:Array, practiceMode:Boolean, tournamentMode:Boolean)
      {
         super();
         this.battleDuration = battleDuration * 1000;
         this.turnDuration = turnDuration * 1000;
         this.players = players;
         this.practiceMode = practiceMode;
         this.tournamentMode = tournamentMode;
         curPlayerIndex = -1;
         matchTimeLeft = this.battleDuration;
         turnTimeLeft = this.turnDuration;
         practiceTurnTimeLeft = this.turnDuration;
         practiceMatchTimeLeft = this.battleDuration;
         MessageCenter.addListener("BattleResponse",responseHandler);
         MessageCenter.addListener("PlayerFired",playerFired);
         MessageCenter.addListener("TurnCompleted",handleTurnCompleted);
         MessageCenter.addListener("MatchStarted",matchStarted);
         if(practiceMode)
         {
            MessageCenter.addListener("ActionResponse",playerActionResponseHandler);
            var _loc6_:BattleOptions = BattleOptions;
            practiceBoosterTimer = new Timer(tuxwars.battle.data.BattleOptions.getRow().findField("BoosterCooldown").value,1);
            practiceBoosterTimer.addEventListener("timer",boosterCooldownCallback,false,0,true);
         }
      }
      
      public function dispose() : void
      {
         players = null;
         MessageCenter.removeListener("BattleResponse",responseHandler);
         MessageCenter.removeListener("PlayerFired",playerFired);
         MessageCenter.removeListener("TurnCompleted",handleTurnCompleted);
         MessageCenter.removeListener("MatchStarted",matchStarted);
         if(practiceMode)
         {
            MessageCenter.removeListener("ActionResponse",playerActionResponseHandler);
            practiceBoosterTimer.stop();
            practiceBoosterTimer.removeEventListener("timer",boosterCooldownCallback);
         }
         LogicUpdater.unregister(this,"Battle Simulation");
      }
      
      public function isBattleInProgress() : Boolean
      {
         return getMatchTimeLeft() > 0;
      }
      
      public function getMatchTimeLeft() : int
      {
         if(paused)
         {
            return pauseBattleTimeLeft;
         }
         return matchTimeLeft;
      }
      
      public function getMatchDuration() : int
      {
         return battleDuration;
      }
      
      public function updateTurnTime(value:int) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         if(!paused)
         {
            turnTimeLeft = value;
            clientTrackingElapsedTurnTime = turnDuration - value;
         }
      }
      
      public function updateMatchTime(value:int) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         if(!paused)
         {
            matchTimeLeft = value;
         }
      }
      
      public function getTurnTimeLeft() : int
      {
         if(paused)
         {
            return pauseTurnTimeLeft;
         }
         return turnTimeLeft;
      }
      
      public function getTurnTimeUsed() : int
      {
         return turnTimeLeft;
      }
      
      public function getClientTrackingTurnTimeElapsed() : int
      {
         return clientTrackingElapsedTurnTime;
      }
      
      public function getTurnDuration() : int
      {
         return turnDuration;
      }
      
      public function get turnStartTime() : int
      {
         return _turnStartTime;
      }
      
      public function set turnStartTime(value:int) : void
      {
         _turnStartTime = value;
      }
      
      public function get changingTurns() : Boolean
      {
         return turnChange;
      }
      
      public function pause() : void
      {
         LogUtils.log("Pausing Battle Simulation","BattleSimulation",1,"LogicUpdater");
         pauseBattleTimeLeft = getMatchTimeLeft();
         pauseTurnTimeLeft = getTurnTimeLeft();
         paused = true;
      }
      
      public function resume() : void
      {
         LogUtils.log("Resuming Battle Simulation","BattleSimulation",1,"LogicUpdater");
         battleStartTime = DCGame.getTime() - (battleDuration - pauseBattleTimeLeft);
         var _loc1_:* = DCGame.getTime() - (turnDuration - pauseTurnTimeLeft);
         this._turnStartTime = _loc1_;
         paused = false;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         if(_matchEnd)
         {
            return;
         }
         if(practiceMode)
         {
            if(actionDone)
            {
               if(turnComplete)
               {
                  if(getMatchTimeLeft() <= 0)
                  {
                     endGame();
                     return;
                  }
                  if(getTurnTimeLeft() <= 0 && !turnChange)
                  {
                     LogUtils.log("Turn time ended and action done, ending turn.",this,1,"Game");
                     endTurn();
                     return;
                  }
               }
            }
            else
            {
               if(getMatchTimeLeft() <= 0)
               {
                  endGame();
                  return;
               }
               if(getTurnTimeLeft() <= 0 && !turnChange)
               {
                  LogUtils.log("Turn time ended, ending turn.",this,1,"Game");
                  endTurn();
                  return;
               }
            }
            if(!turnChange)
            {
               if(!paused)
               {
                  practiceMatchTimeLeft -= deltaTime;
                  if(practiceMatchTimeLeft < 0)
                  {
                     practiceMatchTimeLeft = 0;
                  }
               }
               practiceUpdateDeltaTime += deltaTime;
               var _loc2_:BattleOptions = BattleOptions;
               if(practiceUpdateDeltaTime >= tuxwars.battle.data.BattleOptions.getRow().findField("WorldUpdateTime").value && practiceTurnTimeLeft > 0)
               {
                  if(!paused)
                  {
                     var _loc3_:BattleOptions = BattleOptions;
                     practiceTurnTimeLeft -= tuxwars.battle.data.BattleOptions.getRow().findField("WorldUpdateTime").value;
                     if(practiceTurnTimeLeft < 0)
                     {
                        practiceTurnTimeLeft = 0;
                     }
                  }
                  MessageCenter.sendEvent(new UpdateWorldMessage(practiceTurnTimeLeft,practiceMatchTimeLeft,practiceRespawnPlayers,practiceResumePlayers));
                  practiceRespawnPlayers.splice(0,practiceRespawnPlayers.length);
                  practiceResumePlayers.splice(0,practiceResumePlayers.length);
                  var _loc4_:BattleOptions = BattleOptions;
                  practiceUpdateDeltaTime -= tuxwars.battle.data.BattleOptions.getRow().findField("WorldUpdateTime").value;
               }
            }
         }
      }
      
      private function playerFired(msg:Message) : void
      {
         LogUtils.log("Player action done " + BattleManager.getCurrentActivePlayer(),this,1,"Game");
         actionDone = true;
         if(paused)
         {
            pauseTurnTimeLeft = turnDuration - (DCGame.getTime() - _turnStartTime);
         }
         if(practiceMode)
         {
            practiceTurnTimeLeft = BattleOptions.getTimeAfterFiring() * 1000;
         }
      }
      
      private function handleTurnCompleted(msg:Message) : void
      {
         LogUtils.log("Turn has been completed. " + BattleManager.getCurrentActivePlayer(),this,1,"Game");
         turnComplete = true;
      }
      
      private function start() : void
      {
         LogUtils.log("Starting Battle Simulation","BattleSimulation",1,"LogicUpdater");
         if(practiceMode)
         {
            MessageCenter.sendEvent(new StartTurnMessage(players[curPlayerIndex].id));
         }
         battleStartTime = DCGame.getTime();
         _matchEnd = false;
         LogicUpdater.register(this,"Battle Simulation");
      }
      
      private function responseHandler(response:BattleResponse) : void
      {
         if(!SocketMessageTypes.isControlMessage(response.responseType))
         {
            return;
         }
         LogUtils.addDebugLine("HandleMessage","Handling response: " + response.responseType,"BattleSimulation");
         switch(response.responseType - 15)
         {
            case 0:
               if(practiceMode)
               {
                  numReadyPlayers++;
                  if(numReadyPlayers == players.length)
                  {
                     curPlayerIndex++;
                     start();
                  }
                  if(turnChange)
                  {
                     MessageCenter.sendEvent(new StartTurnMessage(players[curPlayerIndex].id));
                     break;
                  }
                  break;
               }
               break;
            case 2:
               LogUtils.log("Starting turn.",this,1,"Game");
               curPlayerIndex++;
               if(curPlayerIndex >= players.length)
               {
                  curPlayerIndex = 0;
               }
               _turnStartTime = DCGame.getTime();
               turnChange = false;
               turnComplete = false;
               actionDone = false;
               turnTimeLeft = turnDuration;
               clientTrackingElapsedTurnTime = 0;
               practiceTurnTimeLeft = turnDuration;
               break;
            case 4:
               _matchEnd = true;
         }
      }
      
      private function playerActionResponseHandler(response:ActionResponse) : void
      {
         switch(response.responseType - 34)
         {
            case 0:
               practiceBoosterTimer.reset();
               var _loc2_:BattleOptions = BattleOptions;
               practiceBoosterTimer.delay = tuxwars.battle.data.BattleOptions.getRow().findField("BoosterCooldown").value;
               practiceBoosterTimer.start();
               break;
            case 1:
               practiceDeadPlayerTimers.push(new DeadPlayerTimer(response.data.dead_dude,new Point(response.data.x,response.data.y),response.data.r,practiceRespawnPlayer,practiceResumePlayer));
         }
      }
      
      private function practiceRespawnPlayer(id:String, loc:Point, sleep:Boolean) : void
      {
         practiceRespawnPlayers.push({
            "dead_dude":id,
            "x":loc.x,
            "y":loc.y,
            "r":sleep
         });
      }
      
      private function practiceResumePlayer(id:String) : void
      {
         practiceResumePlayers.push({"dead_dude":id});
         for each(var timer in practiceDeadPlayerTimers)
         {
            if(timer.playerId == id)
            {
               practiceDeadPlayerTimers.splice(practiceDeadPlayerTimers.indexOf(timer),1);
               return;
            }
         }
      }
      
      private function matchStarted(msg:Message) : void
      {
         if(!practiceMode)
         {
            start();
         }
      }
      
      private function endGame() : void
      {
         if(!_matchEnd)
         {
            MessageCenter.sendEvent(new EndGameMessage());
            _matchEnd = true;
         }
      }
      
      private function boosterCooldownCallback(event:TimerEvent) : void
      {
         var _loc2_:* = BattleManager.getLocalPlayer();
         MessageCenter.sendEvent(new EnableBoostersMessage(_loc2_._id));
      }
      
      public function endTurn() : void
      {
         var _loc3_:* = BattleManager.getCurrentActivePlayer();
         LogUtils.addDebugLine("Game","Ending turn " + _loc3_._id,"BattleSimulation");
         var _loc2_:SoundReference = Sounds.getSoundReference(Sounds.getWalk());
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc2_.getLoop(),_loc2_.getType(),"LoopSound"));
         }
         turnChange = true;
         var _loc1_:PlayerGameObject = BattleManager.getCurrentActivePlayer();
         var _loc4_:* = _loc1_;
         if(BattleManager.isLocalPlayer(_loc4_._id) || _loc1_.isAI())
         {
            if(!_loc1_.checkForShoot)
            {
               MessageCenter.sendMessage("HelpHudEndShoot");
            }
            MessageCenter.sendMessage("HelpHudCancelMoveTimer");
            _loc1_.moveControls.hideControls();
            if(practiceMode)
            {
               var _loc5_:* = BattleManager.getCurrentActivePlayer();
               MessageCenter.sendEvent(new EndTurnMessage(_loc5_._id));
            }
         }
      }
   }
}
