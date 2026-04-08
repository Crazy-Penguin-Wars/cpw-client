package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.states.State;
   import tuxwars.*;
   
   public class TuxState extends State
   {
      public function TuxState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return game as TuxWarsGame;
      }
   }
}

