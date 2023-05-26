package tuxwars.battle.utils
{
   import com.dchoc.utils.LogUtils;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import tuxwars.battle.data.BattleOptions;
   
   public class DeadPlayerTimer
   {
       
      
      private var _playerId:String;
      
      private var _loc:Point;
      
      private var _sleep:Boolean;
      
      private var _timer:Timer;
      
      private var _respawnCallback:Function;
      
      private var _resumeCallback:Function;
      
      public function DeadPlayerTimer(playerId:String, loc:Point, sleep:Boolean, respawnCallback:Function, resumeCallback:Function)
      {
         super();
         LogUtils.log("Starting dying timer for: " + playerId,this,1,"Player",false);
         _playerId = playerId;
         _loc = loc;
         _sleep = sleep;
         _respawnCallback = respawnCallback;
         _resumeCallback = resumeCallback;
         var _loc6_:BattleOptions = BattleOptions;
         _timer = new Timer(tuxwars.battle.data.BattleOptions.getRow().findField("TimeToRespawn").value,1);
         _timer.addEventListener("timer",respawn,false,0,true);
         _timer.start();
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
      
      private function respawn(event:TimerEvent) : void
      {
         LogUtils.log("Respawn timer for player: " + _playerId,this,1,"Player",false);
         _timer.stop();
         _timer.reset();
         _respawnCallback(_playerId,_loc,_sleep);
         var _loc2_:BattleOptions = BattleOptions;
         _timer.delay = tuxwars.battle.data.BattleOptions.getRow().findField("TimeToResume").value;
         _timer.removeEventListener("timer",respawn);
         _timer.addEventListener("timer",resume,false,0,true);
         _timer.start();
      }
      
      private function resume(event:TimerEvent) : void
      {
         LogUtils.log("Resume timer for player: " + _playerId,this,1,"Player",false);
         _timer.stop();
         _timer.removeEventListener("timer",resume);
         _timer = null;
         _resumeCallback(_playerId);
      }
   }
}
