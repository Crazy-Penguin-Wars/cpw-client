package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class ChangeWeaponMessage extends BattleMessage
   {
       
      
      public function ChangeWeaponMessage(weapon:String, id:String)
      {
         super({
            "t":6,
            "id":id,
            "wid":weapon
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
