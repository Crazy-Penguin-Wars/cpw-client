package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   
   public class ChallengeBoosterUsedMessage extends Message
   {
       
      
      private var _playerId:String;
      
      public function ChallengeBoosterUsedMessage(boosterId:String, playerId:String)
      {
         super("ChallengeBoosterUsed",boosterId);
         _playerId = playerId;
      }
      
      public function get boosterId() : String
      {
         return data;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
   }
}
