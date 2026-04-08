package tuxwars.battle.ui.screen.timer
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.*;
   import tuxwars.battle.ui.logic.BattleHudPlayerData;
   
   public class PlayerTimerContainer extends UIContainers
   {
      private static const MAX_PLAYER:int = 4;
      
      public static const TURN_TIMER:String = "Turn_Timer_";
      
      private var currentPlayer:BattleHudPlayerData;
      
      public function PlayerTimerContainer(param1:MovieClip, param2:UIComponent = null)
      {
         var _loc3_:int = 0;
         super();
         _loc3_ = 1;
         while(_loc3_ <= 4)
         {
            add("Turn_Timer_" + _loc3_,new PlayerTimerElement(param1.getChildByName("Turn_Timer_" + _loc3_) as MovieClip,param2));
            _loc3_++;
         }
         show("Turn_Timer_" + 1,false);
      }
      
      public function changeTimer(param1:BattleHudPlayerData, param2:int) : Boolean
      {
         if(param1 != this.currentPlayer && param1.status == "Active")
         {
            this.currentPlayer = param1;
            show("Turn_Timer_" + param2,false);
            this.getPlayerTimerElement().setFirstPlayer(param1.place == 1);
            this.getPlayerTimerElement().setPlayerAvatar(param1.avatarTimer);
            this.getPlayerTimerElement().setText(param1.name);
            this.getPlayerTimerElement().update();
            return true;
         }
         return false;
      }
      
      public function getPlayerTimerElement() : PlayerTimerElement
      {
         return getContainer(getCurrentContainerId()) as PlayerTimerElement;
      }
   }
}

