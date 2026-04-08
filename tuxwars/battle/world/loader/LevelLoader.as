package tuxwars.battle.world.loader
{
   import com.dchoc.events.*;
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   
   public class LevelLoader
   {
      public static const LEVEL_LOADED:String = "LevelLoaded";
      
      private var level:Level;
      
      private var levelId:String;
      
      public function LevelLoader()
      {
         super();
      }
      
      public function loadLevel(param1:String, param2:String) : void
      {
         LogUtils.log("Loading level: " + param1,this);
         this.levelId = param2;
         if(!DCResourceManager.instance.isLoaded(param1))
         {
            DCResourceManager.instance.addCustomEventListener("complete",this.levelFileLoaded,param1);
            DCResourceManager.instance.load(Config.getDataDir() + param1,param1,"TextFile",true);
         }
         else
         {
            this.parseLevelFile(DCResourceManager.instance.get(param1));
         }
      }
      
      public function dispose() : void
      {
         this.level = null;
      }
      
      public function getLevel() : Level
      {
         return this.level;
      }
      
      public function logicUpdate(param1:int) : void
      {
         if(this.level.isLoaded())
         {
            MessageCenter.sendMessage("LevelLoaded");
            LogicUpdater.unregister(this);
         }
      }
      
      private function levelFileLoaded(param1:DCLoadingEvent) : void
      {
         this.parseLevelFile(DCResourceManager.instance.get(param1.resourceName));
      }
      
      private function parseLevelFile(param1:String) : void
      {
         var levelData:String = param1;
         try
         {
            this.level = new Level(JSON.parse(levelData),this.levelId);
            LogicUpdater.register(this);
         }
         catch(e:Error)
         {
            MessageCenter.sendEvent(new ErrorMessage("Level Loading Error","parseLevelFile",e.message.toString(),null,e));
         }
      }
   }
}

