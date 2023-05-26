package com.dchoc.media
{
   import com.dchoc.utils.LogUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundLoaderContext;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
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
      
      public function DCSound(name:String, path:String, type:int, volume:int)
      {
         super();
         this.name = name;
         this.path = path;
         this.type = type;
         this.volume = volume;
         this.position = 0;
         this.startTime = 0;
         this.repeatCount = 0;
         this.sound = new Sound();
         this.channel = new SoundChannel();
      }
      
      override public function toString() : String
      {
         return "Sound: name = " + name + " path = " + path + " type = " + type;
      }
      
      internal function loadSound() : void
      {
         sound = new Sound();
         sound.addEventListener("complete",onSoundLoaded,false,0,true);
         sound.addEventListener("ioError",errorHandler,false,0,true);
         sound.load(new URLRequest(path),new SoundLoaderContext());
      }
      
      private function onSoundLoaded(event:Event) : void
      {
         Sound(event.target).removeEventListener("complete",onSoundLoaded);
         loaded = true;
         dispatchEvent(event);
      }
      
      private function errorHandler(event:IOErrorEvent) : void
      {
         sound.removeEventListener("ioError",errorHandler);
         dispatchEvent(event);
      }
      
      internal function getChannel() : SoundChannel
      {
         return channel;
      }
      
      internal function getVolume() : int
      {
         return channel.soundTransform.volume;
      }
      
      internal function isLoaded() : Boolean
      {
         return loaded;
      }
      
      internal function isLooping() : Boolean
      {
         return repeatCount < 0;
      }
      
      internal function getName() : String
      {
         return name;
      }
      
      internal function isMusic() : Boolean
      {
         return type == 0;
      }
      
      internal function isSFX() : Boolean
      {
         return type == 1;
      }
      
      internal function isPaused() : Boolean
      {
         return paused;
      }
      
      internal function play(startTime:Number, loops:int, volume:int) : Boolean
      {
         this.startTime = startTime;
         this.repeatCount = loops;
         this.volume = volume;
         return playSound(startTime,repeatCount,volume);
      }
      
      internal function resume() : Boolean
      {
         return playSound(position,repeatCount,volume);
      }
      
      internal function restart() : void
      {
         play(0,repeatCount,volume);
      }
      
      internal function pause() : void
      {
         if(channel)
         {
            position = channel.position;
            channel.stop();
            paused = true;
         }
      }
      
      internal function stop() : void
      {
         pause();
         position = startTime;
      }
      
      internal function isPlayable() : Boolean
      {
         return channel != null && sound != null;
      }
      
      internal function setPan(pan:Number) : void
      {
         var _loc2_:SoundTransform = channel.soundTransform;
         _loc2_.pan = pan;
         channel.soundTransform = _loc2_;
      }
      
      internal function setVolume(volume:int) : void
      {
         var _loc2_:SoundTransform = channel.soundTransform;
         _loc2_.volume = volume;
         channel.soundTransform = _loc2_;
         this.volume = volume;
      }
      
      private function playSound(position:Number, loops:int, volume:int) : Boolean
      {
         try
         {
            channel = sound.play(position,loops,new SoundTransform(volume));
         }
         catch(e:Error)
         {
            LogUtils.log("Error when trying to play: " + toString(),this,3,"Sounds");
            LogUtils.log(e.getStackTrace());
         }
         if(!channel)
         {
            return false;
         }
         channel.addEventListener("soundComplete",onSoundOneLoopComplete,false,0,true);
         paused = false;
         return true;
      }
      
      private function onSoundOneLoopComplete(event:Event) : void
      {
         channel.removeEventListener("soundComplete",onSoundOneLoopComplete);
         dispatchEvent(event);
      }
   }
}
