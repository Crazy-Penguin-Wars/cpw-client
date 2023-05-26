package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   
   public class ChallengeReachLevelMessage extends Message
   {
       
      
      private var _playerId:String;
      
      public function ChallengeReachLevelMessage(reachedLevel:int, playerId:String)
      {
         super("ChallengeReachedLevel",reachedLevel);
         _playerId = playerId;
      }
      
      public function get reachedLevel() : int
      {
         return data;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
   }
}
