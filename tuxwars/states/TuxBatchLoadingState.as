package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import tuxwars.*;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.components.*;
   
   public class TuxBatchLoadingState extends TuxState
   {
      private var batch:BatchLoader;
      
      private var assetsData:AssetsData;
      
      private var loadingScreen:LoadingIndicatorScreen;
      
      public function TuxBatchLoadingState(param1:DCGame, param2:AssetsData, param3:* = null)
      {
         super(param1,param3);
         this.assetsData = param2;
      }
      
      override public function enter() : void
      {
         super.enter();
         this.loadingScreen = new LoadingIndicatorScreen(game as TuxWarsGame,"LOADING_RESOUNRCE_FROM_NET");
         MessageCenter.addListener("FilesLoaded",this.filesLoaded);
         MessageCenter.addListener("LoadError",this.loadError);
         this.batch = new BatchLoader(this.assetsData.getAssets());
         this.batch.load(this.assetsData.isUseContext());
      }
      
      override public function exit() : void
      {
         super.exit();
         this.loadingScreen.dispose();
         this.loadingScreen = null;
         this.batch = null;
         this.assetsData = null;
         MessageCenter.removeListener("FilesLoaded",this.filesLoaded);
         MessageCenter.removeListener("LoadError",this.loadError);
      }
      
      protected function assetsLoaded() : void
      {
      }
      
      protected function assetLoadError(param1:String) : void
      {
      }
      
      private function loadError(param1:Message) : void
      {
         if(param1.data.id == this.batch.id)
         {
            this.assetLoadError(param1.data.resource);
         }
      }
      
      private function filesLoaded(param1:Message) : void
      {
         if(param1.data == this.batch.id)
         {
            this.assetsLoaded();
         }
      }
   }
}

