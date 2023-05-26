package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractMouseInputAction;
   import com.dchoc.utils.LogUtils;
   import flash.events.Event;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.states.player.PlayerActiveAimSubState;
   
   public class PlayerFireAction extends AbstractMouseInputAction
   {
       
      
      private var player:PlayerGameObject;
      
      private var state:PlayerActiveAimSubState;
      
      public function PlayerFireAction(player:PlayerGameObject, state:PlayerActiveAimSubState)
      {
         super("mouseUp");
         this.player = player;
         this.state = state;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         player = null;
         state = null;
      }
      
      override public function execute(event:Event) : void
      {
         if(!player || !state)
         {
            return;
         }
         var _loc2_:PlayerGameObject = player;
         LogUtils.log("Action executed. player: " + _loc2_._id + " state: " + player.state + " sub state: " + player.state.state + " fired " + player.fired + " aiming " + (player.weapon && player.weapon.isAiming() + " controls allowFire: " + (player.weapon.controls && player.weapon.controls.allowFire)),"PlayerFireAction");
         if(!player.fired && player.state.state is PlayerActiveAimSubState && player.weapon && player.weapon.isAiming() && player.weapon.controls && player.weapon.controls.allowFire)
         {
            LogUtils.log("Current player: " + BattleManager.getCurrentActivePlayer());
            player.fired = true;
            state.fire = true;
            if(BattleManager.isLocalPlayersTurn())
            {
               player.checkForShoot = true;
            }
         }
      }
   }
}
