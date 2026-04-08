package tuxwars.battle.states.weapon
{
   import com.dchoc.game.DCGame;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.states.TuxState;
   
   public class WeaponState extends TuxState
   {
      private var _weapon:Weapon;
      
      public function WeaponState(param1:Weapon, param2:DCGame, param3:* = null)
      {
         super(param2,param3);
         assert("Weapon is null.",true,param1 != null);
         this._weapon = param1;
      }
      
      override public function exit() : void
      {
         super.exit();
         this._weapon = null;
      }
      
      public function get weapon() : Weapon
      {
         return this._weapon;
      }
   }
}

