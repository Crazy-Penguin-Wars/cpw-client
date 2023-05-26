package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import no.olog.utilfunctions.assert;
   
   public class ChallengeItemCraftedMessage extends Message
   {
       
      
      private var _playerId:String;
      
      public function ChallengeItemCraftedMessage(itemID:String, playerId:String)
      {
         assert("Item is null!",true,itemID != null);
         super("ChallengeItemCrafted",itemID);
         _playerId = playerId;
      }
      
      public function get itemID() : String
      {
         return data;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
   }
}
