package tuxwars.states
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import tuxwars.Assets;
   
   public class TuxProjectDataLoadingSubState extends TuxState
   {
       
      
      public function TuxProjectDataLoadingSubState(game:DCGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         DCResourceManager.instance.addCustomEventListener("error",textLoadingErrorHandler,Assets.getLanguageFile());
         DCResourceManager.instance.load(Config.getDataDir() + "json/tuxwars_config_base.json","json/tuxwars_config_base.json");
         DCResourceManager.instance.load(Config.getDataDir() + Assets.getLanguageFile(),Assets.getLanguageFile());
      }
      
      override public function exit() : void
      {
         DCResourceManager.instance.removeCustomEventListener("error",textLoadingErrorHandler,Assets.getLanguageFile());
         super.exit();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(DCResourceManager.instance.isLoaded("json/tuxwars_config_base.json") && DCResourceManager.instance.isLoaded(Assets.getLanguageFile()))
         {
            ProjectManager.init();
            parent.exitCurrentState();
         }
      }
      
      private function textLoadingErrorHandler(event:DCLoadingEvent) : void
      {
         Config.setLanguageCode("en");
         DCResourceManager.instance.load(Config.getDataDir() + Assets.getLanguageFile(),Assets.getLanguageFile());
      }
   }
}
