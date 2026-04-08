package tuxwars.battle.effects
{
   import com.dchoc.game.DCGame;
   import com.nnyman.tween.*;
   import fl.motion.easing.*;
   import flash.display.*;
   
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
         DCGame.getStage().addChild(FLASH);
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
         DCGame.getStage().removeChild(FLASH);
         FLASH = null;
      }
      
      private static function init() : void
      {
         FLASH = new MovieClip();
         FLASH.graphics.beginFill(16777215);
         FLASH.graphics.drawRect(0,0,DCGame.getStage().stageWidth,DCGame.getStage().stageHeight);
         FLASH.graphics.endFill();
         FLASH.stop();
      }
   }
}

