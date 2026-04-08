package com.dchoc.media
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.display.Stage;
   import flash.events.NetStatusEvent;
   import flash.media.*;
   import flash.net.*;
   
   public class DCVideoPlayer
   {
      private const netConnection:NetConnection = new NetConnection();
      
      private const video:Video = new Video();
      
      private var stage:Stage;
      
      private var netStream:NetStream;
      
      private var file:String;
      
      private var _playing:Boolean;
      
      public function DCVideoPlayer(param1:Stage, param2:int, param3:int)
      {
         super();
         this.stage = param1;
         this.video.width = param2;
         this.video.height = param3;
      }
      
      public function dispose() : void
      {
         if(this.stage.contains(this.video))
         {
            this.stage.removeChild(this.video);
         }
         if(this.netStream)
         {
            this.netStream.close();
         }
         this.netConnection.close();
         this._playing = false;
      }
      
      public function play(param1:String) : void
      {
         this.file = param1;
         this.netConnection.connect(null);
         this.netStream = new NetStream(this.netConnection);
         this.netStream.addEventListener("netStatus",this.netStatusCallback);
         this.netStream.client = this;
         this.netStream.bufferTime = 2;
         this.video.smoothing = true;
         this.video.attachNetStream(this.netStream);
         this.video.x = this.stage.width * 0.5 - this.video.width * 0.5;
         this.video.y = this.stage.height * 0.5 - this.video.height * 0.5;
         this.stage.addChild(this.video);
         this.netStream.play(param1);
         this._playing = true;
      }
      
      public function get playing() : Boolean
      {
         return this._playing;
      }
      
      public function onPlayStatus(param1:Object) : void
      {
      }
      
      public function onMetaData(param1:Object) : void
      {
      }
      
      public function onXMPData(param1:Object) : void
      {
      }
      
      private function netStatusCallback(param1:NetStatusEvent) : void
      {
         switch(param1.info.code)
         {
            case "NetStream.Buffer.Full":
               MessageCenter.sendMessage("VideoStarted");
               LogUtils.log("Video Buffer Full [" + this.netStream.time.toFixed(3) + " seconds]",this,1,"VideoPlayer");
               break;
            case "NetStream.Play.Start":
               LogUtils.log("Video Start [" + this.netStream.time.toFixed(3) + " seconds]",this,1,"VideoPlayer");
               break;
            case "NetStream.Play.Stop":
               MessageCenter.sendMessage("VideoStopped");
               LogUtils.log("Video Stop [" + this.netStream.time.toFixed(3) + " seconds]",this,1,"VideoPlayer");
               this._playing = false;
               break;
            case "NetStream.Play.StreamNotFound":
               LogUtils.log("Video file (" + this.file + ") passed is not available!",this,3,"VideoPlayer");
         }
      }
   }
}

