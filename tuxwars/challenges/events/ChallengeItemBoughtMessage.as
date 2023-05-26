package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   
   public class ChallengeItemBoughtMessage extends Message
   {
       
      
      private var _playerId:String;
      
      public function ChallengeItemBoughtMessage(itemType:String, playerId:String)
      {
         super("ChallengeItemBought",itemType);
         _playerId = playerId;
      }
      
      public function get itemId() : String
      {
         return data;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
   }
}
