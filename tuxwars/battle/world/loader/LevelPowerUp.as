package tuxwars.battle.world.loader
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import org.as3commons.lang.StringUtils;
   import tuxwars.battle.gameobjects.PowerUpGameObjectDef;
   
   public class LevelPowerUp
   {
      private static const POWER_UP_TABLE_NAME:String = "PowerUp";
      
      private static const powerUpNames:Vector.<String> = new Vector.<String>();
      
      private var _id:String;
      
      private var _appearPercentage:int;
      
      private var type:String;
      
      private var powerUpPhysics:PowerUpObjectPhysics;
      
      private var baseLocation:Vec2;
      
      private var levelPowerUpResult:LevelPowerUpResult;
      
      public function LevelPowerUp(data:Object)
      {
         super();
         _id = data.export_name;
         _appearPercentage = data.appear_percentage;
         powerUpPhysics = new PowerUpObjectPhysics(data);
         baseLocation = powerUpPhysics.getLocation();
         levelPowerUpResult = new LevelPowerUpResult(powerUpPhysics.getResultRow());
      }
      
      public static function getAllPowerUpNames() : Vector.<String>
      {
         var rowsArray:Array;
         var row:Row;
         if(powerUpNames.length == 0)
         {
            var _loc10_:String = "PowerUp";
            var _loc1_:ProjectManager = ProjectManager;
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc10_);
            rowsArray = _loc2_._rows;
            for each(row in rowsArray)
            {
               var _loc11_:String = "ID";
               var _loc4_:Row = row;
               §§push(LogUtils);
               §§push("Adding powerup id: ");
               if(!_loc4_._cache[_loc11_])
               {
                  _loc4_._cache[_loc11_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc11_);
               }
               var _loc5_:* = _loc4_._cache[_loc11_];
               §§pop().log(§§pop() + (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value));
               var _loc12_:String = "ID";
               var _loc6_:Row = row;
               §§push(powerUpNames);
               if(!_loc6_._cache[_loc12_])
               {
                  _loc6_._cache[_loc12_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc12_);
               }
               var _loc7_:* = _loc6_._cache[_loc12_];
               §§pop().push(_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value);
            }
            powerUpNames.sort(function(str1:String, str2:String):int
            {
               return StringUtils.compareTo(str1,str2);
            });
         }
         return powerUpNames;
      }
      
      public function dispose() : void
      {
         if(powerUpPhysics)
         {
            powerUpPhysics.dispose();
            powerUpPhysics = null;
         }
         if(levelPowerUpResult)
         {
            levelPowerUpResult = null;
         }
      }
      
      public function get appearPercentage() : int
      {
         return _appearPercentage;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function getName() : String
      {
         return id;
      }
      
      public function getPowerUpObjectPhysics() : PowerUpObjectPhysics
      {
         return powerUpPhysics;
      }
      
      public function isLoaded() : Boolean
      {
         return powerUpPhysics && powerUpPhysics.isLoaded();
      }
      
      public function getGameObjectDefClass() : Class
      {
         return PowerUpGameObjectDef;
      }
      
      public function getLocation() : Vec2
      {
         return powerUpPhysics.getLocation();
      }
      
      public function setLocation(loc:Vec2) : void
      {
         return powerUpPhysics.setLocation(loc.x,loc.y);
      }
      
      public function setDropLocation() : void
      {
         powerUpPhysics.setLocation(baseLocation.x,0);
      }
      
      public function getResult() : LevelPowerUpResult
      {
         return levelPowerUpResult;
      }
   }
}

