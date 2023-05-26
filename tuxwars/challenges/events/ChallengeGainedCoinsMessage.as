package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   
   public class ChallengeGainedCoinsMessage extends Message
   {
       
      
      private var _playerId:String;
      
      public function ChallengeGainedCoinsMessage(gainedCoins:int, playerId:String)
      {
         super("ChallengeGainedCoins",gainedCoins);
         _playerId = playerId;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
      
      public function get gainedCoins() : int
      {
         return data;
      }
   }
}
