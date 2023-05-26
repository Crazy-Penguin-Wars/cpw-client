package tuxwars.battle.net.messages.chat
{
   import tuxwars.battle.net.BattleResponse;
   
   public class LocalChatMessage extends BattleResponse
   {
       
      
      private var _id:String;
      
      private var _tid:String;
      
      public function LocalChatMessage(id:String, tid:String)
      {
         super("{}");
         _id = id;
         _tid = tid;
      }
      
      override public function get responseType() : int
      {
         return 33;
      }
      
      override public function get playerId() : String
      {
         return _id;
      }
      
      override public function get data() : *
      {
         return {
            "tid":_tid,
            "id":_id
         };
      }
   }
}
