package tuxwars.battle.ui.screen
{
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.timer.MatchTimerElement;
   import tuxwars.utils.TuxUiUtils;
   
   public class TopLeftElement
   {
       
      
      private var matchTimerElement:MatchTimerElement;
      
      private var _design:MovieClip;
      
      public function TopLeftElement(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         super();
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","ingame_hud");
         _design = _loc3_.Top_Left;
         _design.mouseChildren = false;
         _design.mouseEnabled = false;
         matchTimerElement = new MatchTimerElement(_design);
         TuxUiUtils.setMovieClipPosition(_design,"top","right");
         whereToAdd.addChild(_design);
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         matchTimerElement.logicUpdate(deltaTime);
      }
      
      public function dispose() : void
      {
         matchTimerElement.dispose();
         matchTimerElement = null;
      }
      
      public function fullscreenChanged(fullScreen:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(_design,"top","right");
      }
      
      public function getMatchTimerElement() : MatchTimerElement
      {
         return matchTimerElement;
      }
   }
}
