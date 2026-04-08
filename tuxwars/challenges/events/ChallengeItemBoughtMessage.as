package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   
   public class ChallengeItemBoughtMessage extends Message
   {
      private var _playerId:String;
      
      public function ChallengeItemBoughtMessage(param1:String, param2:String)
      {
         super("ChallengeItemBought",param1);
         this._playerId = param2;
      }
      
      public function get itemId() : String
      {
         return data;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
   }
}

