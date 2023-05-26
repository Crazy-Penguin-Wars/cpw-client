package tuxwars.battle.ui.screen.timer
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.battle.ui.logic.BattleHudPlayerData;
   
   public class PlayerTimerContainer extends UIContainers
   {
      
      private static const MAX_PLAYER:int = 4;
      
      public static const TURN_TIMER:String = "Turn_Timer_";
       
      
      private var currentPlayer:BattleHudPlayerData;
      
      public function PlayerTimerContainer(design:MovieClip, parent:UIComponent = null)
      {
         var i:int = 0;
         super();
         for(i = 1; i <= 4; )
         {
            add("Turn_Timer_" + i,new PlayerTimerElement(design.getChildByName("Turn_Timer_" + i) as MovieClip,parent));
            i++;
         }
         show("Turn_Timer_" + 1,false);
      }
      
      public function changeTimer(player:BattleHudPlayerData, indexOfPlayer:int) : Boolean
      {
         if(player != currentPlayer && player.status == "Active")
         {
            currentPlayer = player;
            show("Turn_Timer_" + indexOfPlayer,false);
            getPlayerTimerElement().setFirstPlayer(player.place == 1);
            getPlayerTimerElement().setPlayerAvatar(player.avatarTimer);
            getPlayerTimerElement().setText(player.name);
            getPlayerTimerElement().update();
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
