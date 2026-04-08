package tuxwars.home.states.privategame.join
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.privategame.PrivateGameState;
   
   public class JoinPrivateGameState extends PrivateGameState
   {
      public function JoinPrivateGameState(param1:TuxWarsGame, param2:PrivateGameModel)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new JoinPrivateGameUIState(tuxGame,params));
      }
   }
}

