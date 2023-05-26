package tuxwars.home.states.equipment
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class EquipmentState extends TuxState
   {
       
      
      public function EquipmentState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new EquipmentLoadAssetsSubState(tuxGame));
      }
   }
}
