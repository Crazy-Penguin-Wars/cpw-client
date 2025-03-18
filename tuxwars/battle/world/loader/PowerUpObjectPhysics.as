package tuxwars.battle.world.loader
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.events.TimerEvent;
   import nape.geom.Vec2;
   import tuxwars.battle.data.levelobjects.LevelObjectData;
   import tuxwars.battle.world.DynamicBodyManager;
   import tuxwars.battle.world.DynamicBodyManagerFactory;
   
   public class PowerUpObjectPhysics
   {
      private static const POWER_UP_TABLE_NAME:String = "PowerUp";
      
      private static const FIELD_NAME_PHYSICS:String = "Physics";
      
      private static const FIELD_NAME_GRAPHICS:String = "Graphics";
      
      private static const FIELD_NAME_PARTICLE_EFFECT_SPAWN:String = "ParticleEffectSpawn";
      
      private static const FIELD_NAME_PARTICLE_EFFECT_USE:String = "ParticleEffectUse";
      
      private static const FIELD_NAME_ONLY_IN_THEMES:String = "OnlyInThemes";
      
      private static const FIELD_NAME_RESULT:String = "Result";
      
      private var name:String;
      
      private var row:Row;
      
      private var fixtureName:String;
      
      private var _id:String;
      
      private var levelObjectData:LevelObjectData;
      
      private var bodyManager:DynamicBodyManager;
      
      private var location:Vec2;
      
      protected var _graphics:GraphicsReference;
      
      protected var effectGraphics:GraphicsReference;
      
      private var angle:Number;
      
      public function PowerUpObjectPhysics(data:Object)
      {
         super();
         name = data.export_name;
         fixtureName = data.export_name;
         _id = data.id.toString();
         location = new Vec2(data.x,data.y);
         angle = !!data.angle ? data.angle : 0;
         var _loc4_:String = "PowerUp";
         var _loc2_:ProjectManager = ProjectManager;
         var _loc5_:String = name;
         var _loc3_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc4_);
         if(!_loc3_._cache[_loc5_])
         {
            var _loc6_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc5_);
            if(!_loc6_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc5_] = _loc6_;
         }
         row = _loc3_._cache[_loc5_];
         DynamicBodyManagerFactory.getInstance().createManager(getPhysicsFile(),managerCreated);
      }
      
      public function dispose() : void
      {
         row = null;
         bodyManager = null;
         levelObjectData = null;
         _graphics = null;
         effectGraphics = null;
      }
      
      public function getLocation() : Vec2
      {
         return location;
      }
      
      public function setLocation(x:Number, y:Number) : void
      {
         location = new Vec2(x,y);
      }
      
      public function isLoaded() : Boolean
      {
         return bodyManager != null;
      }
      
      public function getPhysicsFile() : String
      {
         var _loc3_:String = "Physics";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function getOnlyInThemes() : Vector.<String>
      {
         var themes:* = undefined;
         var rowValues:Array = null;
         var _loc13_:String = "OnlyInThemes";
         var _loc4_:Row = row;
         if(!_loc4_._cache[_loc13_])
         {
            _loc4_._cache[_loc13_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc13_);
         }
         if(_loc4_._cache[_loc13_])
         {
            themes = new Vector.<String>();
            var _loc14_:String = "OnlyInThemes";
            var _loc5_:Row = row;
            if(!_loc5_._cache[_loc14_])
            {
               _loc5_._cache[_loc14_] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name",_loc14_);
            }
            var _loc6_:* = _loc5_._cache[_loc14_];
            if((_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) is Array)
            {
               var _loc15_:String = "OnlyInThemes";
               var _loc7_:Row = row;
               if(!_loc7_._cache[_loc15_])
               {
                  _loc7_._cache[_loc15_] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name",_loc15_);
               }
               var _loc8_:* = _loc7_._cache[_loc15_];
               §§push(_loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value);
            }
            else
            {
               var _loc16_:String = "OnlyInThemes";
               var _loc9_:Row = row;
               if(!_loc9_._cache[_loc16_])
               {
                  _loc9_._cache[_loc16_] = com.dchoc.utils.DCUtils.find(_loc9_._fields,"name",_loc16_);
               }
               var _loc10_:* = _loc9_._cache[_loc16_];
               §§push([_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value]);
            }
            rowValues = §§pop();
            for each(var t in rowValues)
            {
               themes.push(t.id);
            }
         }
         return themes;
      }
      
      public function getResultRow() : Row
      {
         var _loc3_:String = "Result";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get graphics() : GraphicsReference
      {
         if(!_graphics)
         {
            var _loc3_:String = "Graphics";
            var _loc1_:Row = row;
            §§push(§§findproperty(GraphicsReference));
            if(!_loc1_._cache[_loc3_])
            {
               _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
            }
            var _loc2_:* = _loc1_._cache[_loc3_];
            _graphics = new §§pop().GraphicsReference(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
         }
         return _graphics;
      }
      
      public function getSpawnEffect() : String
      {
         var _loc4_:String = "ParticleEffectSpawn";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc4_])
         {
            _loc1_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc4_);
         }
         if(_loc1_._cache[_loc4_])
         {
            var _loc5_:String = "ParticleEffectSpawn";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc5_])
            {
               _loc2_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc5_);
            }
            var _loc3_:* = _loc2_._cache[_loc5_];
            return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         }
         return null;
      }
      
      public function getUseEffect() : String
      {
         var _loc4_:String = "ParticleEffectUse";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc4_])
         {
            _loc1_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc4_);
         }
         if(_loc1_._cache[_loc4_])
         {
            var _loc5_:String = "ParticleEffectUse";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc5_])
            {
               _loc2_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc5_);
            }
            var _loc3_:* = _loc2_._cache[_loc5_];
            return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         }
         return null;
      }
      
      public function getBodyManager() : DynamicBodyManager
      {
         return bodyManager;
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
      
      public function getAngle() : Number
      {
         return angle;
      }
      
      private function managerCreated(event:TimerEvent) : void
      {
         bodyManager = DynamicBodyManagerFactory.getInstance().getManager(event.type);
      }
   }
}

