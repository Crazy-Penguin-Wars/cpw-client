package tuxwars.battle.states.player.ai
{
   import com.dchoc.messages.MessageCenter;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.player.AIPlayerGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.FireWeaponMessage;
   import tuxwars.battle.states.player.PlayerActiveFireSubState;
   import tuxwars.battle.states.player.PlayerInactiveState;
   
   public class AIPlayerActiveFireSubState extends PlayerActiveFireSubState
   {
       
      
      private var messageSent:Boolean;
      
      public function AIPlayerActiveFireSubState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         var _loc2_:Vec2 = (player as AIPlayerGameObject).target;
         if(_loc2_ && !messageSent)
         {
            var _loc3_:PlayerGameObject = player;
            MessageCenter.sendEvent(new FireWeaponMessage(_loc2_,player.bodyLocation,100,"BasicNuke",_loc3_._id));
            messageSent = true;
         }
         else
         {
            finished();
         }
      }
      
      override protected function finished() : void
      {
         (player as AIPlayerGameObject).target = null;
         var _loc1_:BattleManager = BattleManager;
         tuxwars.battle.BattleManager._aiPlayerHasShot = true;
         parent.changeState(new PlayerInactiveState(player));
      }
   }
}
