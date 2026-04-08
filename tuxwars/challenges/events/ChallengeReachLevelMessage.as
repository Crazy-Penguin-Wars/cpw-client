package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   
   public class ChallengeReachLevelMessage extends Message
   {
      private var _playerId:String;
      
      public function ChallengeReachLevelMessage(param1:int, param2:String)
      {
         super("ChallengeReachedLevel",param1);
         this._playerId = param2;
      }
      
      public function get reachedLevel() : int
      {
         return data;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
   }
}

