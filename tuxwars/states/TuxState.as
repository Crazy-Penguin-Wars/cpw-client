package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.states.State;
   import tuxwars.TuxWarsGame;
   
   public class TuxState extends State
   {
       
      
      public function TuxState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return game as TuxWarsGame;
      }
   }
}
