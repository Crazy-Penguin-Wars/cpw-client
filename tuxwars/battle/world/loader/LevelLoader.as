package tuxwars.battle.world.loader
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   
   public class LevelLoader
   {
      
      public static const LEVEL_LOADED:String = "LevelLoaded";
       
      
      private var level:Level;
      
      private var levelId:String;
      
      public function LevelLoader()
      {
         super();
      }
      
      public function loadLevel(level:String, levelId:String) : void
      {
         LogUtils.log("Loading level: " + level,this);
         this.levelId = levelId;
         if(!DCResourceManager.instance.isLoaded(level))
         {
            DCResourceManager.instance.addCustomEventListener("complete",levelFileLoaded,level);
            DCResourceManager.instance.load(Config.getDataDir() + level,level,"TextFile",true);
         }
         else
         {
            parseLevelFile(DCResourceManager.instance.get(level));
         }
      }
      
      public function dispose() : void
      {
         level = null;
      }
      
      public function getLevel() : Level
      {
         return level;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         if(level.isLoaded())
         {
            MessageCenter.sendMessage("LevelLoaded");
            LogicUpdater.unregister(this);
         }
      }
      
      private function levelFileLoaded(event:DCLoadingEvent) : void
      {
         parseLevelFile(DCResourceManager.instance.get(event.resourceName));
      }
      
      private function parseLevelFile(levelData:String) : void
      {
         try
         {
            level = new Level(JSON.parse(levelData),levelId);
            LogicUpdater.register(this);
         }
         catch(e:Error)
         {
            MessageCenter.sendEvent(new ErrorMessage("Level Loading Error","parseLevelFile",e.message.toString(),null,e));
         }
      }
   }
}
