package tuxwars.battle.net
{
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.battle.BattleManager;
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
      
      public function init(server:BattleServer) : void
      {
         this.server = server;
         MessageCenter.addListener("SocketMessage",messageHandler);
         MessageCenter.addListener("BattleResponse",responseHandler);
         LogicUpdater.register(this,"MessageQueue");
      }
      
      public function dispose() : void
      {
         LogicUpdater.unregister(this,"MessageQueue");
         MessageCenter.removeListener("SocketMessage",messageHandler);
         MessageCenter.removeListener("BattleResponse",responseHandler);
         practiceMessages.splice(0,practiceMessages.length);
         server = null;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         if(BattleManager.isPracticeMode())
         {
            for each(var response in practiceMessages)
            {
               var _loc3_:BattleServer = server;
               _loc3_._responseQueue.addResponse(response);
            }
            practiceMessages.splice(0,practiceMessages.length);
         }
      }
      
      private function messageHandler(message:SocketMessage) : void
      {
         if(turnChange && SocketMessageTypes.isBattleMessage(message.messageType))
         {
            return;
         }
         if(message.messageType == 16)
         {
            turnChange = true;
         }
         if(!BattleManager.isPracticeMode())
         {
            server.sendMessage(message);
            if(message.sendLocally())
            {
               MessageCenter.sendEvent(new BattleResponse(JSON.stringify(message.data)));
            }
         }
         else
         {
            practiceMessages.push(new BattleResponse(JSON.stringify(message.data)));
         }
      }
      
      private function responseHandler(response:BattleResponse) : void
      {
         if(response.responseType == 17)
         {
            turnChange = false;
         }
      }
   }
}
