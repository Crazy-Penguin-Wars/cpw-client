package tuxwars.battle.states.player
{
   import com.dchoc.game.GameWorld;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.states.State;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import flash.geom.Point;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.actions.PlayerFireAction;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.AimMessage;
   import tuxwars.battle.net.messages.battle.FireModeMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.AimResponse;
   import tuxwars.battle.net.responses.ChangeWeaponResponse;
   
   public class PlayerActiveAimSubState extends PlayerState
   {
       
      
      private const lastPoint:Point = new Point();
      
      private var playerFireAction:PlayerFireAction;
      
      private var _fire:Boolean;
      
      public function PlayerActiveAimSubState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
         if(BattleManager.isLocalPlayersTurn())
         {
            playerFireAction = new PlayerFireAction(player,this);
         }
      }
      
      override public function enter() : void
      {
         LogUtils.log(player + " Entering PlayerActiveAimSubState",null);
         super.enter();
         if(player.mode != "AimMode")
         {
            player.mode = "AimMode";
         }
         if(player.moveControls.walking)
         {
            player.changeAnimation("walk");
         }
         else
         {
            player.idleMode = true;
         }
         if(BattleManager.isLocalPlayersTurn())
         {
            GameWorld.getInputSystem().addInputAction(playerFireAction);
         }
         player.changeWeapon(params);
      }
      
      override public function exit() : void
      {
         if(playerFireAction)
         {
            GameWorld.getInputSystem().removeInputAction(playerFireAction);
            playerFireAction.dispose();
            playerFireAction = null;
         }
         super.exit();
      }
      
      override public function handleMessage(response:ActionResponse) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         super.handleMessage(response);
         LogUtils.addDebugLine("HandleMessage","Handling response: " + response.responseType,"PlayerActiveAimSubState");
         var _loc2_:Object = response.data;
         switch(response.responseType - 2)
         {
            case 0:
               _loc3_ = AimResponse(response).direction;
               _loc4_ = player.aim(_loc3_);
               _loc4_.dispose();
               break;
            case 1:
            case 2:
            case 3:
            case 5:
               player.moveControls.applyActionResponse(response);
               break;
            case 4:
               player.changeWeapon(ChangeWeaponResponse(response).weaponId);
         }
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         var _loc2_:* = null;
         super.physicsUpdate(deltaTime);
         if(player.weapon && BattleManager.isLocalPlayersTurn() && player.mode == "AimMode")
         {
            _loc2_ = player.aim();
            if(!MathUtils.equals(_loc2_.x,lastPoint.x,15) || !MathUtils.equals(_loc2_.y,lastPoint.y,15))
            {
               var _loc3_:PlayerGameObject = player;
               MessageCenter.sendEvent(new AimMessage(_loc2_,_loc3_._id));
               lastPoint.x = _loc2_.x;
               lastPoint.y = _loc2_.y;
            }
            _loc2_.dispose();
         }
         if(_fire)
         {
            player.mode = "FireMode";
            var _loc4_:PlayerGameObject = player;
            MessageCenter.sendEvent(new FireModeMessage(_loc4_._id));
            _fire = false;
         }
      }
      
      override public function allowStateChange(nextState:State) : Boolean
      {
         if(player.isDead() && nextState is PlayerActiveFireSubState)
         {
            return false;
         }
         return super.allowStateChange(nextState);
      }
      
      public function set fire(value:Boolean) : void
      {
         var _loc2_:PlayerGameObject = player;
         LogUtils.log("Player " + _loc2_._id + " got fire action.","PlayerActiveAimSubState",1,"Input",false);
         _fire = value;
      }
   }
}
