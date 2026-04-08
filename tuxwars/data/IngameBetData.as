package tuxwars.data
{
   public class IngameBetData
   {
      private static var _currentPayout:int;
      
      private static var _currentBetAmount:int;
      
      public function IngameBetData()
      {
         super();
         throw new Error("IngameBetData is a static class!");
      }
      
      public static function getBetAmount() : int
      {
         return _currentBetAmount;
      }
      
      public static function addToBetAmount(param1:int) : void
      {
         _currentBetAmount += param1;
      }
      
      public static function getPayout() : int
      {
         return _currentPayout;
      }
      
      public static function addToPayout(param1:int) : void
      {
         _currentPayout += param1;
      }
      
      public static function nullValues() : void
      {
         _currentBetAmount = 0;
         _currentPayout = 0;
      }
   }
}

