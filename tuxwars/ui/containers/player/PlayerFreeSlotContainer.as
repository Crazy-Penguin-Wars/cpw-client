package tuxwars.ui.containers.player
{
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.utils.*;
   
   public class PlayerFreeSlotContainer extends UIContainer
   {
      public function PlayerFreeSlotContainer(param1:MovieClip, param2:int)
      {
         super(param1);
         TuxUiUtils.createAutoTextField(param1.Text,"PLAYER_FREE_SLOT");
         TuxUiUtils.createAutoTextField(param1.Text_Player,"PLAYER_" + param2);
      }
   }
}

