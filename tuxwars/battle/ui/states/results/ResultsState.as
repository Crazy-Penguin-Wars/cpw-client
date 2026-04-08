package tuxwars.battle.ui.states.results
{
   import com.dchoc.events.DCSoundEvent;
   import com.dchoc.media.*;
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.states.TuxState;
   
   public class ResultsState extends TuxState
   {
      public function ResultsState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new ResultsLoadAssetsSubState(tuxGame,params));
         var _loc1_:SoundReference = Sounds.getSoundReference("BattleMusic");
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc1_.getMusicID(),_loc1_.getLoop(),_loc1_.getType(),"LoopSound"));
         }
         var _loc2_:SoundReference = Sounds.getSoundReference("GameAlmostOver");
         if(_loc2_)
         {
            DCSoundManager.getInstance().addCustomEventListener("soundComplete",this.startBriefingMusic,_loc2_.getMusicID() + _loc2_.getStart());
         }
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
         var _loc1_:SoundReference = Sounds.getSoundReference("GameAlmostOver");
         if(_loc1_)
         {
            DCSoundManager.getInstance().removeCustomEventListener("soundComplete",this.startBriefingMusic,_loc1_.getMusicID() + _loc1_.getStart());
         }
         var _loc2_:SoundReference = Sounds.getSoundReference(Sounds.getMainMusicName2());
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType()));
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(tuxGame.tuxWorld)
         {
            tuxGame.tuxWorld.physicsWorld.updateSimulation(param1 / 22.22222222222222);
         }
      }
      
      public function startBriefingMusic(param1:DCSoundEvent) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference("BriefingMusic");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType()));
         }
      }
   }
}

