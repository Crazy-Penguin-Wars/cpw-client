package tuxwars.home.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxState;
   
   public class BattleAssetLoadingSubState extends TuxState
   {
      private const batchLoaders:Vector.<BatchLoader> = new Vector.<BatchLoader>();
      
      private var numLoadedBatches:int;
      
      public function BattleAssetLoadingSubState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.addListener("FilesLoaded",this.assetsLoadedResponse);
         this.load(AssetsData.getBattleAssets());
         this.load(AssetsData.getBattleSharedAssets());
      }
      
      private function load(param1:AssetsData) : void
      {
         var _loc2_:BatchLoader = new BatchLoader(param1.getAssets());
         this.batchLoaders.push(_loc2_);
         _loc2_.load(param1.isUseContext());
      }
      
      override public function exit() : void
      {
         super.exit();
         this.batchLoaders.splice(0,this.batchLoaders.length);
         MessageCenter.removeListener("FilesLoaded",this.assetsLoadedResponse);
      }
      
      private function assetsLoadedResponse(param1:Message) : void
      {
         if(this.loadersContainId(param1.data))
         {
            ++this.numLoadedBatches;
            if(this.numLoadedBatches >= this.batchLoaders.length)
            {
               MessageCenter.sendMessage("BattleAssetsLoaded");
            }
         }
      }
      
      private function loadersContainId(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.batchLoaders)
         {
            if(_loc2_.id == param1)
            {
               return true;
            }
         }
         return false;
      }
   }
}

