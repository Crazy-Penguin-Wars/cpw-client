package tuxwars.battle.states.player.ai
{
   import com.dchoc.messages.*;
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.states.player.*;
   
   public class AIPlayerActiveFireSubState extends PlayerActiveFireSubState
   {
      private var messageSent:Boolean;
      
      public function AIPlayerActiveFireSubState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc3_:PlayerGameObject = null;
         super.logicUpdate(param1);
         var _loc2_:Vec2 = (player as AIPlayerGameObject).target;
         if(Boolean(_loc2_) && !this.messageSent)
         {
            _loc3_ = player;
            MessageCenter.sendEvent(new FireWeaponMessage(_loc2_,player.bodyLocation,100,"BasicNuke",_loc3_._id));
            this.messageSent = true;
         }
         else
         {
            this.finished();
         }
      }
      
      override protected function finished() : void
      {
         (player as AIPlayerGameObject).target = null;
         var _loc1_:Boolean = true;
         BattleManager._aiPlayerHasShot = _loc1_;
         parent.changeState(new PlayerInactiveState(player));
      }
   }
}

