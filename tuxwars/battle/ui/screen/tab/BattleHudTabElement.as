package tuxwars.battle.ui.screen.tab
{
   import com.dchoc.utils.*;
   import flash.display.*;
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
      
      public function BattleHudTabElement(param1:MovieClip, param2:TuxWarsGame, param3:PlayerTimerContainer, param4:MatchTimerElement)
      {
         var _loc5_:int = 0;
         super(param1,param2);
         this.playerTimerContainer = param3;
         this.matchTimer = param4;
         this.playerTabs = {};
         _loc5_ = 1;
         while(_loc5_ <= 4)
         {
            this.playerTabs["Slot_" + _loc5_] = new PlayerTabContainer(param1.getChildByName("Slot_" + _loc5_) as MovieClip,this,"Player " + _loc5_);
            _loc5_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.playerTabs)
         {
            _loc1_.dispose();
         }
         DCUtils.deleteProperties(this.playerTabs);
         this.playerTimerContainer.dispose();
         this.playerTimerContainer = null;
         this.matchTimer.dispose();
         this.matchTimer = null;
         super.dispose();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BattleHudPlayerData = null;
         var _loc4_:* = 0;
         super.logicUpdate(param1);
         var _loc5_:Object = this.battleHudLogic.getHudPlayersData();
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            _loc3_ = _loc5_["Player_" + _loc2_];
            _loc4_ = _loc3_.tabIndex > 0 ? _loc3_.tabIndex : _loc2_;
            PlayerTabContainer(this.playerTabs["Slot_" + _loc4_]).updateTabState(_loc3_);
            this.playerTimerContainer.changeTimer(_loc3_,_loc2_);
            _loc2_++;
         }
      }
      
      private function get battleHudLogic() : BattleHudLogic
      {
         return logic;
      }
   }
}

