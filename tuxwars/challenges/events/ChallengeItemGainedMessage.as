package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.Item;
   import tuxwars.player.TuxFriend;
   
   public class ChallengeItemGainedMessage extends Message
   {
       
      
      private var _gainedAmount:int;
      
      private var _player:TuxFriend;
      
      public function ChallengeItemGainedMessage(player:TuxFriend, item:Item, gainedAmount:int)
      {
         assert("recipeItem is null!",true,item != null);
         super("ChallengeItemGained",item);
         _gainedAmount = gainedAmount;
         _player = player;
      }
      
      public function get item() : Item
      {
         return data;
      }
      
      public function get gainedAmount() : int
      {
         return _gainedAmount;
      }
      
      public function get player() : TuxFriend
      {
         return _player;
      }
   }
}
