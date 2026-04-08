package tuxwars.battle.world.loader
{
   import flash.events.TimerEvent;
   import nape.geom.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.data.levelobjects.*;
   import tuxwars.battle.world.*;
   
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
      
      public function DynamicElementPhysics(param1:Object, param2:Element)
      {
         super();
         this.angle = !!param1.angle ? Number(param1.angle) : 0;
         this.name = param1.name;
         this.fixtureName = param1.fixture;
         this._id = param1.id.toString();
         this.theme = MaterialThemes.findTheme(param1.theme);
         this.location = new Vec2(param1.x,param1.y);
         if(this.theme.isCustomTheme())
         {
            this.levelObjectData = LevelObjects.findLevelObjectData(this.name);
         }
         else
         {
            this.levelObjectData = LevelObjects.findLevelObjectData(this.name + this.theme.getName());
         }
         DynamicBodyManagerFactory.getInstance().createManager(this.levelObjectData.getPhysicsFile(),this.managerCreated);
      }
      
      public function dispose() : void
      {
         this.theme.dispose();
         this.theme = null;
         this.levelObjectData = null;
         this.bodyManager = null;
      }
      
      public function getLocation() : Vec2
      {
         return this.location;
      }
      
      public function isLoaded() : Boolean
      {
         return this.bodyManager != null;
      }
      
      public function getBodyManager() : DynamicBodyManager
      {
         return this.bodyManager;
      }
      
      public function getLevelObjectData() : LevelObjectData
      {
         return this.levelObjectData;
      }
      
      public function getAngle() : Number
      {
         return this.angle;
      }
      
      public function getTheme() : MaterialTheme
      {
         return this.theme;
      }
      
      public function getName() : String
      {
         return this.name;
      }
      
      public function getFixtureName() : String
      {
         return this.fixtureName;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      private function managerCreated(param1:TimerEvent) : void
      {
         this.bodyManager = DynamicBodyManagerFactory.getInstance().getManager(param1.type);
      }
   }
}

