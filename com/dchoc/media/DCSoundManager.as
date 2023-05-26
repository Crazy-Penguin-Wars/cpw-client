package com.dchoc.media
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.events.DCSoundEvent;
   import com.dchoc.utils.LogUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.media.SoundChannel;
   import flash.utils.Dictionary;
   
   public class DCSoundManager extends EventDispatcher
   {
      
      public static const TYPE_MUSIC:int = 0;
      
      public static const TYPE_SFX:int = 1;
      
      private static const SOUND_INITIAL_VOLUME:Number = 1;
      
      private static var instance:DCSoundManager;
      
      private static var allowInstance:Boolean;
       
      
      private var musicOn:Boolean;
      
      private var sfxOn:Boolean;
      
      private var soundsDictionary:Dictionary;
      
      public function DCSoundManager()
      {
         super();
         if(!allowInstance)
         {
            throw new Error("ERROR: SoundManager Error: Instantiation failed: Use SoundManager.getInstance() instead of new.");
         }
         soundsDictionary = new Dictionary();
         musicOn = true;
         sfxOn = true;
      }
      
      public static function getInstance() : DCSoundManager
      {
         if(!instance)
         {
            allowInstance = true;
            instance = new DCSoundManager();
            allowInstance = false;
         }
         return instance;
      }
      
      public function loadSound(path:String, name:String, type:int) : void
      {
         var _loc4_:* = null;
         if(!soundExists(name))
         {
            try
            {
               _loc4_ = new DCSound(name,path,type,1);
               soundsDictionary[name] = _loc4_;
               _loc4_.addEventListener("complete",onSoundLoaded,false,0,true);
               _loc4_.addEventListener("ioError",errorLoading,false,0,true);
               _loc4_.loadSound();
            }
            catch(e:Error)
            {
               LogUtils.log("Failed to load sound, path: " + path + " name: " + name + "\n" + e.getStackTrace(),"DCSoundManager",3,"Sounds",true,false,true);
            }
         }
      }
      
      private function errorLoading(event:IOErrorEvent) : void
      {
         var _loc2_:DCSound = event.target as DCSound;
         _loc2_.removeEventListener("ioError",errorLoading);
         dispatchEvent(new DCLoadingEvent("error",_loc2_.getName()));
      }
      
      private function onSoundLoaded(event:Event) : void
      {
         var _loc2_:DCSound = event.target as DCSound;
         _loc2_.removeEventListener("complete",onSoundLoaded);
         dispatchEvent(new DCLoadingEvent("complete",_loc2_.getName()));
      }
      
      private function soundExists(name:String) : Boolean
      {
         return soundsDictionary[name] != null;
      }
      
      public function unloadSound(name:String) : void
      {
         delete soundsDictionary[name];
      }
      
      public function unloadAll() : void
      {
         for(var name in soundsDictionary)
         {
            unloadSound(name);
         }
         soundsDictionary = new Dictionary();
      }
      
      public function playSound(name:String, loops:int = 0, volume:Number = 1, startTime:Number = 0) : void
      {
         var success:Boolean = false;
         if(name == null || soundsDictionary == null)
         {
            dispatchEvent(new DCSoundEvent("soundPLayError",name));
            return;
         }
         var _loc5_:DCSound = soundsDictionary[name];
         if(_loc5_ == null || !_loc5_.isPlayable())
         {
            dispatchEvent(new DCSoundEvent("soundPLayError",name));
            return;
         }
         if(_loc5_.isMusic())
         {
            if(!isMusicOn())
            {
               return;
            }
            success = _loc5_.isPaused() ? _loc5_.resume() : _loc5_.play(startTime,loops,volume);
         }
         else if(_loc5_.isSFX())
         {
            if(!isSfxOn())
            {
               return;
            }
            success = _loc5_.play(startTime,loops,volume);
         }
         if(success)
         {
            _loc5_.addEventListener("soundComplete",onSoundOneLoopComplete,false,0,true);
         }
         else
         {
            dispatchEvent(new DCSoundEvent("soundPLayError",name));
         }
      }
      
      public function stopSound(name:String) : void
      {
         if(name == null || soundsDictionary == null || soundsDictionary[name] == null)
         {
            return;
         }
         var _loc2_:DCSound = soundsDictionary[name];
         if(_loc2_)
         {
            _loc2_.stop();
         }
      }
      
      public function pauseSound(name:String) : void
      {
         soundsDictionary[name].pause();
      }
      
      public function stopAll(onlyMusic:Boolean = false, onlySfx:Boolean = false) : void
      {
         for each(var snd in soundsDictionary)
         {
            if(!(onlyMusic && !snd.isMusic() || onlySfx && !snd.isSFX()))
            {
               snd.stop();
            }
         }
      }
      
      public function pauseAll() : void
      {
         for each(var snd in soundsDictionary)
         {
            snd.pause();
         }
      }
      
      public function isMusicOn() : Boolean
      {
         return musicOn;
      }
      
      public function isSfxOn() : Boolean
      {
         return sfxOn;
      }
      
      public function isSoundLoaded(name:String) : Boolean
      {
         return soundsDictionary[name] != null ? soundsDictionary[name].isLoaded() : false;
      }
      
      public function setMusicOn(on:Boolean) : void
      {
         musicOn = on;
         if(!musicOn)
         {
            stopAll(true,false);
         }
      }
      
      public function setSfxOn(on:Boolean) : void
      {
         sfxOn = on;
         if(!sfxOn)
         {
            stopAll(false,true);
         }
      }
      
      public function setSoundVolume(name:String, volume:Number) : void
      {
         soundsDictionary[name].setVolume(volume);
      }
      
      public function setSoundPan(name:String, pan:Number) : void
      {
         soundsDictionary[name].setPan(pan);
      }
      
      public function getSoundVolume(name:String) : Number
      {
         return DCSound(soundsDictionary[name]).getVolume();
      }
      
      private function onSoundOneLoopComplete(event:Event) : void
      {
         var _loc3_:* = null;
         for each(var dcSound in soundsDictionary)
         {
            _loc3_ = event.target as DCSound;
            if(_loc3_ == dcSound)
            {
               dcSound.removeEventListener("soundComplete",onSoundOneLoopComplete);
               if(dcSound.isLooping())
               {
                  dcSound.restart();
                  dcSound.addEventListener("soundComplete",onSoundOneLoopComplete,false,0,true);
               }
               dispatchEvent(new DCSoundEvent("soundComplete",dcSound.getName()));
               break;
            }
         }
      }
      
      public function addCustomEventListener(eventType:String, listener:Function, resName:String = null) : void
      {
         super.addEventListener(generateCustomEventType(eventType,resName),listener,false,0,true);
      }
      
      public function removeCustomEventListener(eventType:String, listener:Function, resName:String = null) : void
      {
         super.removeEventListener(generateCustomEventType(eventType,resName),listener);
      }
      
      private function generateCustomEventType(eventType:String, customName:String) : String
      {
         if(customName == null)
         {
            return eventType;
         }
         return eventType + "@" + customName;
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         throw new Error("You cannot use addEventListener for this class. Use addCustomEventListener() instead");
      }
      
      override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         throw new Error("You cannot use removeEventListener for this class. Use removeCustomEventListener() instead");
      }
      
      public function getChannel(soundID:String) : SoundChannel
      {
         var a:Object = soundsDictionary[soundID];
         return DCSound(soundsDictionary[soundID]).getChannel();
      }
   }
}
