package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ConnectMessage extends SocketMessage
   {
      
      public static const GAME_TYPE_BATTLE_SERVER_NO_NEED:int = 0;
      
      public static const GAME_TYPE_NORMAL_GAME:int = 1;
      
      public static const GAME_TYPE_CUSTOM_GAME:int = 2;
      
      public static const GAME_TYPE_REMATCH_GAME:int = 3;
       
      
      public function ConnectMessage(type:int, key:String, id:String, gameType:int, os:int, gameName:String = null, owner:Boolean = true, gameIdentifier:String = null, playerCount:int = 0, betId:String = null)
      {
         var data:Object = {
            "t":type,
            "key":key,
            "id":id,
            "game_type":gameType,
            "bet_id":betId
         };
         if(type == 29)
         {
            data["os"] = os;
         }
         if(gameName != null)
         {
            data["game_name"] = gameName;
            data["owner"] = owner;
         }
         else if(gameIdentifier != null)
         {
            data["game_identifier"] = gameIdentifier;
            data["player_count"] = playerCount;
         }
         super(data);
      }
   }
}
