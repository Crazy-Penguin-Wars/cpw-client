package tuxwars.home.states.matchloading.battleinit
{
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.states.TuxState;
   
   public class BattleInitManagerSubState extends TuxState
   {
      public function BattleInitManagerSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         BattleManager.setupMatch(BattleLoader.getBattleDuration(),BattleLoader.getTurnDuration(),BattleLoader.isPracticeMode(),BattleLoader.isTournament(),BattleLoader.getPlayers(),BattleLoader.isVIP());
         BattleInitState(parent).initComplete();
      }
   }
}

