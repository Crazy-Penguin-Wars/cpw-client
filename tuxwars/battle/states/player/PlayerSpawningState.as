package tuxwars.battle.states.player
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.states.State;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.states.player.ai.AIPlayerActiveState;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.data.Tuner;
   
   public class PlayerSpawningState extends PlayerState
   {
       
      
      private var allowResuming:Boolean;
      
      public function PlayerSpawningState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
      }
      
      override public function enter() : void
      {
         LogUtils.log(player + " Entering PlayerSpawningState, loc: " + player.body.position,null);
         super.enter();
         var _loc2_:Vec2 = params.hasOwnProperty("x") && params.hasOwnProperty("y") ? new Vec2(params.x,params.y) : null;
         player.clearTempHpModifiers();
         player.tag.clear();
         player.respawn(_loc2_,params.r);
         player.body.velocity = Config.ZERO_VEC.copy(true);
         player.body.angularVel = 0;
         player.body.allowRotation = false;
         player.container.visible = true;
         player.changeAnimation("spawn",false);
         player.resetCahcedHP();
         var _loc1_:SoundReference = Sounds.getSoundReference("Respawn");
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType(),"PlaySound"));
         }
      }
      
      override public function allowStateChange(nextState:State) : Boolean
      {
         return allowResuming;
      }
      
      public function resume() : void
      {
         preResume();
         allowResuming = true;
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
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(player.suicide)
         {
            player.suicide = false;
            var _loc4_:Tuner = Tuner;
            var _loc5_:Tuner;
            _loc3_ = int(player.getScore() > Math.abs(tuxwars.data.Tuner.getField("SuicidePenalty").value) ? (_loc5_ = Tuner, tuxwars.data.Tuner.getField("SuicidePenalty").value) : -player.getScore());
            if(_loc3_ < 0 || Config.isDev())
            {
               player.addScore("Suicide",_loc3_);
               _loc1_ = ProjectManager.getText("SUICIDE_PENALTY",[_loc3_]);
               var _loc6_:PlayerGameObject = player;
               _loc2_ = (_loc6_.game as tuxwars.TuxWarsGame).tuxWorld.addTextEffect(2,_loc1_,player.container.x,player.container.y,false);
               var _loc7_:PlayerGameObject = player;
               (_loc7_.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
            }
         }
         player.activate();
         MessageCenter.sendMessage("PlayerSpawned",player);
      }
   }
}
