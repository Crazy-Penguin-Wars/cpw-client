package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractMouseInputAction;
   import com.dchoc.utils.*;
   import flash.events.Event;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.states.player.*;
   
   public class PlayerFireAction extends AbstractMouseInputAction
   {
      private var player:PlayerGameObject;
      
      private var state:PlayerActiveAimSubState;
      
      public function PlayerFireAction(param1:PlayerGameObject, param2:PlayerActiveAimSubState)
      {
         super("mouseUp");
         this.player = param1;
         this.state = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.player = null;
         this.state = null;
      }
      
      override public function execute(param1:Event) : void
      {
         if(!this.player || !this.state)
         {
            return;
         }
         var _loc2_:PlayerGameObject = this.player;
         LogUtils.log("Action executed. player: " + _loc2_._id + " state: " + this.player.state + " sub state: " + this.player.state.state + " fired " + this.player.fired + " aiming " + (this.player.weapon && this.player.weapon.isAiming() + " controls allowFire: " + (this.player.weapon.controls && this.player.weapon.controls.allowFire)),"PlayerFireAction");
         if(!this.player.fired && this.player.state.state is PlayerActiveAimSubState && this.player.weapon && this.player.weapon.isAiming() && this.player.weapon.controls && Boolean(this.player.weapon.controls.allowFire))
         {
            LogUtils.log("Current player: " + BattleManager.getCurrentActivePlayer());
            this.player.fired = true;
            this.state.fire = true;
            if(BattleManager.isLocalPlayersTurn())
            {
               this.player.checkForShoot = true;
            }
         }
      }
   }
}

