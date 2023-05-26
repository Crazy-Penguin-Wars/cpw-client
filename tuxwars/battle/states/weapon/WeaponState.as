package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.states.TuxState;
   
   public class WeaponState extends TuxState
   {
       
      
      private var _weapon:Weapon;
      
      public function WeaponState(__weapon:Weapon, game:DCGame, params:* = null)
      {
         super(game,params);
         assert("Weapon is null.",true,__weapon != null);
         _weapon = __weapon;
      }
      
      override public function exit() : void
      {
         super.exit();
         _weapon = null;
      }
      
      public function get weapon() : Weapon
      {
         return _weapon;
      }
   }
}
