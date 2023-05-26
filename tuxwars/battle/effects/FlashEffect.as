package tuxwars.battle.effects
{
   import com.dchoc.game.DCGame;
   import com.nnyman.tween.Sequence;
   import fl.motion.easing.Linear;
   import flash.display.MovieClip;
   
   public class FlashEffect
   {
      
      private static var FLASH:MovieClip;
       
      
      public function FlashEffect()
      {
         super();
         throw new Error("FlashEffect is a static class!");
      }
      
      public static function execute() : void
      {
         if(FLASH)
         {
            return;
         }
         init();
         var _loc2_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.addChild(FLASH);
         var _loc1_:Sequence = new Sequence();
         _loc1_.add({
            "target":FLASH,
            "alpha":1
         });
         _loc1_.add({
            "target":FLASH,
            "alpha":0,
            "duration":1,
            "easing":Linear.easeIn
         });
         _loc1_.add({"call":flashFinished});
         _loc1_.start();
      }
      
      private static function flashFinished() : void
      {
         var _loc1_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.removeChild(FLASH);
         FLASH = null;
      }
      
      private static function init() : void
      {
         FLASH = new MovieClip();
         FLASH.graphics.beginFill(16777215);
         var _loc1_:DCGame = DCGame;
         var _loc2_:DCGame = DCGame;
         FLASH.graphics.drawRect(0,0,com.dchoc.game.DCGame._stage.stageWidth,com.dchoc.game.DCGame._stage.stageHeight);
         FLASH.graphics.endFill();
         FLASH.stop();
      }
   }
}
