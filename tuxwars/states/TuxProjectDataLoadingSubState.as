package tuxwars.states
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import tuxwars.*;
   
   public class TuxProjectDataLoadingSubState extends TuxState
   {
      public function TuxProjectDataLoadingSubState(param1:DCGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         DCResourceManager.instance.addCustomEventListener("error",this.textLoadingErrorHandler,Assets.getLanguageFile());
         DCResourceManager.instance.load(Config.getDataDir() + "json/tuxwars_config_base.json","json/tuxwars_config_base.json");
         DCResourceManager.instance.load(Config.getDataDir() + Assets.getLanguageFile(),Assets.getLanguageFile());
      }
      
      override public function exit() : void
      {
         DCResourceManager.instance.removeCustomEventListener("error",this.textLoadingErrorHandler,Assets.getLanguageFile());
         super.exit();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(Boolean(DCResourceManager.instance.isLoaded("json/tuxwars_config_base.json")) && Boolean(DCResourceManager.instance.isLoaded(Assets.getLanguageFile())))
         {
            ProjectManager.init();
            parent.exitCurrentState();
         }
      }
      
      private function textLoadingErrorHandler(param1:DCLoadingEvent) : void
      {
         Config.setLanguageCode("en");
         DCResourceManager.instance.load(Config.getDataDir() + Assets.getLanguageFile(),Assets.getLanguageFile());
      }
   }
}

