package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.BatchLoader;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.components.LoadingIndicatorScreen;
   
   public class TuxBatchLoadingState extends TuxState
   {
       
      
      private var batch:BatchLoader;
      
      private var assetsData:AssetsData;
      
      private var loadingScreen:LoadingIndicatorScreen;
      
      public function TuxBatchLoadingState(game:DCGame, assetsData:AssetsData, params:* = null)
      {
         super(game,params);
         this.assetsData = assetsData;
      }
      
      override public function enter() : void
      {
         super.enter();
         loadingScreen = new LoadingIndicatorScreen(game as TuxWarsGame,"LOADING_RESOUNRCE_FROM_NET");
         MessageCenter.addListener("FilesLoaded",filesLoaded);
         MessageCenter.addListener("LoadError",loadError);
         batch = new BatchLoader(assetsData.getAssets());
         batch.load(assetsData.isUseContext());
      }
      
      override public function exit() : void
      {
         super.exit();
         loadingScreen.dispose();
         loadingScreen = null;
         batch = null;
         assetsData = null;
         MessageCenter.removeListener("FilesLoaded",filesLoaded);
         MessageCenter.removeListener("LoadError",loadError);
      }
      
      protected function assetsLoaded() : void
      {
      }
      
      protected function assetLoadError(asset:String) : void
      {
      }
      
      private function loadError(msg:Message) : void
      {
         if(msg.data.id == batch.id)
         {
            assetLoadError(msg.data.resource);
         }
      }
      
      private function filesLoaded(msg:Message) : void
      {
         if(msg.data == batch.id)
         {
            assetsLoaded();
         }
      }
   }
}
