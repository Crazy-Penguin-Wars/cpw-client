package tuxwars.battle.ui.states.results
{
   import com.dchoc.events.DCSoundEvent;
   import com.dchoc.media.DCSoundManager;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.states.TuxState;
   
   public class ResultsState extends TuxState
   {
       
      
      public function ResultsState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new ResultsLoadAssetsSubState(tuxGame,params));
         var _loc2_:SoundReference = Sounds.getSoundReference("BattleMusic");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType(),"LoopSound"));
         }
         var _loc1_:SoundReference = Sounds.getSoundReference("GameAlmostOver");
         if(_loc1_)
         {
            DCSoundManager.getInstance().addCustomEventListener("soundComplete",startBriefingMusic,_loc1_.getMusicID() + _loc1_.getStart());
         }
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
         var _loc2_:SoundReference = Sounds.getSoundReference("GameAlmostOver");
         if(_loc2_)
         {
            DCSoundManager.getInstance().removeCustomEventListener("soundComplete",startBriefingMusic,_loc2_.getMusicID() + _loc2_.getStart());
         }
         var _loc1_:SoundReference = Sounds.getSoundReference(Sounds.getMainMusicName2());
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",_loc1_.getMusicID(),_loc1_.getLoop(),_loc1_.getType()));
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(tuxGame.tuxWorld)
         {
            tuxGame.tuxWorld.physicsWorld.updateSimulation(deltaTime / 22.22222222222222);
         }
      }
      
      public function startBriefingMusic(event:DCSoundEvent) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference("BriefingMusic");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType()));
         }
      }
   }
}
