package tuxwars.home.states.equipment
{
   import com.dchoc.game.DCGame;
   import tuxwars.states.TuxState;
   
   public class EquipmentState extends TuxState
   {
      public function EquipmentState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new EquipmentLoadAssetsSubState(tuxGame));
      }
   }
}

