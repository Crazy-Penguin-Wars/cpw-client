package tuxwars.ui.popups.states
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class PopUpBaseLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      private var screen:Class;
      
      private var logic:Class;
      
      public function PopUpBaseLoadAssetsSubState(game:DCGame, screen:Class, logic:Class, assetsData:AssetsData, params:* = null)
      {
         this.screen = screen;
         this.logic = logic;
         super(game,assetsData,params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new PopUpBaseUISubState(game,screen,logic,params));
      }
   }
}
