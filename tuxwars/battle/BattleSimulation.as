package tuxwars.battle
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.events.TimerEvent;
   import flash.geom.*;
   import flash.utils.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.utils.*;
   import tuxwars.data.*;
   
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
      
      public function BattleSimulation(param1:int, param2:int, param3:Array, param4:Boolean, param5:Boolean)
      {
         super();
         this.battleDuration = param1 * 1000;
         this.turnDuration = param2 * 1000;
         this.players = param3;
         this.practiceMode = param4;
         this.tournamentMode = param5;
         this.curPlayerIndex = -1;
         this.matchTimeLeft = this.battleDuration;
         this.turnTimeLeft = this.turnDuration;
         this.practiceTurnTimeLeft = this.turnDuration;
         this.practiceMatchTimeLeft = this.battleDuration;
         MessageCenter.addListener("BattleResponse",this.responseHandler);
         MessageCenter.addListener("PlayerFired",this.playerFired);
         MessageCenter.addListener("TurnCompleted",this.handleTurnCompleted);
         MessageCenter.addListener("MatchStarted",this.matchStarted);
         if(param4)
         {
            MessageCenter.addListener("ActionResponse",this.playerActionResponseHandler);
            this.practiceBoosterTimer = new Timer(BattleOptions.getRow().findField("BoosterCooldown").value,1);
            this.practiceBoosterTimer.addEventListener("timer",this.boosterCooldownCallback,false,0,true);
         }
      }
      
      public function dispose() : void
      {
         this.players = null;
         MessageCenter.removeListener("BattleResponse",this.responseHandler);
         MessageCenter.removeListener("PlayerFired",this.playerFired);
         MessageCenter.removeListener("TurnCompleted",this.handleTurnCompleted);
         MessageCenter.removeListener("MatchStarted",this.matchStarted);
         if(this.practiceMode)
         {
            MessageCenter.removeListener("ActionResponse",this.playerActionResponseHandler);
            this.practiceBoosterTimer.stop();
            this.practiceBoosterTimer.removeEventListener("timer",this.boosterCooldownCallback);
         }
         LogicUpdater.unregister(this,"Battle Simulation");
      }
      
      public function isBattleInProgress() : Boolean
      {
         return this.getMatchTimeLeft() > 0;
      }
      
      public function getMatchTimeLeft() : int
      {
         if(this.paused)
         {
            return this.pauseBattleTimeLeft;
         }
         return this.matchTimeLeft;
      }
      
      public function getMatchDuration() : int
      {
         return this.battleDuration;
      }
      
      public function updateTurnTime(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(!this.paused)
         {
            this.turnTimeLeft = param1;
            this.clientTrackingElapsedTurnTime = this.turnDuration - param1;
         }
      }
      
      public function updateMatchTime(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(!this.paused)
         {
            this.matchTimeLeft = param1;
         }
      }
      
      public function getTurnTimeLeft() : int
      {
         if(this.paused)
         {
            return this.pauseTurnTimeLeft;
         }
         return this.turnTimeLeft;
      }
      
      public function getTurnTimeUsed() : int
      {
         return this.turnTimeLeft;
      }
      
      public function getClientTrackingTurnTimeElapsed() : int
      {
         return this.clientTrackingElapsedTurnTime;
      }
      
      public function getTurnDuration() : int
      {
         return this.turnDuration;
      }
      
      public function get turnStartTime() : int
      {
         return this._turnStartTime;
      }
      
      public function set turnStartTime(param1:int) : void
      {
         this._turnStartTime = param1;
      }
      
      public function get changingTurns() : Boolean
      {
         return this.turnChange;
      }
      
      public function pause() : void
      {
         LogUtils.log("Pausing Battle Simulation","BattleSimulation",1,"LogicUpdater");
         this.pauseBattleTimeLeft = this.getMatchTimeLeft();
         this.pauseTurnTimeLeft = this.getTurnTimeLeft();
         this.paused = true;
      }
      
      public function resume() : void
      {
         LogUtils.log("Resuming Battle Simulation","BattleSimulation",1,"LogicUpdater");
         this.battleStartTime = DCGame.getTime() - (this.battleDuration - this.pauseBattleTimeLeft);
         var _loc1_:* = DCGame.getTime() - (this.turnDuration - this.pauseTurnTimeLeft);
         this._turnStartTime = _loc1_;
         this.paused = false;
      }
      
      public function logicUpdate(param1:int) : void
      {
         if(this._matchEnd)
         {
            return;
         }
         if(this.practiceMode)
         {
            if(this.actionDone)
            {
               if(this.turnComplete)
               {
                  if(this.getMatchTimeLeft() <= 0)
                  {
                     this.endGame();
                     return;
                  }
                  if(this.getTurnTimeLeft() <= 0 && !this.turnChange)
                  {
                     LogUtils.log("Turn time ended and action done, ending turn.",this,1,"Game");
                     this.endTurn();
                     return;
                  }
               }
            }
            else
            {
               if(this.getMatchTimeLeft() <= 0)
               {
                  this.endGame();
                  return;
               }
               if(this.getTurnTimeLeft() <= 0 && !this.turnChange)
               {
                  LogUtils.log("Turn time ended, ending turn.",this,1,"Game");
                  this.endTurn();
                  return;
               }
            }
            if(!this.turnChange)
            {
               if(!this.paused)
               {
                  this.practiceMatchTimeLeft -= param1;
                  if(this.practiceMatchTimeLeft < 0)
                  {
                     this.practiceMatchTimeLeft = 0;
                  }
               }
               this.practiceUpdateDeltaTime += param1;
               if(this.practiceUpdateDeltaTime >= BattleOptions.getRow().findField("WorldUpdateTime").value && this.practiceTurnTimeLeft > 0)
               {
                  if(!this.paused)
                  {
                     this.practiceTurnTimeLeft -= BattleOptions.getRow().findField("WorldUpdateTime").value;
                     if(this.practiceTurnTimeLeft < 0)
                     {
                        this.practiceTurnTimeLeft = 0;
                     }
                  }
                  MessageCenter.sendEvent(new UpdateWorldMessage(this.practiceTurnTimeLeft,this.practiceMatchTimeLeft,this.practiceRespawnPlayers,this.practiceResumePlayers));
                  this.practiceRespawnPlayers.splice(0,this.practiceRespawnPlayers.length);
                  this.practiceResumePlayers.splice(0,this.practiceResumePlayers.length);
                  this.practiceUpdateDeltaTime -= BattleOptions.getRow().findField("WorldUpdateTime").value;
               }
            }
         }
      }
      
      private function playerFired(param1:Message) : void
      {
         LogUtils.log("Player action done " + BattleManager.getCurrentActivePlayer(),this,1,"Game");
         this.actionDone = true;
         if(this.paused)
         {
            this.pauseTurnTimeLeft = this.turnDuration - (DCGame.getTime() - this._turnStartTime);
         }
         if(this.practiceMode)
         {
            this.practiceTurnTimeLeft = BattleOptions.getTimeAfterFiring() * 1000;
         }
      }
      
      private function handleTurnCompleted(param1:Message) : void
      {
         LogUtils.log("Turn has been completed. " + BattleManager.getCurrentActivePlayer(),this,1,"Game");
         this.turnComplete = true;
      }
      
      private function start() : void
      {
         LogUtils.log("Starting Battle Simulation","BattleSimulation",1,"LogicUpdater");
         if(this.practiceMode)
         {
            MessageCenter.sendEvent(new StartTurnMessage(this.players[this.curPlayerIndex].id));
         }
         this.battleStartTime = DCGame.getTime();
         this._matchEnd = false;
         LogicUpdater.register(this,"Battle Simulation");
      }
      
      private function responseHandler(param1:BattleResponse) : void
      {
         if(!SocketMessageTypes.isControlMessage(param1.responseType))
         {
            return;
         }
         LogUtils.addDebugLine("HandleMessage","Handling response: " + param1.responseType,"BattleSimulation");
         switch(param1.responseType - 15)
         {
            case 0:
               if(this.practiceMode)
               {
                  ++this.numReadyPlayers;
                  if(this.numReadyPlayers == this.players.length)
                  {
                     ++this.curPlayerIndex;
                     this.start();
                  }
                  if(this.turnChange)
                  {
                     MessageCenter.sendEvent(new StartTurnMessage(this.players[this.curPlayerIndex].id));
                  }
               }
               break;
            case 2:
               LogUtils.log("Starting turn.",this,1,"Game");
               ++this.curPlayerIndex;
               if(this.curPlayerIndex >= this.players.length)
               {
                  this.curPlayerIndex = 0;
               }
               this._turnStartTime = DCGame.getTime();
               this.turnChange = false;
               this.turnComplete = false;
               this.actionDone = false;
               this.turnTimeLeft = this.turnDuration;
               this.clientTrackingElapsedTurnTime = 0;
               this.practiceTurnTimeLeft = this.turnDuration;
               break;
            case 4:
               this._matchEnd = true;
         }
      }
      
      private function playerActionResponseHandler(param1:ActionResponse) : void
      {
         switch(param1.responseType - 34)
         {
            case 0:
               this.practiceBoosterTimer.reset();
               this.practiceBoosterTimer.delay = BattleOptions.getRow().findField("BoosterCooldown").value;
               this.practiceBoosterTimer.start();
               break;
            case 1:
               this.practiceDeadPlayerTimers.push(new DeadPlayerTimer(param1.data.dead_dude,new Point(param1.data.x,param1.data.y),param1.data.r,this.practiceRespawnPlayer,this.practiceResumePlayer));
         }
      }
      
      private function practiceRespawnPlayer(param1:String, param2:Point, param3:Boolean) : void
      {
         this.practiceRespawnPlayers.push({
            "dead_dude":param1,
            "x":param2.x,
            "y":param2.y,
            "r":param3
         });
      }
      
      private function practiceResumePlayer(param1:String) : void
      {
         var _loc2_:* = undefined;
         this.practiceResumePlayers.push({"dead_dude":param1});
         for each(_loc2_ in this.practiceDeadPlayerTimers)
         {
            if(_loc2_.playerId == param1)
            {
               this.practiceDeadPlayerTimers.splice(this.practiceDeadPlayerTimers.indexOf(_loc2_),1);
               return;
            }
         }
      }
      
      private function matchStarted(param1:Message) : void
      {
         if(!this.practiceMode)
         {
            this.start();
         }
      }
      
      private function endGame() : void
      {
         if(!this._matchEnd)
         {
            MessageCenter.sendEvent(new EndGameMessage());
            this._matchEnd = true;
         }
      }
      
      private function boosterCooldownCallback(param1:TimerEvent) : void
      {
         var _loc2_:* = BattleManager.getLocalPlayer();
         MessageCenter.sendEvent(new EnableBoostersMessage(_loc2_._id));
      }
      
      public function endTurn() : void
      {
         var _loc5_:* = undefined;
         var _loc1_:* = BattleManager.getCurrentActivePlayer();
         LogUtils.addDebugLine("Game","Ending turn " + _loc1_._id,"BattleSimulation");
         var _loc2_:SoundReference = Sounds.getSoundReference(Sounds.getWalk());
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc2_.getLoop(),_loc2_.getType(),"LoopSound"));
         }
         this.turnChange = true;
         var _loc3_:PlayerGameObject = BattleManager.getCurrentActivePlayer();
         var _loc4_:* = _loc3_;
         if(Boolean(BattleManager.isLocalPlayer(_loc4_._id)) || _loc3_.isAI())
         {
            if(!_loc3_.checkForShoot)
            {
               MessageCenter.sendMessage("HelpHudEndShoot");
            }
            MessageCenter.sendMessage("HelpHudCancelMoveTimer");
            _loc3_.moveControls.hideControls();
            if(this.practiceMode)
            {
               _loc5_ = BattleManager.getCurrentActivePlayer();
               MessageCenter.sendEvent(new EndTurnMessage(_loc5_._id));
            }
         }
      }
   }
}

