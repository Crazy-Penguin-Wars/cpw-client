package tuxwars.ui.popups.states
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class PopUpBaseLoadAssetsSubState extends TuxBatchLoadingState
   {
      private var screen:Class;
      
      private var logic:Class;
      
      public function PopUpBaseLoadAssetsSubState(param1:DCGame, param2:Class, param3:Class, param4:AssetsData, param5:* = null)
      {
         this.screen = param2;
         this.logic = param3;
         super(param1,param4,param5);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new PopUpBaseUISubState(game,this.screen,this.logic,params));
      }
   }
}

