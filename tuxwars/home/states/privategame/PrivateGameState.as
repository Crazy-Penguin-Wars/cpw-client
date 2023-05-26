package tuxwars.home.states.privategame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.states.TuxState;
   
   public class PrivateGameState extends TuxState
   {
       
      
      public function PrivateGameState(game:TuxWarsGame, gameModel:PrivateGameModel)
      {
         super(game,gameModel);
      }
      
      override public function enter() : void
      {
         super.enter();
      }
   }
}
