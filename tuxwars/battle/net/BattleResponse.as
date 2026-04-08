package tuxwars.battle.net
{
   import com.dchoc.messages.Message;
   
   public class BattleResponse extends Message
   {
      private var _responseText:String;
      
      public function BattleResponse(param1:String)
      {
         super("BattleResponse",JSON.parse(param1));
         this._responseText = param1;
      }
      
      public function get responseText() : String
      {
         return this._responseText;
      }
      
      public function get responseType() : int
      {
         return data.t;
      }
      
      public function set responseType(param1:int) : void
      {
         data.t = param1;
      }
      
      public function get playerId() : String
      {
         return data.id;
      }
      
      public function isQueued() : Boolean
      {
         switch(this.responseType)
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
            case 60:
               return false;
            default:
               return true;
         }
      }
   }
}

