package tuxwars.home.states.privategame.host
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.privategame.PrivateGameState;
   
   public class HostPrivateGameState extends PrivateGameState
   {
       
      
      public function HostPrivateGameState(game:TuxWarsGame, gameModel:PrivateGameModel)
      {
         super(game,gameModel);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new HostPrivateGameUIState(tuxGame,params));
      }
   }
}
