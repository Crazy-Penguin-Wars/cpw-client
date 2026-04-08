package tuxwars
{
   public class GameSettings
   {
      private static var showAllWeaponsInPractice:Boolean;
      
      public function GameSettings()
      {
         super();
         throw new Error("GameSettings is a static class!");
      }
      
      public static function setShowAllWeaponsInPractice(param1:Boolean) : void
      {
         showAllWeaponsInPractice = param1;
      }
      
      public static function getShowAllWeaponsInPractice() : Boolean
      {
         return showAllWeaponsInPractice;
      }
   }
}

