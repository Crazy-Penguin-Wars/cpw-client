package tuxwars.battle.ui.screen.tab
{
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.BattleHudLogic;
   import tuxwars.battle.ui.logic.BattleHudPlayerData;
   import tuxwars.battle.ui.screen.timer.MatchTimerElement;
   import tuxwars.battle.ui.screen.timer.PlayerTimerContainer;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class BattleHudTabElement extends TuxUIElementScreen
   {
      
      private static const PLAYER_SLOT:String = "Slot_";
      
      private static const NUMBER_OF_PLAYER_TABS:int = 4;
       
      
      private var playerTabs:Object;
      
      private var playerTimerContainer:PlayerTimerContainer;
      
      private var matchTimer:MatchTimerElement;
      
      public function BattleHudTabElement(design:MovieClip, game:TuxWarsGame, playerTimerContainer:PlayerTimerContainer, matchTimer:MatchTimerElement)
      {
         var j:int = 0;
         super(design,game);
         this.playerTimerContainer = playerTimerContainer;
         this.matchTimer = matchTimer;
         playerTabs = {};
         for(j = 1; j <= 4; )
         {
            playerTabs["Slot_" + j] = new PlayerTabContainer(design.getChildByName("Slot_" + j) as MovieClip,this,"Player " + j);
            j++;
         }
      }
      
      override public function dispose() : void
      {
         for each(var container in playerTabs)
         {
            container.dispose();
         }
         DCUtils.deleteProperties(playerTabs);
         playerTimerContainer.dispose();
         playerTimerContainer = null;
         matchTimer.dispose();
         matchTimer = null;
         super.dispose();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         var j:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = 0;
         super.logicUpdate(deltaTime);
         var _loc4_:Object = battleHudLogic.getHudPlayersData();
         for(j = 1; j <= 4; )
         {
            _loc2_ = _loc4_["Player_" + j];
            _loc3_ = _loc2_.tabIndex > 0 ? _loc2_.tabIndex : j;
            PlayerTabContainer(playerTabs["Slot_" + _loc3_]).updateTabState(_loc2_);
            playerTimerContainer.changeTimer(_loc2_,j);
            j++;
         }
      }
      
      private function get battleHudLogic() : BattleHudLogic
      {
         return logic;
      }
   }
}
