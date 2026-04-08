package tuxwars.battle.utils
{
   import com.dchoc.utils.*;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.*;
   import tuxwars.battle.data.*;
   
   public class DeadPlayerTimer
   {
      private var _playerId:String;
      
      private var _loc:Point;
      
      private var _sleep:Boolean;
      
      private var _timer:Timer;
      
      private var _respawnCallback:Function;
      
      private var _resumeCallback:Function;
      
      public function DeadPlayerTimer(param1:String, param2:Point, param3:Boolean, param4:Function, param5:Function)
      {
         super();
         LogUtils.log("Starting dying timer for: " + param1,this,1,"Player",false);
         this._playerId = param1;
         this._loc = param2;
         this._sleep = param3;
         this._respawnCallback = param4;
         this._resumeCallback = param5;
         this._timer = new Timer(BattleOptions.getRow().findField("TimeToRespawn").value,1);
         this._timer.addEventListener("timer",this.respawn,false,0,true);
         this._timer.start();
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
      
      private function respawn(param1:TimerEvent) : void
      {
         LogUtils.log("Respawn timer for player: " + this._playerId,this,1,"Player",false);
         this._timer.stop();
         this._timer.reset();
         this._respawnCallback(this._playerId,this._loc,this._sleep);
         this._timer.delay = BattleOptions.getRow().findField("TimeToResume").value;
         this._timer.removeEventListener("timer",this.respawn);
         this._timer.addEventListener("timer",this.resume,false,0,true);
         this._timer.start();
      }
      
      private function resume(param1:TimerEvent) : void
      {
         LogUtils.log("Resume timer for player: " + this._playerId,this,1,"Player",false);
         this._timer.stop();
         this._timer.removeEventListener("timer",this.resume);
         this._timer = null;
         this._resumeCallback(this._playerId);
      }
   }
}

