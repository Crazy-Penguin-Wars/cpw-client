package tuxwars.home.states
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.data.particles.Particles;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.states.TuxBatchLoadingState;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.error.ErrorPopupSubState;
   
   public class BattleLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      private var loadedAssets:Boolean;
      
      private var particlesLoaded:Boolean;
      
      public function BattleLoadAssetsSubState(game:DCGame, assetsData:AssetsData, params:* = null)
      {
         super(game,assetsData,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         if(!DCResourceManager.instance.isLoaded("particles/particles.xml"))
         {
            DCResourceManager.instance.addCustomEventListener("complete",particleFileLoaded,"particles/particles.xml");
            DCResourceManager.instance.load(Config.getDataDir() + "particles/particles.xml","particles/particles.xml","TextFile",true);
         }
         else
         {
            Particles.setParticleData(DCResourceManager.instance.get("particles/particles.xml"));
            particlesLoaded = true;
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(loadedAssets && particlesLoaded)
         {
            finished();
         }
      }
      
      protected function finished() : void
      {
      }
      
      override protected function assetLoadError(asset:String) : void
      {
         LogUtils.log("Assets loading failed: " + asset,this,1,"ErrorLogging");
         tuxGame.changeState(new HomeState(tuxGame,false),true);
         var _loc2_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.addPopup(new ErrorPopupSubState(tuxGame,{
            "description":ProjectManager.getText("ASSET_LOAD_FAILED"),
            "product":"AssetLoadFailed"
         }));
         var _loc3_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.showPopUps(tuxGame.homeState);
      }
      
      override protected function assetsLoaded() : void
      {
         loadedAssets = true;
      }
      
      private function particleFileLoaded(event:DCLoadingEvent) : void
      {
         Particles.setParticleData(DCResourceManager.instance.get("particles/particles.xml"));
         particlesLoaded = true;
      }
   }
}
