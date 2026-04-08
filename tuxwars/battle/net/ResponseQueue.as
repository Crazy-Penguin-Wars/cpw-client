package tuxwars.battle.net
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.battle.data.*;
   
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
         this.queueSupport = BattleOptions.getRow().findField("MessageQueue").value;
      }
      
      public function dispose() : void
      {
         this.queue.splice(0,this.queue.length);
      }
      
      public function addResponse(param1:BattleResponse) : void
      {
         LogUtils.log(param1.responseText,this,1,"ReceivedMessage",false,false,false);
         if(Boolean(this.queueSupport) && param1.isQueued())
         {
            this.queue.push(param1);
            if(param1.responseType == 1)
            {
               MessageCenter.sendEvent(new UpdateGameWorldMessage(this.queue.splice(0,this.queue.length)));
            }
         }
         else
         {
            MessageCenter.sendEvent(param1);
         }
      }
      
      public function get empty() : Boolean
      {
         return this.queue.length == 0;
      }
   }
}

