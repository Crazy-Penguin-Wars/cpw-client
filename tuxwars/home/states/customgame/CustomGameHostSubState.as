package tuxwars.home.states.customgame
{
   import com.dchoc.net.ServerRequest;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.privategame.host.*;
   import tuxwars.states.TuxState;
   
   public class CustomGameHostSubState extends CustomGameConnectSubState
   {
      public function CustomGameHostSubState(param1:TuxWarsGame, param2:String, param3:ServerRequest)
      {
         super(param1,param2,param3);
      }
      
      override protected function get isOwner() : Boolean
      {
         return true;
      }
      
      override protected function get nextState() : TuxState
      {
         return new HostPrivateGameState(tuxGame,createGameModel(params));
      }
   }
}

