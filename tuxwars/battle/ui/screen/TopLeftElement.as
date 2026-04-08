package tuxwars.battle.ui.screen
{
   import com.dchoc.resources.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.timer.*;
   import tuxwars.utils.*;
   
   public class TopLeftElement
   {
      private var matchTimerElement:MatchTimerElement;
      
      private var _design:MovieClip;
      
      public function TopLeftElement(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","ingame_hud");
         this._design = _loc3_.Top_Left;
         this._design.mouseChildren = false;
         this._design.mouseEnabled = false;
         this.matchTimerElement = new MatchTimerElement(this._design);
         TuxUiUtils.setMovieClipPosition(this._design,"top","right");
         param1.addChild(this._design);
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.matchTimerElement.logicUpdate(param1);
      }
      
      public function dispose() : void
      {
         this.matchTimerElement.dispose();
         this.matchTimerElement = null;
      }
      
      public function fullscreenChanged(param1:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(this._design,"top","right");
      }
      
      public function getMatchTimerElement() : MatchTimerElement
      {
         return this.matchTimerElement;
      }
   }
}

