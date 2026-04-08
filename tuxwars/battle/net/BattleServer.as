package tuxwars.battle.net
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.*;
   import flash.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public final class BattleServer
   {
      private static const DEBUG_OUTPUT:Boolean = true;
      
      private static const SHOW_WORLD_UPDATE_OUTPUT:Boolean = false;
      
      private static const XOR_KEY:Vector.<int> = Vector.<int>([30,62,21,119,49,75,39,120,47,85,96,92,96,85,37,85,87,72,98,99,20,64,85,57,106,42,16,92,52,17,65,84,124,114,20,17,99,111,42,43,93,116,24,49,92,62,22,30,51,108,36,92,122,50,83,40,119,59,72,107,75,27,102,40,33,97,9,33,72,124,96,93,50,93,93,117,38,35,2,101,27,35,62,15,109,111,66,57,46,11,68,32,4,105,74,31,94,33,104,66,108,103,12,97,106,81,84,47,104,15,40,81,51,110,11,108,19,122,59,59,80,126,42,101,29,57,1,118,102,89,62,67,14,25,69,111,125,59,94,111,117,32,115,64,26,68,86,106,78,98,54,63,119,6,27,114,66,2,61,55,36,10,18,72,15,73,7,83,114,27,123,37,121,80,26,121,76,59,108,4,6,79,64,96,94,92,25,106,36,99,104,111,62,108,83,19,57,59,82,111,109,81,31,48,44,69,68,94,9,4,51,74,102,15,40,7,25,46,75,87,69,116,15,11,95,57,85,121,26,96,50,10,0,64,44,114,121,103,37,31,50,34,60,117,22,97,107,21,47,80,30,5,82,50,61,35,96,83,49,123,72,62,0,92,87,111,26,86,46,23,105,66,40,126,103,50,79,85,115,105,91,39,88,93,17,16,61,33,74,108,45,91,83,121,69,101,73,75
      ,126,51,98,19,65,32,54,119,76,1,126,43,31,77,113,107,37,60,91,47,117,18,43,100,18,13,28,79,94,104,28,47,47,34,24,14,23,119,117,45,2,31,15,111,116,24,79,19]);
      
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
      
      public function init(param1:TuxWarsGame) : void
      {
         this._game = param1;
         this.receivedBytes = 0;
         this.sentBytes = 0;
         this.messageQueue.init(this);
         this._responseQueue.init();
         this._messages.splice(0,this._messages.length);
         MessageCenter.addListener("Connect",this.connect);
      }
      
      public function dispose() : void
      {
         LogUtils.log("Received bytes: " + this.receivedBytes,this,1,"BattleServer",true);
         LogUtils.log("Sent bytes: " + this.sentBytes,this,1,"BattleServer",true);
         this.removeListeners();
         this._responseQueue.dispose();
         this.messageQueue.dispose();
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return this._game;
      }
      
      public function get messages() : Vector.<String>
      {
         return this._messages;
      }
      
      public function isConnected() : Boolean
      {
         return this.socket.connected;
      }
      
      public function get responseQueue() : ResponseQueue
      {
         return this._responseQueue;
      }
      
      public function sendMessage(param1:SocketMessage) : void
      {
         var _loc2_:int = 0;
         if(!this.socket.connected)
         {
            LogUtils.log("Socket not connected when sending a message.",this,2,"BattleServer",true);
            return;
         }
         param1.encode();
         this.byteArray.clear();
         this.byteArray.writeUTFBytes(param1.message);
         this.byteArray.position = 0;
         this.xorArray.clear();
         var _loc3_:int = int(this.byteArray.bytesAvailable);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.xorArray.writeByte(this.byteArray.readByte() ^ XOR_KEY[_loc2_ % XOR_KEY.length]);
            _loc2_++;
         }
         this.xorArray.position = 0;
         this.socket.writeInt(this.xorArray.length);
         this.socket.writeBytes(this.xorArray);
         this.socket.flush();
         this._messages.push("--> [" + getTimer() + "] " + param1.message);
         this.sentBytes += 4;
         this.sentBytes += this.xorArray.length;
         LogUtils.log("Sending message: " + param1.message + " stepTime: " + (!!this._game.tuxWorld ? this._game.tuxWorld.physicsWorld.stepCount : "-1"),this,1,"BattleServer",false,false,false);
      }
      
      private function connect(param1:BattleServerConnectMessage) : void
      {
         LogUtils.log("Connecting to " + param1.getHost() + ":" + param1.getPort(),this,1,"BattleServer");
         MessageCenter.removeListener("Connect",this.connect);
         this.messageLength = -1;
         this.messageQueue.init(this);
         this.socket.addEventListener("close",this.closeHandler,false,0,true);
         this.socket.addEventListener("connect",this.connectHandler,false,0,true);
         this.socket.addEventListener("ioError",this.ioErrorHandler,false,0,true);
         this.socket.addEventListener("securityError",this.securityErrorHandler,false,0,true);
         this.socket.addEventListener("socketData",this.socketDataHandler,false,0,true);
         this.socket.connect(param1.getHost(),param1.getPort());
      }
      
      private function disconnect(param1:BattleServerDisconnectMessage) : void
      {
         if(this.socket.connected)
         {
            LogUtils.log("Disconnecting...",this,1,"BattleServer");
            this.socket.close();
            this.dispose();
            MessageCenter.addListener("Connect",this.connect);
         }
      }
      
      private function removeListeners() : void
      {
         if(this.socket)
         {
            this.socket.removeEventListener("close",this.closeHandler);
            this.socket.removeEventListener("connect",this.connectHandler);
            this.socket.removeEventListener("ioError",this.ioErrorHandler);
            this.socket.removeEventListener("securityError",this.securityErrorHandler);
            this.socket.removeEventListener("socketData",this.socketDataHandler);
         }
      }
      
      private function socketDataHandler(param1:ProgressEvent = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:BattleResponse = null;
         var _loc5_:int = int(getTimer());
         this.checkForMessageLength();
         while(Boolean(this.socket.connected) && this.messageLength > -1 && this.socket.bytesAvailable >= this.messageLength)
         {
            this.inArray.clear();
            this.socket.readBytes(this.inArray,0,this.messageLength);
            this.inArray.position = 0;
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < this.messageLength)
            {
               _loc2_ += String.fromCharCode(this.inArray.readByte() ^ XOR_KEY[_loc3_ % XOR_KEY.length]);
               _loc3_++;
            }
            _loc4_ = new BattleResponse(_loc2_);
            this.receivedBytes += this.messageLength;
            if(this.lastTime == -1)
            {
               this.lastTime = _loc5_;
            }
            this._messages.push("<-- [" + _loc5_ + "] (" + (_loc5_ - this.lastTime) + ") " + _loc2_);
            this._responseQueue.addResponse(_loc4_);
            this.messageLength = -1;
            this.checkForMessageLength();
            this.lastTime = _loc5_;
         }
      }
      
      private function checkForMessageLength() : void
      {
         if(this.messageLength == -1 && Boolean(this.socket.connected) && this.socket.bytesAvailable >= 4)
         {
            this.messageLength = this.socket.readInt();
            this.receivedBytes += 4;
         }
      }
      
      private function connectHandler(param1:Event) : void
      {
         LogUtils.log("Socket opened.",this,1,"BattleServer");
         MessageCenter.addListener("BattleServerDisconnect",this.disconnect);
         MessageCenter.sendMessage("ServerConnected");
      }
      
      private function closeHandler(param1:Event) : void
      {
         LogUtils.log("Socket closed.",this,1,"BattleServer");
         this.dispose();
         MessageCenter.removeListener("BattleServerDisconnect",this.disconnect);
         MessageCenter.addListener("Connect",this.connect);
         MessageCenter.sendEvent(new ErrorMessage("BattleServer Disconnected","closeHandler","Unknown"));
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         LogUtils.log("Socket security error: " + param1.toString(),this,3,"BattleServer");
         MessageCenter.sendMessage("BattleServerConnectionFailed");
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         LogUtils.log("Socket I/O error: " + param1.toString(),this,3,"BattleServer");
         MessageCenter.sendMessage("BattleServerConnectionFailed");
      }
   }
}

