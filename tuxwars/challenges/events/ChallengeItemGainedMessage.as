package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import no.olog.utilfunctions.*;
   import tuxwars.items.Item;
   import tuxwars.player.TuxFriend;
   
   public class ChallengeItemGainedMessage extends Message
   {
      private var _gainedAmount:int;
      
      private var _player:TuxFriend;
      
      public function ChallengeItemGainedMessage(param1:TuxFriend, param2:Item, param3:int)
      {
         assert("recipeItem is null!",true,param2 != null);
         super("ChallengeItemGained",param2);
         this._gainedAmount = param3;
         this._player = param1;
      }
      
      public function get item() : Item
      {
         return data;
      }
      
      public function get gainedAmount() : int
      {
         return this._gainedAmount;
      }
      
      public function get player() : TuxFriend
      {
         return this._player;
      }
   }
}

