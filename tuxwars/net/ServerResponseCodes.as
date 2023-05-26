package tuxwars.net
{
   public class ServerResponseCodes
   {
      
      public static const RESPONSE_OK:int = 0;
      
      public static const NOT_ENOUGH_CURRENCY:int = 11;
      
      public static const WORN_ITEM_NOT_FOUND:int = 1002;
      
      public static const BATTLE_LOCK:int = 1070;
      
      public static const NO_BATTLE_IN_PROGRESS:int = 1071;
      
      public static const ITEM_ALREADY_UNLOCKED:int = 1017;
      
      public static const NO_LEVEL_UP_SALES:int = 1027;
      
      public static const ACCOUNT_NOT_FOUND:int = 2;
      
      public static const INTERNAL_SERVER_NOT_READY:int = 1070;
       
      
      public function ServerResponseCodes()
      {
         super();
      }
   }
}
