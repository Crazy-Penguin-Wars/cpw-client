package tuxwars.battle.net.messages.chat
{
   import tuxwars.battle.net.BattleResponse;
   
   public class LocalChatMessage extends BattleResponse
   {
      private var _id:String;
      
      private var _tid:String;
      
      public function LocalChatMessage(param1:String, param2:String)
      {
         super("{}");
         this._id = param1;
         this._tid = param2;
      }
      
      override public function get responseType() : int
      {
         return 33;
      }
      
      override public function get playerId() : String
      {
         return this._id;
      }
      
      override public function get data() : *
      {
         return {
            "tid":this._tid,
            "id":this._id
         };
      }
   }
}

