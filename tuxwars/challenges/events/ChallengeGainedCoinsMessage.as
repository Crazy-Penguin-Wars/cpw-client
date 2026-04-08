package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   
   public class ChallengeGainedCoinsMessage extends Message
   {
      private var _playerId:String;
      
      public function ChallengeGainedCoinsMessage(param1:int, param2:String)
      {
         super("ChallengeGainedCoins",param1);
         this._playerId = param2;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
      
      public function get gainedCoins() : int
      {
         return data;
      }
   }
}

