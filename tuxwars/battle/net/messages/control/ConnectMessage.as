package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ConnectMessage extends SocketMessage
   {
      public static const GAME_TYPE_BATTLE_SERVER_NO_NEED:int = 0;
      
      public static const GAME_TYPE_NORMAL_GAME:int = 1;
      
      public static const GAME_TYPE_CUSTOM_GAME:int = 2;
      
      public static const GAME_TYPE_REMATCH_GAME:int = 3;
      
      public function ConnectMessage(param1:int, param2:String, param3:String, param4:int, param5:int, param6:String = null, param7:Boolean = true, param8:String = null, param9:int = 0, param10:String = null)
      {
         var _loc11_:Object = {
            "t":param1,
            "key":param2,
            "id":param3,
            "game_type":param4,
            "bet_id":param10
         };
         if(param1 == 29)
         {
            _loc11_["os"] = param5;
         }
         if(param6 != null)
         {
            _loc11_["game_name"] = param6;
            _loc11_["owner"] = param7;
         }
         else if(param8 != null)
         {
            _loc11_["game_identifier"] = param8;
            _loc11_["player_count"] = param9;
         }
         super(_loc11_);
      }
   }
}

