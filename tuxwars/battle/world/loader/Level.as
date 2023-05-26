package tuxwars.battle.world.loader
{
   import flash.geom.Point;
   import nape.geom.Vec2;
   import tuxwars.battle.data.LevelTheme;
   import tuxwars.battle.data.LevelThemes;
   import tuxwars.battle.data.parallaxes.ParallaxLayer;
   
   public class Level
   {
      
      public static const ZOOM_SIDE_WIDTH:String = "width";
      
      public static const ZOOM_SIDE_HEIGHT:String = "height";
       
      
      private const _spawnPoints:Vector.<Vec2> = new Vector.<Vec2>();
      
      private const _elements:Vector.<Element> = new Vector.<Element>();
      
      private const _joints:Vector.<Joint> = new Vector.<Joint>();
      
      private const _powerUps:Vector.<LevelPowerUp> = new Vector.<LevelPowerUp>();
      
      private var _width:int;
      
      private var _height:int;
      
      private var _name:String;
      
      private var _theme:LevelTheme;
      
      private var _zoomSide:String;
      
      private var _levelPowerUpPercentage:int;
      
      private var _levelWaterLine:int;
      
      private var _levelWaterDensity:Number;
      
      private var _levelWaterLinearDrag:Number;
      
      private var _levelWaterAngularDrag:int;
      
      private var _levelWaterVelocity:Point;
      
      private var _parallaxLayers:Vector.<ParallaxLayer>;
      
      private var _parallaxData:Object;
      
      private var _id:String;
      
      public function Level(levelData:Object, levelId:String)
      {
         super();
         parseData(levelData);
         _id = levelId;
      }
      
      public function dispose() : void
      {
         _theme.dispose();
         _theme = null;
         disposeParallaxLayers();
         for each(var powerUp in _powerUps)
         {
            powerUp.dispose();
         }
         _powerUps.splice(0,_powerUps.length);
         for each(var element in _elements)
         {
            element.dispose();
         }
         _elements.splice(0,_elements.length);
         for each(var j in _joints)
         {
            j.dispose();
         }
         _joints.splice(0,_joints.length);
         _spawnPoints.splice(0,_spawnPoints.length);
         _parallaxData = null;
      }
      
      public function disposeParallaxLayers() : void
      {
         for each(var layer in _parallaxLayers)
         {
            layer.dispose();
         }
         _parallaxLayers.splice(0,_parallaxLayers.length);
      }
      
      public function get spawnPoints() : Vector.<Vec2>
      {
         return _spawnPoints;
      }
      
      public function get elements() : Vector.<Element>
      {
         return _elements;
      }
      
      public function getElement(id:String) : Element
      {
         for each(var element in _elements)
         {
            if(element.id == id)
            {
               return element;
            }
         }
         return null;
      }
      
      public function get joints() : Vector.<Joint>
      {
         return _joints;
      }
      
      public function get powerUps() : Vector.<LevelPowerUp>
      {
         return _powerUps;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get theme() : LevelTheme
      {
         return _theme;
      }
      
      public function get powerUpPercentage() : int
      {
         return _levelPowerUpPercentage;
      }
      
      public function get zoomSide() : String
      {
         return _zoomSide;
      }
      
      public function get waterLine() : int
      {
         return _levelWaterLine;
      }
      
      public function get waterDensity() : Number
      {
         return _levelWaterDensity;
      }
      
      public function get waterLinearDrag() : Number
      {
         return _levelWaterLinearDrag;
      }
      
      public function get wateAngularDrag() : Number
      {
         return _levelWaterAngularDrag;
      }
      
      public function get waterVelocity() : Point
      {
         return _levelWaterVelocity;
      }
      
      public function get parallaxLayers() : Vector.<ParallaxLayer>
      {
         return _parallaxLayers;
      }
      
      public function get parallaxData() : Object
      {
         return _parallaxData;
      }
      
      public function isLoaded() : Boolean
      {
         return _theme.isLoaded() && elementsAreLoaded();
      }
      
      private function elementsAreLoaded() : Boolean
      {
         for each(var element in _elements)
         {
            if(!element.isLoaded())
            {
               return false;
            }
         }
         for each(var powerup in _powerUps)
         {
            if(!powerup.isLoaded())
            {
               return false;
            }
         }
         return true;
      }
      
      private function parseData(levelData:Object) : void
      {
         parseSpawnPoints(levelData.spawn_points);
         _width = levelData.width;
         _height = levelData.height;
         _name = levelData.level_name;
         _zoomSide = levelData.zoom_side != null ? levelData.zoom_side : "width";
         _theme = LevelThemes.findTheme(levelData.theme);
         parseElements(levelData.elements);
         parsePowerUps(levelData.power_ups);
         _levelPowerUpPercentage = levelData.power_up_percentage != null ? levelData.power_up_percentage : 0;
         _levelWaterLine = levelData.water_line != null ? levelData.water_line : _height * 0.75;
         _levelWaterDensity = levelData.water_density != null ? levelData.water_density : 100;
         _levelWaterLinearDrag = levelData.water_lineardrag != null ? levelData.water_lineardrag : 2;
         _levelWaterAngularDrag = levelData.water_angulardrag != null ? levelData.water_angulardrag : 1;
         _levelWaterVelocity = levelData.water_velocity_x != null ? new Point(levelData.water_velocity_x,levelData.water_velocity_y) : new Point(0,0);
         _parallaxData = levelData.parallax_layers;
         parseParallaxes();
         parseJoints(levelData.joints);
      }
      
      private function parseSpawnPoints(points:Object) : void
      {
         var _loc2_:Array = points is Array ? points as Array : [points];
         for each(var obj in _loc2_)
         {
            _spawnPoints.push(new Vec2(obj.x,obj.y));
         }
      }
      
      private function parseElements(elementsData:Object) : void
      {
         var _loc3_:Array = elementsData is Array ? elementsData as Array : [elementsData];
         for each(var elem in _loc3_)
         {
            _elements.push(new Element(elem));
         }
      }
      
      private function parseJoints(jointData:Object) : void
      {
         var _loc2_:* = null;
         if(jointData)
         {
            _loc2_ = jointData is Array ? jointData as Array : [jointData];
            for each(var j in _loc2_)
            {
               _joints.push(new Joint(j,this));
            }
         }
      }
      
      private function parsePowerUps(powerUpData:Object) : void
      {
         var _loc2_:* = null;
         if(powerUpData)
         {
            _loc2_ = powerUpData is Array ? powerUpData as Array : [powerUpData];
            for each(var pu in _loc2_)
            {
               _powerUps.push(new LevelPowerUp(pu));
            }
         }
      }
      
      public function parseParallaxes() : void
      {
         var _loc2_:* = null;
         if(_parallaxData)
         {
            _parallaxLayers = new Vector.<ParallaxLayer>();
            _loc2_ = _parallaxData is Array ? _parallaxData as Array : [_parallaxData];
            for each(var paral in _loc2_)
            {
               _parallaxLayers.push(new ParallaxLayer(paral,this));
            }
         }
      }
   }
}
