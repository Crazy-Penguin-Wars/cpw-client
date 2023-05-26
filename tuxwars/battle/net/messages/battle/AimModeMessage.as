package tuxwars.battle.net.messages.battle
{
   import tuxwars.battle.BattleManager;
   
   public class AimModeMessage extends BattleMessage
   {
       
      
      public function AimModeMessage(id:String, weaponName:String)
      {
         super({
            "t":12,
            "id":id,
            "wid":weaponName
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
