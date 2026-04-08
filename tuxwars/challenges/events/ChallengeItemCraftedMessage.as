package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import no.olog.utilfunctions.*;
   
   public class ChallengeItemCraftedMessage extends Message
   {
      private var _playerId:String;
      
      public function ChallengeItemCraftedMessage(param1:String, param2:String)
      {
         assert("Item is null!",true,param1 != null);
         super("ChallengeItemCrafted",param1);
         this._playerId = param2;
      }
      
      public function get itemID() : String
      {
         return data;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
   }
}

