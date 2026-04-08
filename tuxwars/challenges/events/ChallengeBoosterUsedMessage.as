package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   
   public class ChallengeBoosterUsedMessage extends Message
   {
      private var _playerId:String;
      
      public function ChallengeBoosterUsedMessage(param1:String, param2:String)
      {
         super("ChallengeBoosterUsed",param1);
         this._playerId = param2;
      }
      
      public function get boosterId() : String
      {
         return data;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
   }
}

