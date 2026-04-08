package tuxwars.battle.net
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class MessageQueue
   {
      private static const LOCAL_MESSAGE_OUTPUT:Boolean = false;
      
      private const practiceMessages:Vector.<BattleResponse> = new Vector.<BattleResponse>();
      
      private var server:BattleServer;
      
      private var turnChange:Boolean;
      
      public function MessageQueue()
      {
         super();
      }
      
      public function init(param1:BattleServer) : void
      {
         this.server = param1;
         MessageCenter.addListener("SocketMessage",this.messageHandler);
         MessageCenter.addListener("BattleResponse",this.responseHandler);
         LogicUpdater.register(this,"MessageQueue");
      }
      
      public function dispose() : void
      {
         LogicUpdater.unregister(this,"MessageQueue");
         MessageCenter.removeListener("SocketMessage",this.messageHandler);
         MessageCenter.removeListener("BattleResponse",this.responseHandler);
         this.practiceMessages.splice(0,this.practiceMessages.length);
         this.server = null;
      }
      
      public function logicUpdate(param1:int) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:BattleServer = null;
         if(BattleManager.isPracticeMode())
         {
            for each(_loc2_ in this.practiceMessages)
            {
               _loc3_ = this.server;
               _loc3_._responseQueue.addResponse(_loc2_);
            }
            this.practiceMessages.splice(0,this.practiceMessages.length);
         }
      }
      
      private function messageHandler(param1:SocketMessage) : void
      {
         if(Boolean(this.turnChange) && Boolean(SocketMessageTypes.isBattleMessage(param1.messageType)))
         {
            return;
         }
         if(param1.messageType == 16)
         {
            this.turnChange = true;
         }
         if(!BattleManager.isPracticeMode())
         {
            this.server.sendMessage(param1);
            if(param1.sendLocally())
            {
               MessageCenter.sendEvent(new BattleResponse(JSON.stringify(param1.data)));
            }
         }
         else
         {
            this.practiceMessages.push(new BattleResponse(JSON.stringify(param1.data)));
         }
      }
      
      private function responseHandler(param1:BattleResponse) : void
      {
         if(param1.responseType == 17)
         {
            this.turnChange = false;
         }
      }
   }
}

