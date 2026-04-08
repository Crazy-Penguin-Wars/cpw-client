package tuxwars.data
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.events.DCSoundEvent;
   import com.dchoc.media.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import flash.media.SoundChannel;
   import flash.utils.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.net.messages.*;
   
   public class SoundManager
   {
      private static var collisionTable:Dictionary;
      
      private static var currentLoadNumberMaster:int;
      
      private static var currentPlayTypeMaster:int;
      
      private static var currentPlayTypeListIndexMaster:int;
      
      private static var musicType:int;
      
      public static const ID_NONE:String = "NONE";
      
      private static var collisionSoundID:int = 1;
      
      private static const PlayTypeArray:Array = ["Start","Loop","End","Collision"];
      
      private static const musicArray:Array = [];
      
      private static const channelVector:Array = [];
      
      public function SoundManager()
      {
         super();
         throw new Error("SoundManager is a static class!");
      }
      
      public static function init() : void
      {
         collisionTable = new Dictionary();
      }
      
      public static function dispose() : void
      {
         collisionTable = null;
      }
      
      public static function addListeners() : void
      {
         MessageCenter.addListener("PlayMusic",playmusic);
         MessageCenter.addListener("LoopMusic",loopmusic);
         MessageCenter.addListener("PlaySound",playsound);
         MessageCenter.addListener("PlayCollisionSound",playsound);
         MessageCenter.addListener("LoopSound",loopsound);
         MessageCenter.addListener("EndSound",endsound);
         MessageCenter.addListener("StopSound",stopsound);
         MessageCenter.addListener("StopAllSound",stopall);
         MessageCenter.addListener("PlayerFired",playerFired);
      }
      
      public static function removeListeners() : void
      {
         MessageCenter.removeListener("PlayMusic",playmusic);
         MessageCenter.removeListener("LoopMusic",loopmusic);
         MessageCenter.removeListener("PlaySound",playsound);
         MessageCenter.removeListener("PlayCollisionSound",playsound);
         MessageCenter.removeListener("LoopSound",loopsound);
         MessageCenter.removeListener("EndSound",endsound);
         MessageCenter.removeListener("StopSound",stopsound);
         MessageCenter.removeListener("StopAllSound",stopall);
         MessageCenter.removeListener("PlayerFired",playerFired);
      }
      
      private static function savePlayChannelInfo(param1:String, param2:String, param3:SoundChannel, param4:int, param5:Boolean, param6:int = 0) : Boolean
      {
         if(channelVector.indexOf(param1 + param2) == -1 && param5 == false)
         {
            if(channelVector.length <= 124)
            {
               channelVector.push(param1 + param2,param2,param3,param4);
               DCSoundManager.getInstance().playSound(param1 + param2);
               return true;
            }
         }
         else if(param5 == true)
         {
            if(channelVector.length <= 120)
            {
               channelVector.push(param6 + "_" + param1 + param2,param2,param3,param4);
               DCSoundManager.getInstance().playSound(param6 + "_" + param1 + param2);
               return true;
            }
         }
         return false;
      }
      
      private static function saveLoopChannelInfo(param1:String, param2:String, param3:SoundChannel, param4:int, param5:Boolean) : Boolean
      {
         if(channelVector.indexOf(param1 + param2) == -1)
         {
            if(channelVector.length <= 120)
            {
               channelVector.push(param1 + param2,param2,param3,param4);
               DCSoundManager.getInstance().playSound(param1 + param2,-1);
               return true;
            }
         }
         return false;
      }
      
      private static function removeChannelInfo(param1:DCSoundEvent) : void
      {
         if(channelVector.indexOf(param1.resourceName) >= 0)
         {
            channelVector.splice(channelVector.indexOf(param1.resourceName),4);
         }
      }
      
      private static function checkMessage(param1:SoundMessage, param2:String) : Boolean
      {
         var _loc3_:SoundReference = null;
         if(param1.id == null)
         {
            LogUtils.addDebugLine("Sounds","MusicID is null! for SoundReference: " + param1.id);
            return false;
         }
         _loc3_ = Sounds.getSoundReference(param1.id);
         if(_loc3_ != null && Boolean(_loc3_))
         {
            if(param2 == "PlaySound" && _loc3_.getStart() == null || param2 == "PlayCollisionSound" && _loc3_.getCollision() == null || param2 == "LoopSound" && _loc3_.getLoop() == null || param2 == "EndSound" && _loc3_.getEnd() == null)
            {
               if(param1.id != "NONE")
               {
                  LogUtils.addDebugLine("Sounds","Path is null! for MusicID: " + _loc3_.getMusicID());
               }
               return false;
            }
         }
         else
         {
            LogUtils.addDebugLine("Sounds","Sound is null! for MusicID: " + param1.id);
         }
         return true;
      }
      
      private static function errorHandler(param1:DCLoadingEvent) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference(param1.resourceName);
         LogUtils.log("Failed to load sound name: " + _loc2_.getMusicID(),"DCSoundManager",3,"Sounds",true,true,true);
      }
      
      public static function playmusic(param1:SoundMessage) : void
      {
         var _loc2_:SoundReference = null;
         if(checkMessage(param1,"PlaySound"))
         {
            _loc2_ = Sounds.getSoundReference(param1.id);
            if(_loc2_)
            {
               DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,_loc2_.getMusicID());
               DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,_loc2_.getMusicID() + _loc2_.getStart());
               DCSoundManager.getInstance().loadSound(_loc2_.getStart(),_loc2_.getMusicID() + _loc2_.getStart(),0);
               if(savePlayChannelInfo(_loc2_.getMusicID(),_loc2_.getStart(),DCSoundManager.getInstance().getChannel(_loc2_.getMusicID() + _loc2_.getStart()),0,_loc2_.getMultiple()))
               {
                  LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + _loc2_.getMusicID() + " Sound Path: " + _loc2_.getStart());
               }
            }
         }
      }
      
      public static function playerFired(param1:Message) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference("TurnEnd");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType(),"PlaySound"));
         }
      }
      
      public static function loopmusic(param1:SoundMessage) : void
      {
         var _loc2_:SoundReference = null;
         if(checkMessage(param1,"LoopSound"))
         {
            _loc2_ = Sounds.getSoundReference(param1.id);
            if(_loc2_)
            {
               DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,_loc2_.getMusicID());
               DCSoundManager.getInstance().loadSound(_loc2_.getLoop(),_loc2_.getMusicID() + _loc2_.getLoop(),0);
               if(saveLoopChannelInfo(_loc2_.getMusicID(),_loc2_.getLoop(),DCSoundManager.getInstance().getChannel(_loc2_.getMusicID() + _loc2_.getLoop()),0,_loc2_.getMultiple()))
               {
                  LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + _loc2_.getMusicID() + " Sound Path: " + _loc2_.getLoop());
               }
            }
         }
      }
      
      public static function playsound(param1:SoundMessage) : void
      {
         var _loc2_:SoundReference = null;
         var _loc3_:String = null;
         if(Boolean(checkMessage(param1,"PlaySound")) || Boolean(checkMessage(param1,"PlayCollisionSound")))
         {
            _loc2_ = Sounds.getSoundReference(param1.id);
            if(_loc2_)
            {
               if(param1.path != null)
               {
                  _loc3_ = param1.path;
               }
               else
               {
                  _loc3_ = _loc2_.getStart();
               }
               if(_loc3_)
               {
                  DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,_loc2_.getMusicID());
                  if(_loc2_.getMultiple() == false)
                  {
                     DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,_loc2_.getMusicID() + _loc3_);
                     DCSoundManager.getInstance().loadSound(_loc3_,_loc2_.getMusicID() + _loc3_,1);
                     if(savePlayChannelInfo(_loc2_.getMusicID(),_loc3_,DCSoundManager.getInstance().getChannel(_loc2_.getMusicID() + _loc3_),1,_loc2_.getMultiple()))
                     {
                        LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + _loc2_.getMusicID() + " Sound Path: " + _loc3_);
                     }
                  }
                  else
                  {
                     DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,collisionSoundID + "_" + _loc2_.getMusicID() + _loc3_);
                     DCSoundManager.getInstance().loadSound(_loc3_,collisionSoundID + "_" + _loc2_.getMusicID() + _loc3_,1);
                     if(savePlayChannelInfo(_loc2_.getMusicID(),_loc3_,DCSoundManager.getInstance().getChannel(collisionSoundID + "_" + _loc2_.getMusicID() + _loc3_),1,_loc2_.getMultiple(),collisionSoundID))
                     {
                        LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + _loc2_.getMusicID() + " Sound Path: " + _loc3_);
                     }
                     ++collisionSoundID;
                     if(collisionSoundID > 1000)
                     {
                        collisionSoundID = 1;
                     }
                  }
               }
               else
               {
                  LogUtils.log("Sounds NOT played - MusicID: " + _loc2_.getMusicID() + " Sound Path: " + _loc3_,"SoundManager",0,"Sounds",false,false,false);
               }
            }
         }
      }
      
      public static function loopsound(param1:SoundMessage) : void
      {
         var _loc2_:SoundReference = null;
         if(checkMessage(param1,"LoopSound"))
         {
            _loc2_ = Sounds.getSoundReference(param1.id);
            if(_loc2_)
            {
               DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,_loc2_.getMusicID());
               DCSoundManager.getInstance().loadSound(_loc2_.getLoop(),_loc2_.getMusicID() + _loc2_.getLoop(),1);
               if(saveLoopChannelInfo(_loc2_.getMusicID(),_loc2_.getLoop(),DCSoundManager.getInstance().getChannel(_loc2_.getMusicID() + _loc2_.getLoop()),1,_loc2_.getMultiple()))
               {
                  LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + _loc2_.getMusicID() + " Sound Path: " + _loc2_.getLoop());
               }
            }
         }
      }
      
      public static function endsound(param1:SoundMessage) : void
      {
         var _loc2_:SoundReference = null;
         var _loc3_:String = null;
         if(checkMessage(param1,"EndSound"))
         {
            _loc2_ = Sounds.getSoundReference(param1.id);
            if(_loc2_)
            {
               _loc3_ = _loc2_.getEnd();
               DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,_loc2_.getMusicID());
               if(_loc2_.getMultiple() == false)
               {
                  DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,_loc2_.getMusicID() + _loc3_);
                  DCSoundManager.getInstance().loadSound(_loc3_,_loc2_.getMusicID() + _loc3_,1);
                  if(savePlayChannelInfo(_loc2_.getMusicID(),_loc3_,DCSoundManager.getInstance().getChannel(_loc2_.getMusicID() + _loc3_),1,_loc2_.getMultiple()))
                  {
                     LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + _loc2_.getMusicID() + " Sound Path: " + _loc3_);
                  }
               }
               else
               {
                  DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,collisionSoundID + "_" + _loc2_.getMusicID() + _loc3_);
                  DCSoundManager.getInstance().loadSound(_loc3_,collisionSoundID + "_" + _loc2_.getMusicID() + _loc3_,1);
                  if(savePlayChannelInfo(_loc2_.getMusicID(),_loc3_,DCSoundManager.getInstance().getChannel(collisionSoundID + "_" + _loc2_.getMusicID() + _loc3_),1,_loc2_.getMultiple(),collisionSoundID))
                  {
                     LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + _loc2_.getMusicID() + " Sound Path: " + _loc3_);
                  }
                  ++collisionSoundID;
                  if(collisionSoundID > 1000)
                  {
                     collisionSoundID = 1;
                  }
               }
            }
         }
      }
      
      public static function stopsound(param1:SoundMessage) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference(param1.id);
         LogUtils.addDebugLine("Sounds","Sounds stopped - MusicID: " + _loc2_.getMusicID());
         if(param1.playType == "PlaySound")
         {
            DCSoundManager.getInstance().stopSound(_loc2_.getMusicID() + _loc2_.getStart());
            if(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getStart()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getStart()),4);
            }
         }
         if(param1.playType == "LoopSound")
         {
            DCSoundManager.getInstance().stopSound(_loc2_.getMusicID() + _loc2_.getLoop());
            if(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getLoop()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getLoop()),4);
            }
         }
         if(param1.playType == "EndSound")
         {
            DCSoundManager.getInstance().stopSound(_loc2_.getMusicID() + _loc2_.getEnd());
            if(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getEnd()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getEnd()),4);
            }
         }
         if(param1.playType == "PlayMusic")
         {
            DCSoundManager.getInstance().stopSound(_loc2_.getMusicID() + _loc2_.getStart());
            if(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getStart()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getStart()),4);
            }
         }
         if(param1.playType == "LoopMusic")
         {
            DCSoundManager.getInstance().stopSound(_loc2_.getMusicID() + _loc2_.getLoop());
            if(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getLoop()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(_loc2_.getMusicID() + _loc2_.getLoop()),4);
            }
         }
      }
      
      public static function stopall(param1:SoundMessage) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference(param1.id);
         LogUtils.addDebugLine("Sounds","All Sounds stopped.");
         DCSoundManager.getInstance().stopAll();
         channelVector.splice(0,channelVector.length);
      }
      
      public static function showChannels() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < channelVector.length)
         {
            LogUtils.log(channelVector[_loc1_ - _loc1_ % 4] + " " + [_loc1_] + " : " + channelVector[_loc1_],null,0,"Sounds",false,false,Config.debugMode);
            _loc1_++;
         }
      }
      
      public static function clearSfxList() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:Vector.<String> = new Vector.<String>();
         _loc1_ = 0;
         while(_loc1_ < channelVector.length)
         {
            if(channelVector[_loc1_] == 1)
            {
               _loc2_.push(channelVector[_loc1_ - 3]);
            }
            _loc1_++;
         }
         for each(_loc3_ in _loc2_)
         {
            channelVector.splice(channelVector.indexOf(_loc3_),4);
            LogUtils.log("Deleted sound: " + _loc3_,null,0,"Sounds",false,false,true);
         }
      }
      
      public static function isSoundPlaying(param1:String, param2:String) : Boolean
      {
         if(channelVector.indexOf(param1 + param2) == -1)
         {
            return false;
         }
         return true;
      }
      
      public static function continueMusic() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < channelVector.length)
         {
            if(channelVector[_loc1_] == 0)
            {
               DCSoundManager.getInstance().playSound(channelVector[_loc1_ - 3],-1);
            }
            _loc1_++;
         }
      }
      
      public static function saveMusicState() : void
      {
         if(DCSoundManager.getInstance().isMusicOn())
         {
            SoundManager.preLoadSounds();
         }
         MessageCenter.sendEvent(new SetFlagMessage("settingMusic",DCSoundManager.getInstance().isMusicOn().toString()));
      }
      
      public static function saveSfxState() : void
      {
         if(DCSoundManager.getInstance().isSfxOn())
         {
            SoundManager.preLoadSounds();
         }
         MessageCenter.sendEvent(new SetFlagMessage("settingSfx",DCSoundManager.getInstance().isSfxOn().toString()));
      }
      
      public static function loadSoundsStates(param1:Object) : void
      {
         var _loc2_:* = undefined;
         if(param1.flag)
         {
            if(param1.flag.hasOwnProperty("key"))
            {
               setSoundValues(param1.flag);
            }
            else
            {
               for each(_loc2_ in param1.flag)
               {
                  setSoundValues(_loc2_);
               }
            }
         }
      }
      
      private static function setSoundValues(param1:Object) : void
      {
         if(param1.key == "settingSfx")
         {
            if(param1.value)
            {
               DCSoundManager.getInstance().setSfxOn(true);
            }
            else
            {
               DCSoundManager.getInstance().setSfxOn(false);
            }
         }
         else if(param1.key == "settingMusic")
         {
            if(param1.value)
            {
               DCSoundManager.getInstance().setMusicOn(true);
            }
            else
            {
               DCSoundManager.getInstance().setMusicOn(false);
            }
         }
      }
      
      public static function markCollision(param1:PhysicsGameObject, param2:PhysicsGameObject) : Boolean
      {
         var _loc3_:SoundReference = null;
         var _loc4_:SoundReference = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(param1 is LevelGameObject || param2 is LevelGameObject)
         {
            if(param1 is LevelGameObject && param2 is LevelGameObject)
            {
               _loc3_ = Sounds.getSoundReference((param1 as LevelGameObject).material);
               _loc4_ = Sounds.getSoundReference((param2 as LevelGameObject).material);
               if(collisionTable[param1] == param2 || collisionTable[param2] == param1)
               {
                  return false;
               }
               if(Boolean(_loc3_) && _loc3_.getCollisionPriority() <= _loc4_.getCollisionPriority())
               {
                  if(_loc3_.getCollision() != null)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",_loc3_.getMusicID(),_loc3_.getCollision(),_loc3_.getType()));
                  }
               }
               else if(_loc4_)
               {
                  if(_loc4_.getCollision() != null)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",_loc4_.getMusicID(),_loc4_.getCollision(),_loc4_.getType()));
                  }
               }
               collisionTable[param1] = param2;
               collisionTable[param2] = param1;
               return true;
            }
            if(param2 is LevelGameObject)
            {
               _loc3_ = Sounds.getSoundReference(param1.soundId);
               _loc4_ = Sounds.getSoundReference((param2 as LevelGameObject).material);
               if((Boolean(_loc4_)) && _loc4_.getCollision() != null)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",_loc4_.getMusicID(),_loc4_.getCollision(),_loc4_.getType()));
               }
               if(Boolean(_loc3_) && _loc3_.getCollision() != null)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",_loc3_.getMusicID(),_loc3_.getCollision(),_loc3_.getType()));
               }
               return true;
            }
            if(param1 is LevelGameObject)
            {
               _loc4_ = Sounds.getSoundReference(param2.soundId);
               _loc3_ = Sounds.getSoundReference((param1 as LevelGameObject).material);
               if(Boolean(_loc4_) && _loc4_.getCollision() != null)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",_loc4_.getMusicID(),_loc4_.getCollision(),_loc4_.getType()));
               }
               if(Boolean(_loc3_) && _loc3_.getCollision() != null)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",_loc3_.getMusicID(),_loc3_.getCollision(),_loc3_.getType()));
               }
               return true;
            }
            return false;
         }
         _loc4_ = Sounds.getSoundReference(param2.soundId);
         _loc3_ = Sounds.getSoundReference(param1.soundId);
         if(Boolean(_loc4_) && _loc4_.getCollision() != null)
         {
            MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",_loc4_.getMusicID(),_loc4_.getCollision(),_loc4_.getType()));
         }
         if(Boolean(_loc3_) && _loc3_.getCollision() != null)
         {
            MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",_loc3_.getMusicID(),_loc3_.getCollision(),_loc3_.getType()));
         }
         return true;
      }
      
      private static function compareLoadNumber(param1:SoundReference, param2:SoundReference) : int
      {
         return param1.getLoadNumber() - param2.getLoadNumber();
      }
      
      public static function preLoadSounds() : void
      {
         var _loc8_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:String = "Sound";
         var _loc6_:* = ProjectManager.findTable(_loc5_);
         var _loc7_:Array = _loc6_._rows;
         currentLoadNumberMaster = 0;
         currentPlayTypeMaster = 0;
         currentPlayTypeListIndexMaster = 0;
         for each(_loc8_ in _loc7_)
         {
            musicArray.push(Sounds.getSoundReference(_loc8_.id));
         }
         musicArray.sort(compareLoadNumber);
         _loc1_ = int(currentLoadNumberMaster);
         while(_loc1_ < musicArray.length)
         {
            if(musicArray[_loc1_].getType() == "Music")
            {
               musicType = 0;
            }
            else
            {
               musicType = 1;
            }
            if(!(!DCSoundManager.getInstance().isMusicOn() && musicType == 0))
            {
               if(!(!DCSoundManager.getInstance().isSfxOn() && musicType == 1))
               {
                  _loc2_ = int(currentPlayTypeMaster);
                  while(_loc2_ < PlayTypeArray.length)
                  {
                     _loc3_ = musicArray[_loc1_].getArrayColumn(PlayTypeArray[_loc2_]);
                     if(_loc3_)
                     {
                        _loc4_ = int(currentPlayTypeListIndexMaster);
                        while(_loc4_ < _loc3_.length)
                        {
                           if(_loc3_[_loc4_] != null)
                           {
                              DCSoundManager.getInstance().addCustomEventListener("complete",preLoadLoop,_loc3_[_loc4_]);
                              DCSoundManager.getInstance().addCustomEventListener("error",preLoadError,_loc3_[_loc4_]);
                              DCSoundManager.getInstance().loadSound(Config.getDataDir() + _loc3_[_loc4_],_loc3_[_loc4_],musicType);
                              currentLoadNumberMaster = _loc1_;
                              currentPlayTypeMaster = _loc2_;
                              currentPlayTypeListIndexMaster = _loc4_;
                              return;
                           }
                           _loc4_++;
                        }
                     }
                     _loc2_++;
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private static function preLoadLoop(param1:DCLoadingEvent) : void
      {
         LogUtils.log("Preloaded soundID: " + PlayTypeArray[currentPlayTypeMaster],"SoundManager",0,"Sounds",false,false,false);
         preLoadNext();
      }
      
      private static function preLoadError(param1:DCLoadingEvent) : void
      {
         LogUtils.log("Failed to preload soundID: " + PlayTypeArray[currentPlayTypeMaster],"SoundManager",2,"Sounds",false,false,false);
         preLoadNext();
      }
      
      private static function preLoadNext() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = musicArray[currentLoadNumberMaster].getArrayColumn(PlayTypeArray[currentPlayTypeMaster]);
         DCSoundManager.getInstance().removeCustomEventListener("complete",preLoadLoop,_loc5_[currentPlayTypeListIndexMaster]);
         DCSoundManager.getInstance().removeCustomEventListener("error",preLoadError,_loc5_[currentPlayTypeListIndexMaster]);
         LogUtils.log("Loaded a sound: " + _loc5_[currentPlayTypeListIndexMaster],"SoundManager",0,"Sounds",false,false,false);
         _loc1_ = int(currentLoadNumberMaster);
         while(_loc1_ < musicArray.length)
         {
            if(musicArray[_loc1_].getType() == "Music")
            {
               musicType = 0;
            }
            else
            {
               musicType = 1;
            }
            if(!(!DCSoundManager.getInstance().isMusicOn() && musicType == 0))
            {
               if(!(!DCSoundManager.getInstance().isSfxOn() && musicType == 1))
               {
                  _loc2_ = int(currentPlayTypeMaster);
                  while(_loc2_ < PlayTypeArray.length)
                  {
                     _loc3_ = musicArray[_loc1_].getArrayColumn(PlayTypeArray[_loc2_]);
                     if(_loc3_)
                     {
                        if(_loc3_.length > 1)
                        {
                           ++currentPlayTypeListIndexMaster;
                        }
                        else
                        {
                           currentPlayTypeListIndexMaster = 1;
                        }
                        _loc4_ = currentPlayTypeListIndexMaster - 1;
                        while(_loc4_ <= _loc3_.length)
                        {
                           if(_loc3_[_loc4_] != null)
                           {
                              if(!DCSoundManager.getInstance().isSoundLoaded(_loc3_[_loc4_]))
                              {
                                 DCSoundManager.getInstance().addCustomEventListener("complete",preLoadLoop,_loc3_[_loc4_]);
                                 DCSoundManager.getInstance().addCustomEventListener("error",preLoadError,_loc3_[_loc4_]);
                                 DCSoundManager.getInstance().loadSound(Config.getDataDir() + _loc3_[_loc4_],_loc3_[_loc4_],musicType);
                                 currentLoadNumberMaster = _loc1_;
                                 currentPlayTypeMaster = _loc2_;
                                 currentPlayTypeListIndexMaster = _loc4_;
                                 return;
                              }
                           }
                           _loc4_++;
                        }
                        currentPlayTypeListIndexMaster = 0;
                     }
                     _loc2_++;
                  }
                  currentPlayTypeMaster = 0;
               }
            }
            _loc1_++;
         }
      }
   }
}

