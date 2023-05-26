package tuxwars.battle.states.player.ai
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.states.State;
   import com.dchoc.utils.Random;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.player.AIPlayerGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.AimMessage;
   import tuxwars.battle.net.messages.battle.ChangeWeaponMessage;
   import tuxwars.battle.net.messages.battle.FireModeMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.AimResponse;
   import tuxwars.battle.net.responses.ChangeWeaponResponse;
   import tuxwars.battle.states.player.PlayerActiveFireSubState;
   import tuxwars.battle.states.player.PlayerState;
   import tuxwars.battle.states.weapon.WeaponDrawState;
   
   public class AIPlayerActiveAimSubState extends PlayerState
   {
       
      
      private var aimSent:Boolean;
      
      public function AIPlayerActiveAimSubState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         player.idleMode = true;
         var _loc1_:PlayerGameObject = player;
         MessageCenter.sendEvent(new ChangeWeaponMessage(params,_loc1_._id));
      }
      
      override public function handleMessage(response:ActionResponse) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         super.handleMessage(response);
         switch(response.responseType - 2)
         {
            case 0:
               _loc2_ = AimResponse(response).direction;
               _loc3_ = player.aim(_loc2_);
               _loc3_.dispose();
               break;
            case 4:
               player.changeWeapon(ChangeWeaponResponse(response).weaponId);
         }
      }
      
      override public function allowStateChange(nextState:State) : Boolean
      {
         if(player.isDead() || nextState is PlayerActiveFireSubState && player.weapon.state is WeaponDrawState)
         {
            return false;
         }
         return super.allowStateChange(nextState);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         var targetVec:* = null;
         var _loc3_:* = undefined;
         var _loc2_:* = null;
         super.logicUpdate(deltaTime);
         if(player.weapon && player.weapon.isAiming())
         {
            if(!aimSent)
            {
               targetVec = (player as AIPlayerGameObject).target;
               if(!targetVec)
               {
                  _loc3_ = BattleManager.getOpponents();
                  _loc2_ = _loc3_[Random.integer(0,_loc3_.length - 1)];
                  targetVec = _loc2_.bodyLocation.copy();
                  targetVec.subeq(player.bodyLocation);
                  (player as AIPlayerGameObject).target = targetVec;
               }
               var _loc5_:PlayerGameObject = player;
               MessageCenter.sendEvent(new AimMessage(targetVec,_loc5_._id));
               aimSent = true;
            }
            else
            {
               var _loc6_:PlayerGameObject = player;
               MessageCenter.sendEvent(new FireModeMessage(_loc6_._id));
            }
         }
      }
   }
}
