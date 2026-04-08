package tuxwars.battle.states.player
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.states.State;
   import com.dchoc.utils.*;
   import flash.geom.*;
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   import tuxwars.battle.actions.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.responses.*;
   
   public class PlayerActiveAimSubState extends PlayerState
   {
      private const lastPoint:Point = new Point();
      
      private var playerFireAction:PlayerFireAction;
      
      private var _fire:Boolean;
      
      public function PlayerActiveAimSubState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
         if(BattleManager.isLocalPlayersTurn())
         {
            this.playerFireAction = new PlayerFireAction(param1,this);
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
            GameWorld.getInputSystem().addInputAction(this.playerFireAction);
         }
         player.changeWeapon(params);
      }
      
      override public function exit() : void
      {
         if(this.playerFireAction)
         {
            GameWorld.getInputSystem().removeInputAction(this.playerFireAction);
            this.playerFireAction.dispose();
            this.playerFireAction = null;
         }
         super.exit();
      }
      
      override public function handleMessage(param1:ActionResponse) : void
      {
         var _loc2_:Vec2 = null;
         var _loc3_:Vec2 = null;
         super.handleMessage(param1);
         LogUtils.addDebugLine("HandleMessage","Handling response: " + param1.responseType,"PlayerActiveAimSubState");
         var _loc4_:Object = param1.data;
         switch(param1.responseType - 2)
         {
            case 0:
               _loc2_ = AimResponse(param1).direction;
               _loc3_ = player.aim(_loc2_);
               _loc3_.dispose();
               break;
            case 1:
            case 2:
            case 3:
            case 5:
               player.moveControls.applyActionResponse(param1);
               break;
            case 4:
               player.changeWeapon(ChangeWeaponResponse(param1).weaponId);
         }
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         var _loc3_:PlayerGameObject = null;
         var _loc4_:PlayerGameObject = null;
         var _loc2_:Vec2 = null;
         super.physicsUpdate(param1);
         if(player.weapon && BattleManager.isLocalPlayersTurn() && player.mode == "AimMode")
         {
            _loc2_ = player.aim();
            if(!MathUtils.equals(_loc2_.x,this.lastPoint.x,15) || !MathUtils.equals(_loc2_.y,this.lastPoint.y,15))
            {
               _loc3_ = player;
               MessageCenter.sendEvent(new AimMessage(_loc2_,_loc3_._id));
               this.lastPoint.x = _loc2_.x;
               this.lastPoint.y = _loc2_.y;
            }
            _loc2_.dispose();
         }
         if(this._fire)
         {
            player.mode = "FireMode";
            _loc4_ = player;
            MessageCenter.sendEvent(new FireModeMessage(_loc4_._id));
            this._fire = false;
         }
      }
      
      override public function allowStateChange(param1:State) : Boolean
      {
         if(player.isDead() && param1 is PlayerActiveFireSubState)
         {
            return false;
         }
         return super.allowStateChange(param1);
      }
      
      public function set fire(param1:Boolean) : void
      {
         var _loc2_:PlayerGameObject = player;
         LogUtils.log("Player " + _loc2_._id + " got fire action.","PlayerActiveAimSubState",1,"Input",false);
         this._fire = param1;
      }
   }
}

