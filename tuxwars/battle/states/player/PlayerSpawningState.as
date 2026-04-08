package tuxwars.battle.states.player
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.states.State;
   import com.dchoc.utils.*;
   import nape.geom.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.states.player.ai.*;
   import tuxwars.data.*;
   
   public class PlayerSpawningState extends PlayerState
   {
      private var allowResuming:Boolean;
      
      public function PlayerSpawningState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         LogUtils.log(player + " Entering PlayerSpawningState, loc: " + player.body.position,null);
         super.enter();
         var _loc1_:Vec2 = Boolean(params.hasOwnProperty("x")) && Boolean(params.hasOwnProperty("y")) ? new Vec2(params.x,params.y) : null;
         player.clearTempHpModifiers();
         player.tag.clear();
         player.respawn(_loc1_,params.r);
         player.body.velocity = Config.ZERO_VEC.copy(true);
         player.body.angularVel = 0;
         player.body.allowRotation = false;
         player.container.visible = true;
         player.changeAnimation("spawn",false);
         player.resetCahcedHP();
         var _loc2_:SoundReference = Sounds.getSoundReference("Respawn");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
         }
      }
      
      override public function allowStateChange(param1:State) : Boolean
      {
         return this.allowResuming;
      }
      
      public function resume() : void
      {
         this.preResume();
         this.allowResuming = true;
         if(BattleManager.getCurrentActivePlayer() == player)
         {
            player.changeState(player.isAI() ? new AIPlayerActiveState(player) : new PlayerActiveState(player),true);
         }
         else
         {
            player.changeState(new PlayerInactiveState(player),true);
         }
      }
      
      private function preResume() : void
      {
         var _loc4_:Tuner = null;
         var _loc5_:PlayerGameObject = null;
         var _loc6_:PlayerGameObject = null;
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:TextEffect = null;
         if(player.suicide)
         {
            player.suicide = false;
            _loc1_ = int(player.getScore() > Math.abs(Tuner.getField("SuicidePenalty").value) ? (_loc4_ = Tuner, Tuner.getField("SuicidePenalty").value) : -player.getScore());
            if(_loc1_ < 0 || Config.isDev())
            {
               player.addScore("Suicide",_loc1_);
               _loc2_ = ProjectManager.getText("SUICIDE_PENALTY",[_loc1_]);
               _loc5_ = player;
               _loc3_ = (_loc5_.game as TuxWarsGame).tuxWorld.addTextEffect(2,_loc2_,player.container.x,player.container.y,false);
               _loc6_ = player;
               (_loc6_.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc3_.movieClip,true,false);
            }
         }
         player.activate();
         MessageCenter.sendMessage("PlayerSpawned",player);
      }
   }
}

