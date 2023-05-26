package tuxwars.battle.net
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.data.BattleOptions;
   
   public class ResponseQueue
   {
       
      
      private const queue:Vector.<BattleResponse> = new Vector.<BattleResponse>();
      
      private var queueSupport:Boolean;
      
      public function ResponseQueue()
      {
         super();
      }
      
      public function init() : void
      {
         var _loc1_:BattleOptions = BattleOptions;
         queueSupport = tuxwars.battle.data.BattleOptions.getRow().findField("MessageQueue").value;
      }
      
      public function dispose() : void
      {
         queue.splice(0,queue.length);
      }
      
      public function addResponse(response:BattleResponse) : void
      {
         LogUtils.log(response.responseText,this,1,"ReceivedMessage",false,false,false);
         if(queueSupport && response.isQueued())
         {
            queue.push(response);
            if(response.responseType == 1)
            {
               MessageCenter.sendEvent(new UpdateGameWorldMessage(queue.splice(0,queue.length)));
            }
         }
         else
         {
            MessageCenter.sendEvent(response);
         }
      }
      
      public function get empty() : Boolean
      {
         return queue.length == 0;
      }
   }
}
