package tuxwars.home.states.privategame.host
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.privategame.PrivateGameState;
   
   public class HostPrivateGameState extends PrivateGameState
   {
      public function HostPrivateGameState(param1:TuxWarsGame, param2:PrivateGameModel)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new HostPrivateGameUIState(tuxGame,params));
      }
   }
}

