package tuxwars.battle.states.player
{
   import com.dchoc.messages.*;
   import com.dchoc.states.State;
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.data.*;
   
   public class PlayerDeadState extends PlayerState
   {
      public function PlayerDeadState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         LogUtils.log(player + " Entering PlayerDeadState, loc: " + player.body.position,this,1,"Player",false,false,false);
         super.enter();
         player.body.velocity = Config.ZERO_VEC.copy(true);
         player.body.angularVel = 0;
         player.body.allowRotation = false;
         player.moveControls.hideControls();
         player.moveControls.upKeyDown = false;
         player.moveControls.leftKeyDown = false;
         player.moveControls.rightKeyDown = false;
         player.changeWeapon(null);
         player.direction = 1;
         player.changeAnimation("dying",false,this.animFinished);
         var _loc1_:SoundReference = Sounds.getSoundReference("Dead");
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
         }
      }
      
      override public function exit() : void
      {
         player.container.visible = false;
         player.avatar.paperDoll.animation.clearCallback();
         super.exit();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         player.updateHealthBar(param1);
      }
      
      override public function allowStateChange(param1:State) : Boolean
      {
         return param1 is PlayerSpawningState;
      }
      
      private function animFinished() : void
      {
         player.avatar.paperDoll.animation.clip.stop();
      }
   }
}

