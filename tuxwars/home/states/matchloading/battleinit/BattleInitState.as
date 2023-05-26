package tuxwars.home.states.matchloading.battleinit
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.states.TuxBattleState;
   import tuxwars.states.TuxState;
   
   public class BattleInitState extends TuxState
   {
       
      
      public function BattleInitState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new BattleInitWorldSubState(tuxGame));
      }
      
      public function initComplete() : void
      {
         tuxGame.changeState(new TuxBattleState(tuxGame));
      }
   }
}
