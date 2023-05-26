package tuxwars.battle.states.player
{
   import com.dchoc.game.GameWorld;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.actions.PlayerKeyDownAction;
   import tuxwars.battle.actions.PlayerKeyUpAction;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.AimModeMessage;
   import tuxwars.battle.net.messages.battle.WalkModeMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
   public class PlayerActiveState extends PlayerState
   {
       
      
      private var keyUpAction:PlayerKeyUpAction;
      
      private var keyDownAction:PlayerKeyDownAction;
      
      public function PlayerActiveState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
         if(BattleManager.isLocalPlayersTurn())
         {
            keyUpAction = new PlayerKeyUpAction(player);
            keyDownAction = new PlayerKeyDownAction(player);
         }
      }
      
      override public function enter() : void
      {
         var _loc1_:* = null;
         super.enter();
         player.idleMode = true;
         if(BattleManager.isLocalPlayersTurn())
         {
            var _loc2_:PlayerGameObject = player;
            MessageCenter.sendEvent(new WalkModeMessage(_loc2_._id));
            player.mode = "WalkMode";
            _loc1_ = Sounds.getSoundReference("PlayerStartTurn");
            if(_loc1_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
            }
            MessageCenter.addListener("PlayerFireMode",fireModeActivated);
            MessageCenter.addListener("PlayerWalkMode",walkModeActivated);
            GameWorld.getInputSystem().addInputAction(keyUpAction);
            GameWorld.getInputSystem().addInputAction(keyDownAction);
         }
      }
      
      override public function exit() : void
      {
         if(keyUpAction)
         {
            GameWorld.getInputSystem().removeInputAction(keyUpAction);
            keyUpAction = null;
         }
         if(keyDownAction)
         {
            GameWorld.getInputSystem().removeInputAction(keyDownAction);
            keyDownAction = null;
         }
         MessageCenter.removeListener("PlayerFireMode",fireModeActivated);
         MessageCenter.removeListener("PlayerWalkMode",walkModeActivated);
         player.moveControls.hideControls();
         player.moveControls.upKeyDown = false;
         player.moveControls.leftKeyDown = false;
         player.moveControls.rightKeyDown = false;
         super.exit();
      }
      
      override protected function changeToAimState(weaponName:String) : void
      {
         player.mode = "AimMode";
         MessageCenter.sendMessage("HelpHudEndShoot");
         MessageCenter.sendMessage("HelpHudCancelMoveTimer");
         changeState(new PlayerActiveAimSubState(player,weaponName),true);
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
      
      override public function handleMessage(response:ActionResponse) : void
      {
         super.handleMessage(response);
         var _loc2_:PlayerState = state as PlayerState;
         if(_loc2_)
         {
            _loc2_.handleMessage(response);
         }
         else
         {
            LogUtils.addDebugLine("Player","Active player doesn\'t have valid state. Server message: " + response.responseType,"PlayerActiveState");
         }
      }
      
      private function fireModeActivated(msg:Message) : void
      {
         var _loc2_:PlayerGameObject = player;
         MessageCenter.sendEvent(new AimModeMessage(_loc2_._id,msg.data as String));
      }
      
      private function walkModeActivated(msg:Message) : void
      {
         player.mode = "WalkMode";
         var _loc2_:PlayerGameObject = player;
         MessageCenter.sendEvent(new WalkModeMessage(_loc2_._id));
      }
   }
}
