package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.emitters.Emission;
   
   public class EmissionMessage extends Message
   {
       
      
      private var _playerId:String;
      
      public function EmissionMessage(emission:Emission, playerId:String)
      {
         super("EmissionNotification",emission);
         _playerId = playerId;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
      
      public function set playerId(value:String) : void
      {
         _playerId = value;
      }
   }
}
