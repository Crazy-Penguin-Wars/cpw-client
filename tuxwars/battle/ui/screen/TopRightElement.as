package tuxwars.battle.ui.screen
{
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.timer.PlayerTimerContainer;
   import tuxwars.battle.ui.screen.timer.PlayerTimerElement;
   import tuxwars.utils.TuxUiUtils;
   
   public class TopRightElement
   {
      
      private static const TOP_RIGHT:String = "Top_Right";
       
      
      private var challengesElement:BattleHudChallengesElement;
      
      private var playerTimerElementsContainer:PlayerTimerContainer;
      
      private var _design:MovieClip;
      
      private var game:TuxWarsGame;
      
      public function TopRightElement(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         super();
         this.game = game;
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","ingame_hud");
         _design = _loc3_.Top_Right;
         _design.mouseEnabled = false;
         playerTimerElementsContainer = new PlayerTimerContainer(_design);
         challengesElement = new BattleHudChallengesElement(_design,game);
         TuxUiUtils.setMovieClipPosition(_design,"top","left");
         whereToAdd.addChild(_design);
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         (playerTimerElementsContainer.getContainer(playerTimerElementsContainer.getCurrentContainerId()) as PlayerTimerElement).logicUpdate(deltaTime);
      }
      
      public function dispose() : void
      {
         playerTimerElementsContainer.dispose();
         playerTimerElementsContainer = null;
         challengesElement.dispose();
         challengesElement = null;
         game = null;
      }
      
      public function getPlayerTimerContainer() : PlayerTimerContainer
      {
         return playerTimerElementsContainer;
      }
      
      public function fullscreenChanged(fullscreen:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(_design,"top","left");
      }
   }
}
