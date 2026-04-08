package tuxwars.battle.states.player.ai
{
   import com.dchoc.messages.*;
   import com.dchoc.states.State;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.responses.*;
   import tuxwars.battle.states.player.*;
   import tuxwars.battle.states.weapon.*;
   
   public class AIPlayerActiveAimSubState extends PlayerState
   {
      private var aimSent:Boolean;
      
      public function AIPlayerActiveAimSubState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         player.idleMode = true;
         var _loc1_:PlayerGameObject = player;
         MessageCenter.sendEvent(new ChangeWeaponMessage(params,_loc1_._id));
      }
      
      override public function handleMessage(param1:ActionResponse) : void
      {
         var _loc2_:Vec2 = null;
         var _loc3_:Vec2 = null;
         super.handleMessage(param1);
         switch(param1.responseType - 2)
         {
            case 0:
               _loc2_ = AimResponse(param1).direction;
               _loc3_ = player.aim(_loc2_);
               _loc3_.dispose();
               break;
            case 4:
               player.changeWeapon(ChangeWeaponResponse(param1).weaponId);
         }
      }
      
      override public function allowStateChange(param1:State) : Boolean
      {
         if(player.isDead() || param1 is PlayerActiveFireSubState && player.weapon.state is WeaponDrawState)
         {
            return false;
         }
         return super.allowStateChange(param1);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc5_:PlayerGameObject = null;
         var _loc6_:PlayerGameObject = null;
         var _loc2_:Vec2 = null;
         var _loc3_:* = undefined;
         var _loc4_:PlayerGameObject = null;
         super.logicUpdate(param1);
         if(Boolean(player.weapon) && player.weapon.isAiming())
         {
            if(!this.aimSent)
            {
               _loc2_ = (player as AIPlayerGameObject).target;
               if(!_loc2_)
               {
                  _loc3_ = BattleManager.getOpponents();
                  _loc4_ = _loc3_[Random.integer(0,_loc3_.length - 1)];
                  _loc2_ = _loc4_.bodyLocation.copy();
                  _loc2_.subeq(player.bodyLocation);
                  (player as AIPlayerGameObject).target = _loc2_;
               }
               _loc5_ = player;
               MessageCenter.sendEvent(new AimMessage(_loc2_,_loc5_._id));
               this.aimSent = true;
            }
            else
            {
               _loc6_ = player;
               MessageCenter.sendEvent(new FireModeMessage(_loc6_._id));
            }
         }
      }
   }
}

