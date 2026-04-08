package tuxwars.home.states.matchloading.levelloading
{
   import com.dchoc.messages.*;
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.events.*;
   import tuxwars.home.states.matchloading.battleinit.*;
   import tuxwars.states.TuxState;
   
   public class LevelLoadingSubState extends TuxState
   {
      private var vip:Boolean;
      
      private var tournament:Boolean;
      
      public function LevelLoadingSubState(param1:TuxWarsGame, param2:Object, param3:Boolean, param4:Boolean)
      {
         super(param1,param2);
         this.vip = param3;
         this.tournament = param4;
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_LEVEL"));
         BattleLoader.load(params,tuxGame.player,this.vip,this.tournament);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(BattleLoader.isLoaded())
         {
            parent.changeState(new BattleInitState(tuxGame));
            BattleManager.setRandomSeed(BattleLoader.getSeed());
         }
      }
   }
}

