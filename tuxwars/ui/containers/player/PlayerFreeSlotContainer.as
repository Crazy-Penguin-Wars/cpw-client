package tuxwars.ui.containers.player
{
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.utils.TuxUiUtils;
   
   public class PlayerFreeSlotContainer extends UIContainer
   {
       
      
      public function PlayerFreeSlotContainer(design:MovieClip, index:int)
      {
         super(design);
         TuxUiUtils.createAutoTextField(design.Text,"PLAYER_FREE_SLOT");
         TuxUiUtils.createAutoTextField(design.Text_Player,"PLAYER_" + index);
      }
   }
}
