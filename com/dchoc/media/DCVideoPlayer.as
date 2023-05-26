package com.dchoc.media
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.display.Stage;
   import flash.events.NetStatusEvent;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   
   public class DCVideoPlayer
   {
       
      
      private const netConnection:NetConnection = new NetConnection();
      
      private const video:Video = new Video();
      
      private var stage:Stage;
      
      private var netStream:NetStream;
      
      private var file:String;
      
      private var _playing:Boolean;
      
      public function DCVideoPlayer(stage:Stage, width:int, height:int)
      {
         super();
         this.stage = stage;
         video.width = width;
         video.height = height;
      }
      
      public function dispose() : void
      {
         if(stage.contains(video))
         {
            stage.removeChild(video);
         }
         if(netStream)
         {
            netStream.close();
         }
         netConnection.close();
         _playing = false;
      }
      
      public function play(file:String) : void
      {
         this.file = file;
         netConnection.connect(null);
         netStream = new NetStream(netConnection);
         netStream.addEventListener("netStatus",netStatusCallback);
         netStream.client = this;
         netStream.bufferTime = 2;
         video.smoothing = true;
         video.attachNetStream(netStream);
         video.x = stage.width * 0.5 - video.width * 0.5;
         video.y = stage.height * 0.5 - video.height * 0.5;
         stage.addChild(video);
         netStream.play(file);
         _playing = true;
      }
      
      public function get playing() : Boolean
      {
         return _playing;
      }
      
      public function onPlayStatus(event:Object) : void
      {
      }
      
      public function onMetaData(evt:Object) : void
      {
      }
      
      public function onXMPData(evt:Object) : void
      {
      }
      
      private function netStatusCallback(event:NetStatusEvent) : void
      {
         switch(event.info.code)
         {
            case "NetStream.Buffer.Full":
               MessageCenter.sendMessage("VideoStarted");
               LogUtils.log("Video Buffer Full [" + netStream.time.toFixed(3) + " seconds]",this,1,"VideoPlayer");
               break;
            case "NetStream.Play.Start":
               LogUtils.log("Video Start [" + netStream.time.toFixed(3) + " seconds]",this,1,"VideoPlayer");
               break;
            case "NetStream.Play.Stop":
               MessageCenter.sendMessage("VideoStopped");
               LogUtils.log("Video Stop [" + netStream.time.toFixed(3) + " seconds]",this,1,"VideoPlayer");
               _playing = false;
               break;
            case "NetStream.Play.StreamNotFound":
               LogUtils.log("Video file (" + file + ") passed is not available!",this,3,"VideoPlayer");
         }
      }
   }
}
