package tuxwars.home.ui.screen.home
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
   public class TopLeftElementScreen
   {
      private static const LEVEL:String = "HUD_Level";
      
      private var challengeWindowElement:ChallengesWindowElementScreen;
      
      private var levelElement:LevelElementScreen;
      
      private var topBarLeftElement:TopBarLeftElement;
      
      private var design:MovieClip;
      
      public function TopLeftElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         DCUtils.stopMovieClip(_loc3_);
         this.design = _loc3_.getChildByName("HUD_Level") as MovieClip;
         DCUtils.playMovieClip(this.design);
         this.challengeWindowElement = new ChallengesWindowElementScreen(this.design,param2);
         this.levelElement = new LevelElementScreen(this.design,param2);
         this.topBarLeftElement = new TopBarLeftElement(this.design.Top_Bar_Left,param2);
         TuxUiUtils.setMovieClipPosition(this.design,"top","left");
         param1.addChild(this.design);
      }
      
      public function dispose() : void
      {
         this.challengeWindowElement.dispose();
         this.challengeWindowElement = null;
         this.levelElement.dispose();
         this.levelElement = null;
         this.topBarLeftElement.dispose();
         this.topBarLeftElement = null;
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.levelElement.logicUpdate(param1);
      }
      
      public function getLevelElement() : LevelElementScreen
      {
         return this.levelElement;
      }
      
      public function getChallengeElement() : ChallengesWindowElementScreen
      {
         return this.challengeWindowElement;
      }
      
      public function fullscreenChanged(param1:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(this.design,"top","left");
      }
   }
}

