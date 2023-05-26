package tuxwars.battle.net
{
   import com.dchoc.messages.Message;
   
   public class BattleResponse extends Message
   {
       
      
      private var _responseText:String;
      
      public function BattleResponse(msg:String)
      {
         super("BattleResponse",JSON.parse(msg));
         _responseText = msg;
      }
      
      public function get responseText() : String
      {
         return _responseText;
      }
      
      public function get responseType() : int
      {
         return data.t;
      }
      
      public function set responseType(type:int) : void
      {
         data.t = type;
      }
      
      public function get playerId() : String
      {
         return data.id;
      }
      
      public function isQueued() : Boolean
      {
         switch(responseType)
         {
            case 21:
            case 17:
            case 16:
            case 19:
            case 20:
            case 24:
            case 25:
            case 15:
            case 23:
            case 18:
            case 13:
            case 33:
            case 27:
            case 31:
            case 30:
            case 40:
            case 41:
            case 37:
            case 51:
            case 50:
               break;
            case 60:
               break;
            default:
               return true;
         }
         return false;
      }
   }
}
