package tuxwars.home.states.customgame
{
   import com.dchoc.net.ServerRequest;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.privategame.host.HostPrivateGameState;
   import tuxwars.states.TuxState;
   
   public class CustomGameHostSubState extends CustomGameConnectSubState
   {
       
      
      public function CustomGameHostSubState(game:TuxWarsGame, gameName:String, request:ServerRequest)
      {
         super(game,gameName,request);
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
