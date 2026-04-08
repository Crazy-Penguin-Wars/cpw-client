package com.dchoc.media
{
   import com.dchoc.utils.*;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.media.*;
   import flash.net.*;
   
   public class DCSound extends EventDispatcher
   {
      internal static const TYPE_MUSIC:int = 0;
      
      internal static const TYPE_SFX:int = 1;
      
      private var name:String;
      
      private var sound:Sound;
      
      private var channel:SoundChannel;
      
      private var position:Number;
      
      private var paused:Boolean;
      
      private var volume:int;
      
      private var startTime:int;
      
      private var repeatCount:int;
      
      private var type:int;
      
      private var loaded:Boolean;
      
      private var path:String;
      
      public function DCSound(param1:String, param2:String, param3:int, param4:int)
      {
         super();
         this.name = param1;
         this.path = param2;
         this.type = param3;
         this.volume = param4;
         this.position = 0;
         this.startTime = 0;
         this.repeatCount = 0;
         this.sound = new Sound();
         this.channel = new SoundChannel();
      }
      
      override public function toString() : String
      {
         return "Sound: name = " + this.name + " path = " + this.path + " type = " + this.type;
      }
      
      internal function loadSound() : void
      {
         this.sound = new Sound();
         this.sound.addEventListener("complete",this.onSoundLoaded,false,0,true);
         this.sound.addEventListener("ioError",this.errorHandler,false,0,true);
         this.sound.load(new URLRequest(this.path),new SoundLoaderContext());
      }
      
      private function onSoundLoaded(param1:Event) : void
      {
         Sound(param1.target).removeEventListener("complete",this.onSoundLoaded);
         this.loaded = true;
         dispatchEvent(param1);
      }
      
      private function errorHandler(param1:IOErrorEvent) : void
      {
         this.sound.removeEventListener("ioError",this.errorHandler);
         dispatchEvent(param1);
      }
      
      internal function getChannel() : SoundChannel
      {
         return this.channel;
      }
      
      internal function getVolume() : int
      {
         return this.channel.soundTransform.volume;
      }
      
      internal function isLoaded() : Boolean
      {
         return this.loaded;
      }
      
      internal function isLooping() : Boolean
      {
         return this.repeatCount < 0;
      }
      
      internal function getName() : String
      {
         return this.name;
      }
      
      internal function isMusic() : Boolean
      {
         return this.type == 0;
      }
      
      internal function isSFX() : Boolean
      {
         return this.type == 1;
      }
      
      internal function isPaused() : Boolean
      {
         return this.paused;
      }
      
      internal function play(param1:Number, param2:int, param3:int) : Boolean
      {
         this.startTime = param1;
         this.repeatCount = param2;
         this.volume = param3;
         return this.playSound(param1,this.repeatCount,param3);
      }
      
      internal function resume() : Boolean
      {
         return this.playSound(this.position,this.repeatCount,this.volume);
      }
      
      internal function restart() : void
      {
         this.play(0,this.repeatCount,this.volume);
      }
      
      internal function pause() : void
      {
         if(this.channel)
         {
            this.position = this.channel.position;
            this.channel.stop();
            this.paused = true;
         }
      }
      
      internal function stop() : void
      {
         this.pause();
         this.position = this.startTime;
      }
      
      internal function isPlayable() : Boolean
      {
         return this.channel != null && this.sound != null;
      }
      
      internal function setPan(param1:Number) : void
      {
         var _loc2_:SoundTransform = this.channel.soundTransform;
         _loc2_.pan = param1;
         this.channel.soundTransform = _loc2_;
      }
      
      internal function setVolume(param1:int) : void
      {
         var _loc2_:SoundTransform = this.channel.soundTransform;
         _loc2_.volume = param1;
         this.channel.soundTransform = _loc2_;
         this.volume = param1;
      }
      
      private function playSound(param1:Number, param2:int, param3:int) : Boolean
      {
         var position:Number = param1;
         var loops:int = param2;
         var volume:int = param3;
         try
         {
            this.channel = this.sound.play(position,loops,new SoundTransform(volume));
         }
         catch(e:Error)
         {
            LogUtils.log("Error when trying to play: " + toString(),this,3,"Sounds");
            LogUtils.log(e.getStackTrace());
         }
         if(!this.channel)
         {
            return false;
         }
         this.channel.addEventListener("soundComplete",this.onSoundOneLoopComplete,false,0,true);
         this.paused = false;
         return true;
      }
      
      private function onSoundOneLoopComplete(param1:Event) : void
      {
         this.channel.removeEventListener("soundComplete",this.onSoundOneLoopComplete);
         dispatchEvent(param1);
      }
   }
}

