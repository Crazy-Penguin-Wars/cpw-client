package tuxwars.battle.states.player
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.battle.*;
   import tuxwars.battle.actions.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.data.*;
   
   public class PlayerActiveState extends PlayerState
   {
      private var keyUpAction:PlayerKeyUpAction;
      
      private var keyDownAction:PlayerKeyDownAction;
      
      public function PlayerActiveState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
         if(BattleManager.isLocalPlayersTurn())
         {
            this.keyUpAction = new PlayerKeyUpAction(param1);
            this.keyDownAction = new PlayerKeyDownAction(param1);
         }
      }
      
      override public function enter() : void
      {
         var _loc2_:PlayerGameObject = null;
         var _loc1_:SoundReference = null;
         super.enter();
         player.idleMode = true;
         if(BattleManager.isLocalPlayersTurn())
         {
            _loc2_ = player;
            MessageCenter.sendEvent(new WalkModeMessage(_loc2_._id));
            player.mode = "WalkMode";
            _loc1_ = Sounds.getSoundReference("PlayerStartTurn");
            if(_loc1_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            }
            MessageCenter.addListener("PlayerFireMode",this.fireModeActivated);
            MessageCenter.addListener("PlayerWalkMode",this.walkModeActivated);
            GameWorld.getInputSystem().addInputAction(this.keyUpAction);
            GameWorld.getInputSystem().addInputAction(this.keyDownAction);
         }
      }
      
      override public function exit() : void
      {
         if(this.keyUpAction)
         {
            GameWorld.getInputSystem().removeInputAction(this.keyUpAction);
            this.keyUpAction = null;
         }
         if(this.keyDownAction)
         {
            GameWorld.getInputSystem().removeInputAction(this.keyDownAction);
            this.keyDownAction = null;
         }
         MessageCenter.removeListener("PlayerFireMode",this.fireModeActivated);
         MessageCenter.removeListener("PlayerWalkMode",this.walkModeActivated);
         player.moveControls.hideControls();
         player.moveControls.upKeyDown = false;
         player.moveControls.leftKeyDown = false;
         player.moveControls.rightKeyDown = false;
         super.exit();
      }
      
      override protected function changeToAimState(param1:String) : void
      {
         player.mode = "AimMode";
         MessageCenter.sendMessage("HelpHudEndShoot");
         MessageCenter.sendMessage("HelpHudCancelMoveTimer");
         changeState(new PlayerActiveAimSubState(player,param1),true);
      }
      
      override protected function changeToFireState() : void
      {
         player.mode = "FireMode";
         changeState(new PlayerActiveFireSubState(player),true);
      }
      
      override protected function changeToWalkState() : void
      {
         player.mode = "WalkMode";
         changeState(new PlayerActiveWalkSubState(player),true);
      }
      
      override public function handleMessage(param1:ActionResponse) : void
      {
         super.handleMessage(param1);
         var _loc2_:PlayerState = state as PlayerState;
         if(_loc2_)
         {
            _loc2_.handleMessage(param1);
         }
         else
         {
            LogUtils.addDebugLine("Player","Active player doesn\'t have valid state. Server message: " + param1.responseType,"PlayerActiveState");
         }
      }
      
      private function fireModeActivated(param1:Message) : void
      {
         var _loc2_:PlayerGameObject = player;
         MessageCenter.sendEvent(new AimModeMessage(_loc2_._id,param1.data as String));
      }
      
      private function walkModeActivated(param1:Message) : void
      {
         player.mode = "WalkMode";
         var _loc2_:PlayerGameObject = player;
         MessageCenter.sendEvent(new WalkModeMessage(_loc2_._id));
      }
   }
}

