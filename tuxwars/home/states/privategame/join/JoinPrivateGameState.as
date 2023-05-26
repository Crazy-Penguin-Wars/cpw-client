package tuxwars.home.states.privategame.join
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.privategame.PrivateGameState;
   
   public class JoinPrivateGameState extends PrivateGameState
   {
       
      
      public function JoinPrivateGameState(game:TuxWarsGame, gameModel:PrivateGameModel)
      {
         super(game,gameModel);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new JoinPrivateGameUIState(tuxGame,params));
      }
   }
}
