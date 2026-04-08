package com.dchoc.media
{
   import com.dchoc.events.*;
   import com.dchoc.utils.*;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.media.SoundChannel;
   import flash.utils.*;
   
   public class DCSoundManager extends EventDispatcher
   {
      private static var instance:DCSoundManager;
      
      private static var allowInstance:Boolean;
      
      public static const TYPE_MUSIC:int = 0;
      
      public static const TYPE_SFX:int = 1;
      
      private static const SOUND_INITIAL_VOLUME:Number = 1;
      
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
         this.soundsDictionary = new Dictionary();
         this.musicOn = true;
         this.sfxOn = true;
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
      
      public function loadSound(param1:String, param2:String, param3:int) : void
      {
         var path:String = param1;
         var name:String = param2;
         var type:int = param3;
         var _loc4_:DCSound = null;
         if(!this.soundExists(name))
         {
            try
            {
               _loc4_ = new DCSound(name,path,type,1);
               this.soundsDictionary[name] = _loc4_;
               _loc4_.addEventListener("complete",this.onSoundLoaded,false,0,true);
               _loc4_.addEventListener("ioError",this.errorLoading,false,0,true);
               _loc4_.loadSound();
            }
            catch(e:Error)
            {
               LogUtils.log("Failed to load sound, path: " + path + " name: " + name + "\n" + e.getStackTrace(),"DCSoundManager",3,"Sounds",true,false,true);
            }
         }
      }
      
      private function errorLoading(param1:IOErrorEvent) : void
      {
         var _loc2_:DCSound = param1.target as DCSound;
         _loc2_.removeEventListener("ioError",this.errorLoading);
         dispatchEvent(new DCLoadingEvent("error",_loc2_.getName()));
      }
      
      private function onSoundLoaded(param1:Event) : void
      {
         var _loc2_:DCSound = param1.target as DCSound;
         _loc2_.removeEventListener("complete",this.onSoundLoaded);
         dispatchEvent(new DCLoadingEvent("complete",_loc2_.getName()));
      }
      
      private function soundExists(param1:String) : Boolean
      {
         return this.soundsDictionary[param1] != null;
      }
      
      public function unloadSound(param1:String) : void
      {
         delete this.soundsDictionary[param1];
      }
      
      public function unloadAll() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.soundsDictionary)
         {
            this.unloadSound(_loc1_);
         }
         this.soundsDictionary = new Dictionary();
      }
      
      public function playSound(param1:String, param2:int = 0, param3:Number = 1, param4:Number = 0) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(param1 == null || this.soundsDictionary == null)
         {
            dispatchEvent(new DCSoundEvent("soundPLayError",param1));
            return;
         }
         var _loc7_:DCSound = this.soundsDictionary[param1];
         if(_loc7_ == null || !_loc7_.isPlayable())
         {
            dispatchEvent(new DCSoundEvent("soundPLayError",param1));
            return;
         }
         if(_loc7_.isMusic())
         {
            if(!this.isMusicOn())
            {
               return;
            }
            _loc5_ = !!_loc7_.isPaused() ? Boolean(_loc7_.resume()) : Boolean(_loc7_.play(param4,param2,param3));
         }
         else if(_loc7_.isSFX())
         {
            if(!this.isSfxOn())
            {
               return;
            }
            _loc5_ = Boolean(_loc7_.play(param4,param2,param3));
         }
         if(_loc5_)
         {
            _loc7_.addEventListener("soundComplete",this.onSoundOneLoopComplete,false,0,true);
         }
         else
         {
            dispatchEvent(new DCSoundEvent("soundPLayError",param1));
         }
      }
      
      public function stopSound(param1:String) : void
      {
         if(param1 == null || this.soundsDictionary == null || this.soundsDictionary[param1] == null)
         {
            return;
         }
         var _loc2_:DCSound = this.soundsDictionary[param1];
         if(_loc2_)
         {
            _loc2_.stop();
         }
      }
      
      public function pauseSound(param1:String) : void
      {
         this.soundsDictionary[param1].pause();
      }
      
      public function stopAll(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in this.soundsDictionary)
         {
            if(!(param1 && !_loc3_.isMusic() || param2 && !_loc3_.isSFX()))
            {
               _loc3_.stop();
            }
         }
      }
      
      public function pauseAll() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.soundsDictionary)
         {
            _loc1_.pause();
         }
      }
      
      public function isMusicOn() : Boolean
      {
         return this.musicOn;
      }
      
      public function isSfxOn() : Boolean
      {
         return this.sfxOn;
      }
      
      public function isSoundLoaded(param1:String) : Boolean
      {
         return this.soundsDictionary[param1] != null ? Boolean(this.soundsDictionary[param1].isLoaded()) : false;
      }
      
      public function setMusicOn(param1:Boolean) : void
      {
         this.musicOn = param1;
         if(!this.musicOn)
         {
            this.stopAll(true,false);
         }
      }
      
      public function setSfxOn(param1:Boolean) : void
      {
         this.sfxOn = param1;
         if(!this.sfxOn)
         {
            this.stopAll(false,true);
         }
      }
      
      public function setSoundVolume(param1:String, param2:Number) : void
      {
         this.soundsDictionary[param1].setVolume(param2);
      }
      
      public function setSoundPan(param1:String, param2:Number) : void
      {
         this.soundsDictionary[param1].setPan(param2);
      }
      
      public function getSoundVolume(param1:String) : Number
      {
         return DCSound(this.soundsDictionary[param1]).getVolume();
      }
      
      private function onSoundOneLoopComplete(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:DCSound = null;
         for each(_loc3_ in this.soundsDictionary)
         {
            _loc2_ = param1.target as DCSound;
            if(_loc2_ == _loc3_)
            {
               _loc3_.removeEventListener("soundComplete",this.onSoundOneLoopComplete);
               if(_loc3_.isLooping())
               {
                  _loc3_.restart();
                  _loc3_.addEventListener("soundComplete",this.onSoundOneLoopComplete,false,0,true);
               }
               dispatchEvent(new DCSoundEvent("soundComplete",_loc3_.getName()));
               break;
            }
         }
      }
      
      public function addCustomEventListener(param1:String, param2:Function, param3:String = null) : void
      {
         super.addEventListener(this.generateCustomEventType(param1,param3),param2,false,0,true);
      }
      
      public function removeCustomEventListener(param1:String, param2:Function, param3:String = null) : void
      {
         super.removeEventListener(this.generateCustomEventType(param1,param3),param2);
      }
      
      private function generateCustomEventType(param1:String, param2:String) : String
      {
         if(param2 == null)
         {
            return param1;
         }
         return param1 + "@" + param2;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         throw new Error("You cannot use addEventListener for this class. Use addCustomEventListener() instead");
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         throw new Error("You cannot use removeEventListener for this class. Use removeCustomEventListener() instead");
      }
      
      public function getChannel(param1:String) : SoundChannel
      {
         var _loc2_:Object = this.soundsDictionary[param1];
         return DCSound(this.soundsDictionary[param1]).getChannel();
      }
   }
}

