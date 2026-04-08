package tuxwars.battle.ui.screen
{
   import com.dchoc.resources.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.timer.*;
   import tuxwars.utils.*;
   
   public class TopRightElement
   {
      private static const TOP_RIGHT:String = "Top_Right";
      
      private var challengesElement:BattleHudChallengesElement;
      
      private var playerTimerElementsContainer:PlayerTimerContainer;
      
      private var _design:MovieClip;
      
      private var game:TuxWarsGame;
      
      public function TopRightElement(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         this.game = param2;
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","ingame_hud");
         this._design = _loc3_.Top_Right;
         this._design.mouseEnabled = false;
         this.playerTimerElementsContainer = new PlayerTimerContainer(this._design);
         this.challengesElement = new BattleHudChallengesElement(this._design,param2);
         TuxUiUtils.setMovieClipPosition(this._design,"top","left");
         param1.addChild(this._design);
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      public function logicUpdate(param1:int) : void
      {
         (this.playerTimerElementsContainer.getContainer(this.playerTimerElementsContainer.getCurrentContainerId()) as PlayerTimerElement).logicUpdate(param1);
      }
      
      public function dispose() : void
      {
         this.playerTimerElementsContainer.dispose();
         this.playerTimerElementsContainer = null;
         this.challengesElement.dispose();
         this.challengesElement = null;
         this.game = null;
      }
      
      public function getPlayerTimerContainer() : PlayerTimerContainer
      {
         return this.playerTimerElementsContainer;
      }
      
      public function fullscreenChanged(param1:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(this._design,"top","left");
      }
   }
}

