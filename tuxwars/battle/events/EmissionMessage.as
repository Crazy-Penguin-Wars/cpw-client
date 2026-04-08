package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.emitters.Emission;
   
   public class EmissionMessage extends Message
   {
      private var _playerId:String;
      
      public function EmissionMessage(param1:Emission, param2:String)
      {
         super("EmissionNotification",param1);
         this._playerId = param2;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
      
      public function set playerId(param1:String) : void
      {
         this._playerId = param1;
      }
   }
}

