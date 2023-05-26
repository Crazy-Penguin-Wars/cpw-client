package tuxwars.battle.net
{
   public class SocketMessageTypes
   {
      
      public static const UPDATE_WORLD:int = 1;
      
      public static const AIM:int = 2;
      
      public static const CHANGE_WEAPON:int = 6;
      
      public static const FIRE_WEAPON:int = 10;
      
      public static const MOVE:int = 7;
      
      public static const STOP:int = 3;
      
      public static const JUMP:int = 4;
      
      public static const JUMP_FINISHED:int = 5;
      
      public static const AIM_MODE:int = 12;
      
      public static const WALK_MODE:int = 8;
      
      public static const FIRE_MODE:int = 11;
      
      public static const EMIT:int = 9;
      
      public static const DIE:int = 35;
      
      public static const ADD_POWER_UP:int = 36;
      
      public static const USE_BOOSTER:int = 34;
      
      public static const REMAINING_CLIENTS:int = 22;
      
      public static const SIMPLE_SCRIPT:int = 55;
      
      private static const AIM_STR:String = "Aim";
      
      private static const CHANGE_WEAPON_STR:String = "Change Weapon";
      
      private static const FIRE_WEAPON_STR:String = "Fire Weapon";
      
      private static const MOVE_STR:String = "Move";
      
      private static const STOP_STR:String = "Stop";
      
      private static const JUMP_STR:String = "Jump";
      
      private static const JUMP_FINISHED_STR:String = "Jump Finished";
      
      private static const AIM_MODE_STR:String = "Aim Mode";
      
      private static const WALK_MODE_STR:String = "Walk Mode";
      
      private static const FIRE_MODE_STR:String = "Fire Mode";
      
      private static const EMIT_STR:String = "Emit";
      
      private static const DIE_STR:String = "Die";
      
      private static const ADD_POWER_UP_STR:String = "Add PowerUp";
      
      private static const USE_BOOSTER_STR:String = "Use Booster";
      
      private static const REMAINING_CLIENTS_STR:String = "Remaining Clients";
      
      private static const SIMPLE_SCRIPT_STR:String = "Simple Script";
      
      public static const PURCHASE:int = 18;
      
      public static const GAME_READY:int = 21;
      
      public static const CONNECT_BS:int = 26;
      
      public static const CONNECT_MM:int = 29;
      
      public static const CLIENT_READY:int = 15;
      
      public static const BET:int = 23;
      
      public static const START_TURN:int = 17;
      
      public static const END_TURN:int = 16;
      
      public static const ERROR:int = 25;
      
      public static const END_GAME:int = 19;
      
      public static const GAME_TERMINATED:int = 24;
      
      public static const END_GAME_CONFIRM:int = 20;
      
      public static const USE_EMOTICON:int = 13;
      
      public static const START_GAME:int = 32;
      
      public static const REMATCH_RESPONSE:int = 41;
      
      public static const REMATCH_REQUEST:int = 40;
      
      public static const CHICKENING_OUT:int = 60;
      
      public static const ENABLE_BOOSTERS:int = 37;
      
      public static const INGAME_BET_PLACE_BET:int = 50;
      
      public static const INGAME_BET_MULTIPLIER_UPDATED:int = 51;
      
      public static const HISTORY:int = 14;
      
      public static const CHAT:int = 33;
      
      public static const BATTLE_SERVER:int = 27;
      
      public static const PRIVATE_GAME_RESPONSE:int = 31;
      
      public static const CHANGE_SETTINGS:int = 28;
      
      public static const GAME_SETTINGS:int = 30;
      
      public static const RESPONSE:String = "BattleResponse";
      
      public static const SERVER_CONNECTED:String = "ServerConnected";
      
      public static const BATTLE_MESSAGES:Array = [1,9,2,7,3,4,5,6,11,10,12,8,35,36,34,22,55];
      
      public static const CONTROL_MESSAGES:Array = [21,26,29,15,17,19,20,24,16,25,18,13,60,27,23,41,40,37,50,51];
       
      
      public function SocketMessageTypes()
      {
         super();
      }
      
      public static function isBattleMessage(type:int) : Boolean
      {
         return BATTLE_MESSAGES.indexOf(type) != -1;
      }
      
      public static function isControlMessage(type:int) : Boolean
      {
         return CONTROL_MESSAGES.indexOf(type) != -1;
      }
      
      public static function toString(type:int) : String
      {
         switch(type)
         {
            case 2:
               return "Aim";
            case 6:
               return "Change Weapon";
            case 10:
               return "Fire Weapon";
            case 7:
               return "Move";
            case 3:
               return "Stop";
            case 4:
               return "Jump";
            case 5:
               return "Jump Finished";
            case 12:
               return "Aim Mode";
            case 8:
               return "Walk Mode";
            case 11:
               return "Fire Mode";
            case 9:
               return "Emit";
            case 35:
               return "Die";
            case 36:
               return "Add PowerUp";
            case 22:
               return "Remaining Clients";
            case 34:
               return "Use Booster";
            case 55:
               return "Simple Script";
            default:
               return "Unknown type: " + type;
         }
      }
   }
}
