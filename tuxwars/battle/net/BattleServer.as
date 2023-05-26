package tuxwars.battle.net
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public final class BattleServer
   {
      
      private static const XOR_KEY:Vector.<int> = Vector.<int>([30,62,21,119,49,75,39,120,47,85,96,92,96,85,37,85,87,72,98,99,20,64,85,57,106,42,16,92,52,17,65,84,124,114,20,17,99,111,42,43,93,116,24,49,92,62,22,30,51,108,36,92,122,50,83,40,119,59,72,107,75,27,102,40,33,97,9,33,72,124,96,93,50,93,93,117,38,35,2,101,27,35,62,15,109,111,66,57,46,11,68,32,4,105,74,31,94,33,104,66,108,103,12,97,106,81,84,47,104,15,40,81,51,110,11,108,19,122,59,59,80,126,42,101,29,57,1,118,102,89,62,67,14,25,69,111,125,59,94,111,117,32,115,64,26,68,86,106,78,98,54,63,119,6,27,114,66,2,61,55,36,10,18,72,15,73,7,83,114,27,123,37,121,80,26,121,76,59,108,4,6,79,64,96,94,92,25,106,36,99,104,111,62,108,83,19,57,59,82,111,109,81,31,48,44,69,68,94,9,4,51,74,102,15,40,7,25,46,75,87,69,116,15,11,95,57,85,121,26,96,50,10,0,64,44,114,121,103,37,31,50,34,60,117,22,97,107,21,47,80,30,5,82,50,61,35,96,83,49,123,72,62,0,92,87,111,26,86,46,23,105,66,40,126,103,50,79,85,115,105,91,39,88,93,17,16,61,33,74,108,45,91,83,121,69,101,73,75,126,51,98,19,65,32,54,119,76,1,126,43,31,77,113,107,37,60,91,47,117,18,43,100,18,13,28,79,94,104,28,47,47,34,24,14,23,119,117,45,2,31,15,111,116,24,79,19]);
      
      private static const DEBUG_OUTPUT:Boolean = true;
      
      private static const SHOW_WORLD_UPDATE_OUTPUT:Boolean = false;
       
      
      private const socket:Socket = new Socket();
      
      private const byteArray:ByteArray = new ByteArray();
      
      private const xorArray:ByteArray = new ByteArray();
      
      private const inArray:ByteArray = new ByteArray();
      
      private const messageQueue:MessageQueue = new MessageQueue();
      
      private const _responseQueue:ResponseQueue = new ResponseQueue();
      
      private const _messages:Vector.<String> = new Vector.<String>();
      
      private var messageLength:int;
      
      private var _game:TuxWarsGame;
      
      private var receivedBytes:int;
      
      private var sentBytes:int;
      
      private var lastTime:int = -1;
      
      public function BattleServer()
      {
         super();
      }
      
      public function init(tuxGame:TuxWarsGame) : void
      {
         _game = tuxGame;
         receivedBytes = 0;
         sentBytes = 0;
         messageQueue.init(this);
         this._responseQueue.init();
         _messages.splice(0,_messages.length);
         MessageCenter.addListener("Connect",connect);
      }
      
      public function dispose() : void
      {
         LogUtils.log("Received bytes: " + receivedBytes,this,1,"BattleServer",true);
         LogUtils.log("Sent bytes: " + sentBytes,this,1,"BattleServer",true);
         removeListeners();
         _responseQueue.dispose();
         messageQueue.dispose();
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return _game;
      }
      
      public function get messages() : Vector.<String>
      {
         return _messages;
      }
      
      public function isConnected() : Boolean
      {
         return socket.connected;
      }
      
      public function get responseQueue() : ResponseQueue
      {
         return _responseQueue;
      }
      
      public function sendMessage(msg:SocketMessage) : void
      {
         var i:int = 0;
         if(!socket.connected)
         {
            LogUtils.log("Socket not connected when sending a message.",this,2,"BattleServer",true);
            return;
         }
         msg.encode();
         byteArray.clear();
         byteArray.writeUTFBytes(msg.message);
         byteArray.position = 0;
         xorArray.clear();
         var _loc2_:int = byteArray.bytesAvailable;
         for(i = 0; i < _loc2_; )
         {
            xorArray.writeByte(byteArray.readByte() ^ XOR_KEY[i % XOR_KEY.length]);
            i++;
         }
         xorArray.position = 0;
         socket.writeInt(xorArray.length);
         socket.writeBytes(xorArray);
         socket.flush();
         _messages.push("--> [" + getTimer() + "] " + msg.message);
         sentBytes += 4;
         sentBytes += xorArray.length;
         LogUtils.log("Sending message: " + msg.message + " stepTime: " + (!!_game.tuxWorld ? _game.tuxWorld.physicsWorld.stepCount : "-1"),this,1,"BattleServer",false,false,false);
      }
      
      private function connect(msg:BattleServerConnectMessage) : void
      {
         LogUtils.log("Connecting to " + msg.getHost() + ":" + msg.getPort(),this,1,"BattleServer");
         MessageCenter.removeListener("Connect",connect);
         messageLength = -1;
         messageQueue.init(this);
         socket.addEventListener("close",closeHandler,false,0,true);
         socket.addEventListener("connect",connectHandler,false,0,true);
         socket.addEventListener("ioError",ioErrorHandler,false,0,true);
         socket.addEventListener("securityError",securityErrorHandler,false,0,true);
         socket.addEventListener("socketData",socketDataHandler,false,0,true);
         socket.connect(msg.getHost(),msg.getPort());
      }
      
      private function disconnect(event:BattleServerDisconnectMessage) : void
      {
         if(socket.connected)
         {
            LogUtils.log("Disconnecting...",this,1,"BattleServer");
            socket.close();
            dispose();
            MessageCenter.addListener("Connect",connect);
         }
      }
      
      private function removeListeners() : void
      {
         if(socket)
         {
            socket.removeEventListener("close",closeHandler);
            socket.removeEventListener("connect",connectHandler);
            socket.removeEventListener("ioError",ioErrorHandler);
            socket.removeEventListener("securityError",securityErrorHandler);
            socket.removeEventListener("socketData",socketDataHandler);
         }
      }
      
      private function socketDataHandler(event:ProgressEvent = null) : void
      {
         var message:* = null;
         var i:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = getTimer();
         checkForMessageLength();
         while(socket.connected && messageLength > -1 && socket.bytesAvailable >= messageLength)
         {
            inArray.clear();
            socket.readBytes(inArray,0,messageLength);
            inArray.position = 0;
            message = "";
            for(i = 0; i < messageLength; )
            {
               message += String.fromCharCode(inArray.readByte() ^ XOR_KEY[i % XOR_KEY.length]);
               i++;
            }
            _loc2_ = new BattleResponse(message);
            receivedBytes += messageLength;
            if(lastTime == -1)
            {
               lastTime = _loc4_;
            }
            _messages.push("<-- [" + _loc4_ + "] (" + (_loc4_ - lastTime) + ") " + message);
            _responseQueue.addResponse(_loc2_);
            messageLength = -1;
            checkForMessageLength();
            lastTime = _loc4_;
         }
      }
      
      private function checkForMessageLength() : void
      {
         if(messageLength == -1 && socket.connected && socket.bytesAvailable >= 4)
         {
            messageLength = socket.readInt();
            receivedBytes += 4;
         }
      }
      
      private function connectHandler(event:Event) : void
      {
         LogUtils.log("Socket opened.",this,1,"BattleServer");
         MessageCenter.addListener("BattleServerDisconnect",disconnect);
         MessageCenter.sendMessage("ServerConnected");
      }
      
      private function closeHandler(event:Event) : void
      {
         LogUtils.log("Socket closed.",this,1,"BattleServer");
         dispose();
         MessageCenter.removeListener("BattleServerDisconnect",disconnect);
         MessageCenter.addListener("Connect",connect);
         MessageCenter.sendEvent(new ErrorMessage("BattleServer Disconnected","closeHandler","Unknown"));
      }
      
      private function securityErrorHandler(event:SecurityErrorEvent) : void
      {
         LogUtils.log("Socket security error: " + event.toString(),this,3,"BattleServer");
         MessageCenter.sendMessage("BattleServerConnectionFailed");
      }
      
      private function ioErrorHandler(event:IOErrorEvent) : void
      {
         LogUtils.log("Socket I/O error: " + event.toString(),this,3,"BattleServer");
         MessageCenter.sendMessage("BattleServerConnectionFailed");
      }
   }
}
