package tuxwars.battle.world.loader
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import org.as3commons.lang.*;
   import tuxwars.battle.gameobjects.*;
   
   public class LevelPowerUp
   {
      private static const POWER_UPtable_NAME:String = "PowerUp";
      
      private static const powerUpNames:Vector.<String> = new Vector.<String>();
      
      private var _id:String;
      
      private var _appearPercentage:int;
      
      private var type:String;
      
      private var powerUpPhysics:PowerUpObjectPhysics;
      
      private var baseLocation:Vec2;
      
      private var levelPowerUpResult:LevelPowerUpResult;
      
      public function LevelPowerUp(param1:Object)
      {
         super();
         this._id = param1.export_name;
         this._appearPercentage = param1.appear_percentage;
         this.powerUpPhysics = new PowerUpObjectPhysics(param1);
         this.baseLocation = this.powerUpPhysics.getLocation();
         this.levelPowerUpResult = new LevelPowerUpResult(this.powerUpPhysics.getResultRow());
      }
      
      public static function getAllPowerUpNames() : Vector.<String>
      {
         var tbl:Table = null;
         var rowsArray:Array = null;
         var row:Row = null;
         var idField:Field = null;
         var idVal:* = undefined;
         if(powerUpNames.length == 0)
         {
            tbl = ProjectManager.findTable("PowerUp");
            rowsArray = tbl._rows;
            for each(row in rowsArray)
            {
               if(!row.getCache["ID"])
               {
                  row.getCache["ID"] = DCUtils.find(row.getFields(),"name","ID");
               }
               idField = row.getCache["ID"];
               idVal = !!idField ? (idField.overrideValue != null ? idField.overrideValue : idField._value) : row.id;
               LogUtils.log("Adding powerup id: " + idVal,LevelPowerUp,4);
               powerUpNames.push(idVal);
            }
            powerUpNames.sort(function(param1:String, param2:String):int
            {
               return StringUtils.compareTo(param1,param2);
            });
         }
         return powerUpNames;
      }
      
      public function dispose() : void
      {
         if(this.powerUpPhysics)
         {
            this.powerUpPhysics.dispose();
            this.powerUpPhysics = null;
         }
         if(this.levelPowerUpResult)
         {
            this.levelPowerUpResult = null;
         }
      }
      
      public function get appearPercentage() : int
      {
         return this._appearPercentage;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function getName() : String
      {
         return this.id;
      }
      
      public function getPowerUpObjectPhysics() : PowerUpObjectPhysics
      {
         return this.powerUpPhysics;
      }
      
      public function isLoaded() : Boolean
      {
         return Boolean(this.powerUpPhysics) && Boolean(this.powerUpPhysics.isLoaded());
      }
      
      public function getGameObjectDefClass() : Class
      {
         return PowerUpGameObjectDef;
      }
      
      public function getLocation() : Vec2
      {
         return this.powerUpPhysics.getLocation();
      }
      
      public function setLocation(param1:Vec2) : void
      {
         return this.powerUpPhysics.setLocation(param1.x,param1.y);
      }
      
      public function setDropLocation() : void
      {
         this.powerUpPhysics.setLocation(this.baseLocation.x,0);
      }
      
      public function getResult() : LevelPowerUpResult
      {
         return this.levelPowerUpResult;
      }
   }
}

