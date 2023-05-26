package tuxwars
{
   public class TuxErrorCodes
   {
      
      public static const UNSPECIFIED:String = "Unspecified";
      
      public static const USER_GENERATED:String = "UserGenerated";
      
      public static const BATTLE_EXCEPTION:String = "Battle Exception";
      
      public static const SERVER_DISCONNECTED:String = "BattleServer Disconnected";
      
      public static const SOCKET_SECURITY_ERROR:String = "Socket Security Error";
      
      public static const SOCKET_IO_ERROR:String = "Socket I/O Error";
      
      public static const LEVEL_LOADING_ERROR:String = "Level Loading Error";
      
      public static const STAT_BONUS_FORMATTING_ERROR:String = "Stat Bonus Formatting Error";
      
      public static const INVENTORY_ERROR:String = "Inventory Error";
      
      public static const ITEM_ERROR:String = "Item Error";
      
      public static const TYPE_ERROR:String = "Type Error";
      
      public static const ROW_ERROR:String = "Row Error";
      
      public static const PARTICLE_LOADING_ERROR:String = "Particle Loading Error";
      
      public static const RECIPER_RESULT_ERROR:String = "Reciper Result Error";
       
      
      public function TuxErrorCodes()
      {
         super();
         throw new Error("ErrorCodes is a static class!");
      }
   }
}
