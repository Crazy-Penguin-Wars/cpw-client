package tuxwars.data
{
   import com.dchoc.events.DCSoundEvent;
   import com.dchoc.media.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   
   public class Sounds
   {
      private static var _themeplayed:Boolean = false;
      
      private static var _secondarythemeplayed:Boolean = false;
      
      private static const SOUNDS_CACHE:Object = {};
      
      public function Sounds()
      {
         super();
         throw new Error("Sounds is a static class!");
      }
      
      public static function getSoundReference(param1:String) : SoundReference
      {
         if(SOUNDS_CACHE.hasOwnProperty(param1))
         {
            return SOUNDS_CACHE[param1];
         }
         var _loc2_:SoundReference = SoundReference.get(param1);
         SOUNDS_CACHE[param1] = _loc2_;
         if(_loc2_ == null)
         {
            LogUtils.log("SoundReference for " + param1 + " is null","SoundReference",0,"Warning",true,false,false);
         }
         return _loc2_;
      }
      
      public static function playTheme() : void
      {
         var _loc1_:SoundReference = null;
         var _loc2_:SoundReference = Sounds.getSoundReference("GameAlmostOver");
         var _loc3_:SoundReference = Sounds.getSoundReference("BriefingMusic");
         if(!_themeplayed)
         {
            _loc1_ = Sounds.getSoundReference(Sounds.getMainMusicName());
            if(_loc1_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlayMusic",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType()));
               DCSoundManager.getInstance().addCustomEventListener("soundComplete",startSecondaryMaintTheme,_loc1_.getMusicID() + _loc1_.getStart());
            }
            _themeplayed = true;
         }
         else if(SoundManager.isSoundPlaying(_loc2_.getMusicID(),_loc2_.getStart()))
         {
            if(_loc2_)
            {
               DCSoundManager.getInstance().addCustomEventListener("soundComplete",startBriefingMusic,_loc2_.getMusicID() + _loc2_.getStart());
            }
         }
         else if(SoundManager.isSoundPlaying(_loc3_.getMusicID(),_loc3_.getStart()))
         {
            if(_loc3_)
            {
               DCSoundManager.getInstance().addCustomEventListener("soundComplete",startSecondaryMaintTheme,_loc3_.getMusicID() + _loc3_.getStart());
            }
         }
         else
         {
            MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
            startSecondaryMaintTheme(null);
         }
      }
      
      private static function startSecondaryMaintTheme(param1:DCSoundEvent) : void
      {
         MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
         var _loc2_:SoundReference = Sounds.getSoundReference(Sounds.getMainMusicName2());
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",Sounds.getMainMusicName2(),_loc2_.getLoop(),_loc2_.getType()));
         }
         _secondarythemeplayed = true;
      }
      
      private static function startBriefingMusic(param1:DCSoundEvent) : void
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
         var _loc1_:SoundReference = Sounds.getSoundReference(Sounds.getQueueIntro());
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlayMusic",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType()));
            DCSoundManager.getInstance().addCustomEventListener("soundComplete",startSecondaryQueueTheme,_loc1_.getMusicID() + _loc1_.getStart());
         }
      }
      
      private static function startSecondaryQueueTheme(param1:DCSoundEvent) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference(Sounds.getQueueLoop());
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",Sounds.getQueueLoop(),_loc2_.getLoop(),_loc2_.getType()));
         }
      }
      
      public static function playGuitar() : void
      {
         var _loc1_:SoundReference = Sounds.getSoundReference("BattleStart");
         if(_loc1_)
         {
            DCSoundManager.getInstance().loadSound(_loc1_.getStart(),_loc1_.getMusicID(),1);
            DCSoundManager.getInstance().playSound(_loc1_.getMusicID());
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

