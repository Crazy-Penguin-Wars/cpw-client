package tuxwars.home.states
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import tuxwars.battle.data.particles.*;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.home.states.homestate.*;
   import tuxwars.states.TuxBatchLoadingState;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.error.*;
   
   public class BattleLoadAssetsSubState extends TuxBatchLoadingState
   {
      private var loadedAssets:Boolean;
      
      private var particlesLoaded:Boolean;
      
      public function BattleLoadAssetsSubState(param1:DCGame, param2:AssetsData, param3:* = null)
      {
         super(param1,param2,param3);
      }
      
      override public function enter() : void
      {
         super.enter();
         if(!DCResourceManager.instance.isLoaded("particles/particles.xml"))
         {
            DCResourceManager.instance.addCustomEventListener("complete",this.particleFileLoaded,"particles/particles.xml");
            DCResourceManager.instance.load(Config.getDataDir() + "particles/particles.xml","particles/particles.xml","TextFile",true);
         }
         else
         {
            Particles.setParticleData(DCResourceManager.instance.get("particles/particles.xml"));
            this.particlesLoaded = true;
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(Boolean(this.loadedAssets) && Boolean(this.particlesLoaded))
         {
            this.finished();
         }
      }
      
      protected function finished() : void
      {
      }
      
      override protected function assetLoadError(param1:String) : void
      {
         LogUtils.log("Assets loading failed: " + param1,this,1,"ErrorLogging");
         tuxGame.changeState(new HomeState(tuxGame,false),true);
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.addPopup(new ErrorPopupSubState(tuxGame,{
            "description":ProjectManager.getText("ASSET_LOAD_FAILED"),
            "product":"AssetLoadFailed"
         }));
         if(!PopUpManager.instance)
         {
            PopUpManager.instance = new PopUpManager();
         }
         PopUpManager.instance.showPopUps(tuxGame.homeState);
      }
      
      override protected function assetsLoaded() : void
      {
         this.loadedAssets = true;
      }
      
      private function particleFileLoaded(param1:DCLoadingEvent) : void
      {
         Particles.setParticleData(DCResourceManager.instance.get("particles/particles.xml"));
         this.particlesLoaded = true;
      }
   }
}

