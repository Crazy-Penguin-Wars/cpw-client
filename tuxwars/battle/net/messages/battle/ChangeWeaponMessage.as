package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.*;
   
   public class ChangeWeaponMessage extends BattleMessage
   {
      public function ChangeWeaponMessage(param1:String, param2:String)
      {
         super({
            "t":6,
            "id":param2,
            "wid":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

