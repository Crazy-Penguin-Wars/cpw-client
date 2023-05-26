package tuxwars.home.states.matchloading.battleinit
{
   import tuxwars.BattleLoader;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.states.TuxState;
   
   public class BattleInitManagerSubState extends TuxState
   {
       
      
      public function BattleInitManagerSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         BattleManager.setupMatch(BattleLoader.getBattleDuration(),BattleLoader.getTurnDuration(),BattleLoader.isPracticeMode(),BattleLoader.isTournament(),BattleLoader.getPlayers(),BattleLoader.isVIP());
         BattleInitState(parent).initComplete();
      }
   }
}
