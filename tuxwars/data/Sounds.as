package tuxwars.data
{
   import com.dchoc.events.DCSoundEvent;
   import com.dchoc.media.DCSoundManager;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   
   public class Sounds
   {
      
      private static const SOUNDS_CACHE:Object = {};
      
      private static var _themeplayed:Boolean = false;
      
      private static var _secondarythemeplayed:Boolean = false;
       
      
      public function Sounds()
      {
         super();
         throw new Error("Sounds is a static class!");
      }
      
      public static function getSoundReference(name:String) : SoundReference
      {
         if(SOUNDS_CACHE.hasOwnProperty(name))
         {
            return SOUNDS_CACHE[name];
         }
         var _loc2_:SoundReference = SoundReference.get(name);
         SOUNDS_CACHE[name] = _loc2_;
         if(_loc2_ == null)
         {
            LogUtils.log("SoundReference for " + name + " is null","SoundReference",0,"Warning",true,false,false);
         }
         return _loc2_;
      }
      
      public static function playTheme() : void
      {
         var sound:* = null;
         var _loc3_:SoundReference = Sounds.getSoundReference("GameAlmostOver");
         var _loc2_:SoundReference = Sounds.getSoundReference("BriefingMusic");
         if(!_themeplayed)
         {
            sound = Sounds.getSoundReference(Sounds.getMainMusicName());
            if(sound)
            {
               MessageCenter.sendEvent(new SoundMessage("PlayMusic",sound.getMusicID(),sound.getStart(),sound.getType()));
               DCSoundManager.getInstance().addCustomEventListener("soundComplete",startSecondaryMaintTheme,sound.getMusicID() + sound.getStart());
            }
            _themeplayed = true;
         }
         else if(SoundManager.isSoundPlaying(_loc3_.getMusicID(),_loc3_.getStart()))
         {
            if(_loc3_)
            {
               DCSoundManager.getInstance().addCustomEventListener("soundComplete",startBriefingMusic,_loc3_.getMusicID() + _loc3_.getStart());
            }
         }
         else if(SoundManager.isSoundPlaying(_loc2_.getMusicID(),_loc2_.getStart()))
         {
            if(_loc2_)
            {
               DCSoundManager.getInstance().addCustomEventListener("soundComplete",startSecondaryMaintTheme,_loc2_.getMusicID() + _loc2_.getStart());
            }
         }
         else
         {
            MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
            startSecondaryMaintTheme(null);
         }
      }
      
      private static function startSecondaryMaintTheme(event:DCSoundEvent) : void
      {
         MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
         var soundref:SoundReference = Sounds.getSoundReference(Sounds.getMainMusicName2());
         if(soundref)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",Sounds.getMainMusicName2(),soundref.getLoop(),soundref.getType()));
         }
         _secondarythemeplayed = true;
      }
      
      private static function startBriefingMusic(event:DCSoundEvent) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference("BriefingMusic");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType()));
         }
      }
      
      public static function playQueueTheme() : void
      {
         MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
         var sound:SoundReference = Sounds.getSoundReference(Sounds.getQueueIntro());
         if(sound)
         {
            MessageCenter.sendEvent(new SoundMessage("PlayMusic",sound.getMusicID(),sound.getStart(),sound.getType()));
            DCSoundManager.getInstance().addCustomEventListener("soundComplete",startSecondaryQueueTheme,sound.getMusicID() + sound.getStart());
         }
      }
      
      private static function startSecondaryQueueTheme(event:DCSoundEvent) : void
      {
         var soundref:SoundReference = Sounds.getSoundReference(Sounds.getQueueLoop());
         if(soundref)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",Sounds.getQueueLoop(),soundref.getLoop(),soundref.getType()));
         }
      }
      
      public static function playGuitar() : void
      {
         var sound2:SoundReference = Sounds.getSoundReference("BattleStart");
         if(sound2)
         {
            DCSoundManager.getInstance().loadSound(sound2.getStart(),sound2.getMusicID(),1);
            DCSoundManager.getInstance().playSound(sound2.getMusicID());
         }
      }
      
      public static function getMainMusicName() : String
      {
         return "ThemeMusic";
      }
      
      public static function getMainMusicName2() : String
      {
         return "ThemeMusic2";
      }
      
      public static function getBattleMusic() : String
      {
         return "BattleMusic";
      }
      
      public static function getQueueIntro() : String
      {
         return "QueueIntro";
      }
      
      public static function getQueueLoop() : String
      {
         return "QueueLoop";
      }
      
      public static function getWalk() : String
      {
         return "Walk";
      }
      
      public static function getJump() : String
      {
         return "Jump";
      }
      
      public static function getHurt() : String
      {
         return "Hurt";
      }
   }
}
