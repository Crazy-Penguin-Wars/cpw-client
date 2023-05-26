package tuxwars.home.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.BatchLoader;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxState;
   
   public class BattleAssetLoadingSubState extends TuxState
   {
       
      
      private const batchLoaders:Vector.<BatchLoader> = new Vector.<BatchLoader>();
      
      private var numLoadedBatches:int;
      
      public function BattleAssetLoadingSubState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.addListener("FilesLoaded",assetsLoadedResponse);
         load(AssetsData.getBattleAssets());
         load(AssetsData.getBattleSharedAssets());
      }
      
      private function load(assetData:AssetsData) : void
      {
         var _loc2_:BatchLoader = new BatchLoader(assetData.getAssets());
         batchLoaders.push(_loc2_);
         _loc2_.load(assetData.isUseContext());
      }
      
      override public function exit() : void
      {
         super.exit();
         batchLoaders.splice(0,batchLoaders.length);
         MessageCenter.removeListener("FilesLoaded",assetsLoadedResponse);
      }
      
      private function assetsLoadedResponse(msg:Message) : void
      {
         if(loadersContainId(msg.data))
         {
            numLoadedBatches++;
            if(numLoadedBatches >= batchLoaders.length)
            {
               MessageCenter.sendMessage("BattleAssetsLoaded");
            }
         }
      }
      
      private function loadersContainId(id:String) : Boolean
      {
         for each(var loader in batchLoaders)
         {
            if(loader.id == id)
            {
               return true;
            }
         }
         return false;
      }
   }
}
