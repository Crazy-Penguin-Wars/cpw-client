package tuxwars.data
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.events.DCSoundEvent;
   import com.dchoc.media.DCSoundManager;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import flash.media.SoundChannel;
   import flash.utils.Dictionary;
   import tuxwars.battle.gameobjects.LevelGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.net.messages.SetFlagMessage;
   
   public class SoundManager
   {
      
      private static const PlayTypeArray:Array = ["Start","Loop","End","Collision"];
      
      private static const musicArray:Array = [];
      
      public static const ID_NONE:String = "NONE";
      
      private static const channelVector:Array = [];
      
      private static var collisionTable:Dictionary;
      
      private static var collisionSoundID:int = 1;
      
      private static var currentLoadNumberMaster:int;
      
      private static var currentPlayTypeMaster:int;
      
      private static var currentPlayTypeListIndexMaster:int;
      
      private static var musicType:int;
       
      
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
      
      private static function savePlayChannelInfo(soundID:String, soundPath:String, channel:SoundChannel, type:int, multiple:Boolean, collisID:int = 0) : Boolean
      {
         if(channelVector.indexOf(soundID + soundPath) == -1 && multiple == false)
         {
            if(channelVector.length <= 124)
            {
               channelVector.push(soundID + soundPath,soundPath,channel,type);
               DCSoundManager.getInstance().playSound(soundID + soundPath);
               return true;
            }
         }
         else if(multiple == true)
         {
            if(channelVector.length <= 120)
            {
               channelVector.push(collisID + "_" + soundID + soundPath,soundPath,channel,type);
               DCSoundManager.getInstance().playSound(collisID + "_" + soundID + soundPath);
               return true;
            }
         }
         return false;
      }
      
      private static function saveLoopChannelInfo(soundID:String, soundPath:String, channel:SoundChannel, type:int, multiple:Boolean) : Boolean
      {
         if(channelVector.indexOf(soundID + soundPath) == -1)
         {
            if(channelVector.length <= 120)
            {
               channelVector.push(soundID + soundPath,soundPath,channel,type);
               DCSoundManager.getInstance().playSound(soundID + soundPath,-1);
               return true;
            }
         }
         return false;
      }
      
      private static function removeChannelInfo(event:DCSoundEvent) : void
      {
         if(channelVector.indexOf(event.resourceName) >= 0)
         {
            channelVector.splice(channelVector.indexOf(event.resourceName),4);
         }
      }
      
      private static function checkMessage(msg:SoundMessage, type:String) : Boolean
      {
         var sound:* = null;
         if(msg.id == null)
         {
            LogUtils.addDebugLine("Sounds","MusicID is null! for SoundReference: " + msg.id);
            return false;
         }
         sound = Sounds.getSoundReference(msg.id);
         if(sound != null && sound)
         {
            if(type == "PlaySound" && sound.getStart() == null || type == "PlayCollisionSound" && sound.getCollision() == null || type == "LoopSound" && sound.getLoop() == null || type == "EndSound" && sound.getEnd() == null)
            {
               if(msg.id != "NONE")
               {
                  LogUtils.addDebugLine("Sounds","Path is null! for MusicID: " + sound.getMusicID());
               }
               return false;
            }
         }
         else
         {
            LogUtils.addDebugLine("Sounds","Sound is null! for MusicID: " + msg.id);
         }
         return true;
      }
      
      private static function errorHandler(event:DCLoadingEvent) : void
      {
         var sound:SoundReference = Sounds.getSoundReference(event.resourceName);
         LogUtils.log("Failed to load sound name: " + sound.getMusicID(),"DCSoundManager",3,"Sounds",true,true,true);
      }
      
      public static function playmusic(msg:SoundMessage) : void
      {
         var sound:* = null;
         if(checkMessage(msg,"PlaySound"))
         {
            sound = Sounds.getSoundReference(msg.id);
            if(sound)
            {
               DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,sound.getMusicID());
               DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,sound.getMusicID() + sound.getStart());
               DCSoundManager.getInstance().loadSound(sound.getStart(),sound.getMusicID() + sound.getStart(),0);
               if(savePlayChannelInfo(sound.getMusicID(),sound.getStart(),DCSoundManager.getInstance().getChannel(sound.getMusicID() + sound.getStart()),0,sound.getMultiple()))
               {
                  LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + sound.getMusicID() + " Sound Path: " + sound.getStart());
               }
            }
         }
      }
      
      public static function playerFired(msg:Message) : void
      {
         var turnsound:SoundReference = Sounds.getSoundReference("TurnEnd");
         if(turnsound)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",turnsound.getMusicID(),turnsound.getLoop(),turnsound.getType(),"PlaySound"));
         }
      }
      
      public static function loopmusic(msg:SoundMessage) : void
      {
         var sound:* = null;
         if(checkMessage(msg,"LoopSound"))
         {
            sound = Sounds.getSoundReference(msg.id);
            if(sound)
            {
               DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,sound.getMusicID());
               DCSoundManager.getInstance().loadSound(sound.getLoop(),sound.getMusicID() + sound.getLoop(),0);
               if(saveLoopChannelInfo(sound.getMusicID(),sound.getLoop(),DCSoundManager.getInstance().getChannel(sound.getMusicID() + sound.getLoop()),0,sound.getMultiple()))
               {
                  LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + sound.getMusicID() + " Sound Path: " + sound.getLoop());
               }
            }
         }
      }
      
      public static function playsound(msg:SoundMessage) : void
      {
         var sound:* = null;
         var startSound:* = null;
         if(checkMessage(msg,"PlaySound") || checkMessage(msg,"PlayCollisionSound"))
         {
            sound = Sounds.getSoundReference(msg.id);
            if(sound)
            {
               if(msg.path != null)
               {
                  startSound = msg.path;
               }
               else
               {
                  startSound = sound.getStart();
               }
               if(startSound)
               {
                  DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,sound.getMusicID());
                  if(sound.getMultiple() == false)
                  {
                     DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,sound.getMusicID() + startSound);
                     DCSoundManager.getInstance().loadSound(startSound,sound.getMusicID() + startSound,1);
                     if(savePlayChannelInfo(sound.getMusicID(),startSound,DCSoundManager.getInstance().getChannel(sound.getMusicID() + startSound),1,sound.getMultiple()))
                     {
                        LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + sound.getMusicID() + " Sound Path: " + startSound);
                     }
                  }
                  else
                  {
                     DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,collisionSoundID + "_" + sound.getMusicID() + startSound);
                     DCSoundManager.getInstance().loadSound(startSound,collisionSoundID + "_" + sound.getMusicID() + startSound,1);
                     if(savePlayChannelInfo(sound.getMusicID(),startSound,DCSoundManager.getInstance().getChannel(collisionSoundID + "_" + sound.getMusicID() + startSound),1,sound.getMultiple(),collisionSoundID))
                     {
                        LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + sound.getMusicID() + " Sound Path: " + startSound);
                     }
                     collisionSoundID++;
                     if(collisionSoundID > 1000)
                     {
                        collisionSoundID = 1;
                     }
                  }
               }
               else
               {
                  LogUtils.log("Sounds NOT played - MusicID: " + sound.getMusicID() + " Sound Path: " + startSound,"SoundManager",0,"Sounds",false,false,false);
               }
            }
         }
      }
      
      public static function loopsound(msg:SoundMessage) : void
      {
         var sound:* = null;
         if(checkMessage(msg,"LoopSound"))
         {
            sound = Sounds.getSoundReference(msg.id);
            if(sound)
            {
               DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,sound.getMusicID());
               DCSoundManager.getInstance().loadSound(sound.getLoop(),sound.getMusicID() + sound.getLoop(),1);
               if(saveLoopChannelInfo(sound.getMusicID(),sound.getLoop(),DCSoundManager.getInstance().getChannel(sound.getMusicID() + sound.getLoop()),1,sound.getMultiple()))
               {
                  LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + sound.getMusicID() + " Sound Path: " + sound.getLoop());
               }
            }
         }
      }
      
      public static function endsound(msg:SoundMessage) : void
      {
         var sound:* = null;
         var endSound:* = null;
         if(checkMessage(msg,"EndSound"))
         {
            sound = Sounds.getSoundReference(msg.id);
            if(sound)
            {
               endSound = sound.getEnd();
               DCSoundManager.getInstance().addCustomEventListener("error",errorHandler,sound.getMusicID());
               if(sound.getMultiple() == false)
               {
                  DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,sound.getMusicID() + endSound);
                  DCSoundManager.getInstance().loadSound(endSound,sound.getMusicID() + endSound,1);
                  if(savePlayChannelInfo(sound.getMusicID(),endSound,DCSoundManager.getInstance().getChannel(sound.getMusicID() + endSound),1,sound.getMultiple()))
                  {
                     LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + sound.getMusicID() + " Sound Path: " + endSound);
                  }
               }
               else
               {
                  DCSoundManager.getInstance().addCustomEventListener("soundComplete",removeChannelInfo,collisionSoundID + "_" + sound.getMusicID() + endSound);
                  DCSoundManager.getInstance().loadSound(endSound,collisionSoundID + "_" + sound.getMusicID() + endSound,1);
                  if(savePlayChannelInfo(sound.getMusicID(),endSound,DCSoundManager.getInstance().getChannel(collisionSoundID + "_" + sound.getMusicID() + endSound),1,sound.getMultiple(),collisionSoundID))
                  {
                     LogUtils.addDebugLine("Sounds","Sounds played - MusicID: " + sound.getMusicID() + " Sound Path: " + endSound);
                  }
                  collisionSoundID++;
                  if(collisionSoundID > 1000)
                  {
                     collisionSoundID = 1;
                  }
               }
            }
         }
      }
      
      public static function stopsound(msg:SoundMessage) : void
      {
         var sound:SoundReference = Sounds.getSoundReference(msg.id);
         LogUtils.addDebugLine("Sounds","Sounds stopped - MusicID: " + sound.getMusicID());
         if(msg.playType == "PlaySound")
         {
            DCSoundManager.getInstance().stopSound(sound.getMusicID() + sound.getStart());
            if(channelVector.indexOf(sound.getMusicID() + sound.getStart()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(sound.getMusicID() + sound.getStart()),4);
            }
         }
         if(msg.playType == "LoopSound")
         {
            DCSoundManager.getInstance().stopSound(sound.getMusicID() + sound.getLoop());
            if(channelVector.indexOf(sound.getMusicID() + sound.getLoop()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(sound.getMusicID() + sound.getLoop()),4);
            }
         }
         if(msg.playType == "EndSound")
         {
            DCSoundManager.getInstance().stopSound(sound.getMusicID() + sound.getEnd());
            if(channelVector.indexOf(sound.getMusicID() + sound.getEnd()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(sound.getMusicID() + sound.getEnd()),4);
            }
         }
         if(msg.playType == "PlayMusic")
         {
            DCSoundManager.getInstance().stopSound(sound.getMusicID() + sound.getStart());
            if(channelVector.indexOf(sound.getMusicID() + sound.getStart()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(sound.getMusicID() + sound.getStart()),4);
            }
         }
         if(msg.playType == "LoopMusic")
         {
            DCSoundManager.getInstance().stopSound(sound.getMusicID() + sound.getLoop());
            if(channelVector.indexOf(sound.getMusicID() + sound.getLoop()) >= 0)
            {
               channelVector.splice(channelVector.indexOf(sound.getMusicID() + sound.getLoop()),4);
            }
         }
      }
      
      public static function stopall(msg:SoundMessage) : void
      {
         var sound:SoundReference = Sounds.getSoundReference(msg.id);
         LogUtils.addDebugLine("Sounds","All Sounds stopped.");
         DCSoundManager.getInstance().stopAll();
         channelVector.splice(0,channelVector.length);
      }
      
      public static function showChannels() : void
      {
         var i:int = 0;
         for(i = 0; i < channelVector.length; )
         {
            LogUtils.log(channelVector[i - i % 4] + " " + [i] + " : " + channelVector[i],null,0,"Sounds",false,false,Config.debugMode);
            i++;
         }
      }
      
      public static function clearSfxList() : void
      {
         var i:int = 0;
         var deleteVector:Vector.<String> = new Vector.<String>();
         for(i = 0; i < channelVector.length; )
         {
            if(channelVector[i] == 1)
            {
               deleteVector.push(channelVector[i - 3]);
            }
            i++;
         }
         for each(var name in deleteVector)
         {
            channelVector.splice(channelVector.indexOf(name),4);
            LogUtils.log("Deleted sound: " + name,null,0,"Sounds",false,false,true);
         }
      }
      
      public static function isSoundPlaying(soundID:String, soundPath:String) : Boolean
      {
         if(channelVector.indexOf(soundID + soundPath) == -1)
         {
            return false;
         }
         return true;
      }
      
      public static function continueMusic() : void
      {
         var i:int = 0;
         for(i = 0; i < channelVector.length; )
         {
            if(channelVector[i] == 0)
            {
               DCSoundManager.getInstance().playSound(channelVector[i - 3],-1);
            }
            i++;
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
      
      public static function loadSoundsStates(data:Object) : void
      {
         if(data.flag)
         {
            if(data.flag.hasOwnProperty("key"))
            {
               setSoundValues(data.flag);
            }
            else
            {
               for each(var object in data.flag)
               {
                  setSoundValues(object);
               }
            }
         }
      }
      
      private static function setSoundValues(object:Object) : void
      {
         if(object.key == "settingSfx")
         {
            if(object.value)
            {
               DCSoundManager.getInstance().setSfxOn(true);
            }
            else
            {
               DCSoundManager.getInstance().setSfxOn(false);
            }
         }
         else if(object.key == "settingMusic")
         {
            if(object.value)
            {
               DCSoundManager.getInstance().setMusicOn(true);
            }
            else
            {
               DCSoundManager.getInstance().setMusicOn(false);
            }
         }
      }
      
      public static function markCollision(a:PhysicsGameObject, b:PhysicsGameObject) : Boolean
      {
         var aSound:* = null;
         var bSound:* = null;
         if(a is LevelGameObject || b is LevelGameObject)
         {
            if(a is LevelGameObject && b is LevelGameObject)
            {
               aSound = Sounds.getSoundReference((a as LevelGameObject).material);
               bSound = Sounds.getSoundReference((b as LevelGameObject).material);
               if(collisionTable[a] == b || collisionTable[b] == a)
               {
                  return false;
               }
               if(aSound && aSound.getCollisionPriority() <= bSound.getCollisionPriority())
               {
                  if(aSound.getCollision() != null)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",aSound.getMusicID(),aSound.getCollision(),aSound.getType()));
                  }
               }
               else if(bSound)
               {
                  if(bSound.getCollision() != null)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",bSound.getMusicID(),bSound.getCollision(),bSound.getType()));
                  }
               }
               collisionTable[a] = b;
               collisionTable[b] = a;
               return true;
            }
            if(b is LevelGameObject)
            {
               aSound = Sounds.getSoundReference(a.soundId);
               bSound = Sounds.getSoundReference((b as LevelGameObject).material);
               if(bSound && bSound.getCollision() != null)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",bSound.getMusicID(),bSound.getCollision(),bSound.getType()));
               }
               if(aSound && aSound.getCollision() != null)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",aSound.getMusicID(),aSound.getCollision(),aSound.getType()));
               }
               return true;
            }
            if(a is LevelGameObject)
            {
               bSound = Sounds.getSoundReference(b.soundId);
               aSound = Sounds.getSoundReference((a as LevelGameObject).material);
               if(bSound && bSound.getCollision() != null)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",bSound.getMusicID(),bSound.getCollision(),bSound.getType()));
               }
               if(aSound && aSound.getCollision() != null)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",aSound.getMusicID(),aSound.getCollision(),aSound.getType()));
               }
               return true;
            }
            return false;
         }
         bSound = Sounds.getSoundReference(b.soundId);
         aSound = Sounds.getSoundReference(a.soundId);
         if(bSound && bSound.getCollision() != null)
         {
            MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",bSound.getMusicID(),bSound.getCollision(),bSound.getType()));
         }
         if(aSound && aSound.getCollision() != null)
         {
            MessageCenter.sendEvent(new SoundMessage("PlayCollisionSound",aSound.getMusicID(),aSound.getCollision(),aSound.getType()));
         }
         return true;
      }
      
      private static function compareLoadNumber(a:SoundReference, b:SoundReference) : int
      {
         return a.getLoadNumber() - b.getLoadNumber();
      }
      
      public static function preLoadSounds() : void
      {
         var currentLoadNumber:int = 0;
         var currentPlayType:int = 0;
         var tempArray:* = null;
         var currentPlayTypeListIndex:int = 0;
         var _loc7_:ProjectManager = ProjectManager;
         var _loc8_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Sound");
         var mA:Array = _loc8_._rows;
         currentLoadNumberMaster = 0;
         currentPlayTypeMaster = 0;
         currentPlayTypeListIndexMaster = 0;
         for each(var r in mA)
         {
            musicArray.push(Sounds.getSoundReference(r.id));
         }
         musicArray.sort(compareLoadNumber);
         for(currentLoadNumber = currentLoadNumberMaster; currentLoadNumber < musicArray.length; )
         {
            if(musicArray[currentLoadNumber].getType() == "Music")
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
                  for(currentPlayType = currentPlayTypeMaster; currentPlayType < PlayTypeArray.length; )
                  {
                     tempArray = musicArray[currentLoadNumber].getArrayColumn(PlayTypeArray[currentPlayType]);
                     if(tempArray)
                     {
                        for(currentPlayTypeListIndex = currentPlayTypeListIndexMaster; currentPlayTypeListIndex < tempArray.length; )
                        {
                           if(tempArray[currentPlayTypeListIndex] != null)
                           {
                              DCSoundManager.getInstance().addCustomEventListener("complete",preLoadLoop,tempArray[currentPlayTypeListIndex]);
                              DCSoundManager.getInstance().addCustomEventListener("error",preLoadError,tempArray[currentPlayTypeListIndex]);
                              DCSoundManager.getInstance().loadSound(Config.getDataDir() + tempArray[currentPlayTypeListIndex],tempArray[currentPlayTypeListIndex],musicType);
                              currentLoadNumberMaster = currentLoadNumber;
                              currentPlayTypeMaster = currentPlayType;
                              currentPlayTypeListIndexMaster = currentPlayTypeListIndex;
                              return;
                           }
                           currentPlayTypeListIndex++;
                        }
                     }
                     currentPlayType++;
                  }
               }
            }
            currentLoadNumber++;
         }
      }
      
      private static function preLoadLoop(event:DCLoadingEvent) : void
      {
         LogUtils.log("Preloaded soundID: " + PlayTypeArray[currentPlayTypeMaster],"SoundManager",0,"Sounds",false,false,false);
         preLoadNext();
      }
      
      private static function preLoadError(event:DCLoadingEvent) : void
      {
         LogUtils.log("Failed to preload soundID: " + PlayTypeArray[currentPlayTypeMaster],"SoundManager",2,"Sounds",false,false,false);
         preLoadNext();
      }
      
      private static function preLoadNext() : void
      {
         var currentLoadNumber:int = 0;
         var currentPlayType:int = 0;
         var tempArray:* = null;
         var currentPlayTypeListIndex:int = 0;
         var soundType:Array = musicArray[currentLoadNumberMaster].getArrayColumn(PlayTypeArray[currentPlayTypeMaster]);
         DCSoundManager.getInstance().removeCustomEventListener("complete",preLoadLoop,soundType[currentPlayTypeListIndexMaster]);
         DCSoundManager.getInstance().removeCustomEventListener("error",preLoadError,soundType[currentPlayTypeListIndexMaster]);
         LogUtils.log("Loaded a sound: " + soundType[currentPlayTypeListIndexMaster],"SoundManager",0,"Sounds",false,false,false);
         for(currentLoadNumber = currentLoadNumberMaster; currentLoadNumber < musicArray.length; )
         {
            if(musicArray[currentLoadNumber].getType() == "Music")
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
                  for(currentPlayType = currentPlayTypeMaster; currentPlayType < PlayTypeArray.length; )
                  {
                     tempArray = musicArray[currentLoadNumber].getArrayColumn(PlayTypeArray[currentPlayType]);
                     if(tempArray)
                     {
                        if(tempArray.length > 1)
                        {
                           currentPlayTypeListIndexMaster++;
                        }
                        else
                        {
                           currentPlayTypeListIndexMaster = 1;
                        }
                        for(currentPlayTypeListIndex = currentPlayTypeListIndexMaster - 1; currentPlayTypeListIndex <= tempArray.length; )
                        {
                           if(tempArray[currentPlayTypeListIndex] != null)
                           {
                              if(!DCSoundManager.getInstance().isSoundLoaded(tempArray[currentPlayTypeListIndex]))
                              {
                                 DCSoundManager.getInstance().addCustomEventListener("complete",preLoadLoop,tempArray[currentPlayTypeListIndex]);
                                 DCSoundManager.getInstance().addCustomEventListener("error",preLoadError,tempArray[currentPlayTypeListIndex]);
                                 DCSoundManager.getInstance().loadSound(Config.getDataDir() + tempArray[currentPlayTypeListIndex],tempArray[currentPlayTypeListIndex],musicType);
                                 currentLoadNumberMaster = currentLoadNumber;
                                 currentPlayTypeMaster = currentPlayType;
                                 currentPlayTypeListIndexMaster = currentPlayTypeListIndex;
                                 return;
                              }
                           }
                           currentPlayTypeListIndex++;
                        }
                        currentPlayTypeListIndexMaster = 0;
                     }
                     currentPlayType++;
                  }
                  currentPlayTypeMaster = 0;
               }
            }
            currentLoadNumber++;
         }
      }
   }
}
