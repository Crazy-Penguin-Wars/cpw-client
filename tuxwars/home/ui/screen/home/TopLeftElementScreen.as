package tuxwars.home.ui.screen.home
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.components.TopBarLeftElement;
   import tuxwars.utils.TuxUiUtils;
   
   public class TopLeftElementScreen
   {
      
      private static const LEVEL:String = "HUD_Level";
       
      
      private var challengeWindowElement:ChallengesWindowElementScreen;
      
      private var levelElement:LevelElementScreen;
      
      private var topBarLeftElement:TopBarLeftElement;
      
      private var design:MovieClip;
      
      public function TopLeftElementScreen(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         super();
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         DCUtils.stopMovieClip(_loc3_);
         design = _loc3_.getChildByName("HUD_Level") as MovieClip;
         DCUtils.playMovieClip(design);
         challengeWindowElement = new ChallengesWindowElementScreen(design,game);
         levelElement = new LevelElementScreen(design,game);
         topBarLeftElement = new TopBarLeftElement(design.Top_Bar_Left,game);
         TuxUiUtils.setMovieClipPosition(design,"top","left");
         whereToAdd.addChild(design);
      }
      
      public function dispose() : void
      {
         challengeWindowElement.dispose();
         challengeWindowElement = null;
         levelElement.dispose();
         levelElement = null;
         topBarLeftElement.dispose();
         topBarLeftElement = null;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         levelElement.logicUpdate(deltaTime);
      }
      
      public function getLevelElement() : LevelElementScreen
      {
         return levelElement;
      }
      
      public function getChallengeElement() : ChallengesWindowElementScreen
      {
         return challengeWindowElement;
      }
      
      public function fullscreenChanged(fullscreen:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(design,"top","left");
      }
   }
}
