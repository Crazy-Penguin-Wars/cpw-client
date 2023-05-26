package tuxwars.battle.world.loader
{
   import flash.events.TimerEvent;
   import nape.geom.Vec2;
   import tuxwars.battle.data.MaterialTheme;
   import tuxwars.battle.data.MaterialThemes;
   import tuxwars.battle.data.levelobjects.LevelObjectData;
   import tuxwars.battle.data.levelobjects.LevelObjects;
   import tuxwars.battle.world.DynamicBodyManager;
   import tuxwars.battle.world.DynamicBodyManagerFactory;
   
   public class DynamicElementPhysics
   {
       
      
      private var angle:Number;
      
      private var theme:MaterialTheme;
      
      private var name:String;
      
      private var fixtureName:String;
      
      private var _id:String;
      
      private var levelObjectData:LevelObjectData;
      
      private var bodyManager:DynamicBodyManager;
      
      private var location:Vec2;
      
      public function DynamicElementPhysics(data:Object, element:Element)
      {
         super();
         angle = !!data.angle ? data.angle : 0;
         name = data.name;
         fixtureName = data.fixture;
         _id = data.id.toString();
         theme = MaterialThemes.findTheme(data.theme);
         location = new Vec2(data.x,data.y);
         if(theme.isCustomTheme())
         {
            levelObjectData = LevelObjects.findLevelObjectData(name);
         }
         else
         {
            levelObjectData = LevelObjects.findLevelObjectData(name + theme.getName());
         }
         DynamicBodyManagerFactory.getInstance().createManager(levelObjectData.getPhysicsFile(),managerCreated);
      }
      
      public function dispose() : void
      {
         theme.dispose();
         theme = null;
         levelObjectData = null;
         bodyManager = null;
      }
      
      public function getLocation() : Vec2
      {
         return location;
      }
      
      public function isLoaded() : Boolean
      {
         return bodyManager != null;
      }
      
      public function getBodyManager() : DynamicBodyManager
      {
         return bodyManager;
      }
      
      public function getLevelObjectData() : LevelObjectData
      {
         return levelObjectData;
      }
      
      public function getAngle() : Number
      {
         return angle;
      }
      
      public function getTheme() : MaterialTheme
      {
         return theme;
      }
      
      public function getName() : String
      {
         return name;
      }
      
      public function getFixtureName() : String
      {
         return fixtureName;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      private function managerCreated(event:TimerEvent) : void
      {
         bodyManager = DynamicBodyManagerFactory.getInstance().getManager(event.type);
      }
   }
}
