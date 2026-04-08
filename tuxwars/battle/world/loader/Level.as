package tuxwars.battle.world.loader
{
   import flash.geom.*;
   import nape.geom.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.data.parallaxes.*;
   
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
      
      public function Level(param1:Object, param2:String)
      {
         super();
         this.parseData(param1);
         this._id = param2;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         this._theme.dispose();
         this._theme = null;
         this.disposeParallaxLayers();
         for each(_loc1_ in this._powerUps)
         {
            _loc1_.dispose();
         }
         this._powerUps.splice(0,this._powerUps.length);
         for each(_loc2_ in this._elements)
         {
            _loc2_.dispose();
         }
         this._elements.splice(0,this._elements.length);
         for each(_loc3_ in this._joints)
         {
            _loc3_.dispose();
         }
         this._joints.splice(0,this._joints.length);
         this._spawnPoints.splice(0,this._spawnPoints.length);
         this._parallaxData = null;
      }
      
      public function disposeParallaxLayers() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._parallaxLayers)
         {
            _loc1_.dispose();
         }
         this._parallaxLayers.splice(0,this._parallaxLayers.length);
      }
      
      public function get spawnPoints() : Vector.<Vec2>
      {
         return this._spawnPoints;
      }
      
      public function get elements() : Vector.<Element>
      {
         return this._elements;
      }
      
      public function getElement(param1:String) : Element
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._elements)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get joints() : Vector.<Joint>
      {
         return this._joints;
      }
      
      public function get powerUps() : Vector.<LevelPowerUp>
      {
         return this._powerUps;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get theme() : LevelTheme
      {
         return this._theme;
      }
      
      public function get powerUpPercentage() : int
      {
         return this._levelPowerUpPercentage;
      }
      
      public function get zoomSide() : String
      {
         return this._zoomSide;
      }
      
      public function get waterLine() : int
      {
         return this._levelWaterLine;
      }
      
      public function get waterDensity() : Number
      {
         return this._levelWaterDensity;
      }
      
      public function get waterLinearDrag() : Number
      {
         return this._levelWaterLinearDrag;
      }
      
      public function get wateAngularDrag() : Number
      {
         return this._levelWaterAngularDrag;
      }
      
      public function get waterVelocity() : Point
      {
         return this._levelWaterVelocity;
      }
      
      public function get parallaxLayers() : Vector.<ParallaxLayer>
      {
         return this._parallaxLayers;
      }
      
      public function get parallaxData() : Object
      {
         return this._parallaxData;
      }
      
      public function isLoaded() : Boolean
      {
         return Boolean(this._theme.isLoaded()) && Boolean(this.elementsAreLoaded());
      }
      
      private function elementsAreLoaded() : Boolean
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         for each(_loc1_ in this._elements)
         {
            if(!_loc1_.isLoaded())
            {
               return false;
            }
         }
         for each(_loc2_ in this._powerUps)
         {
            if(!_loc2_.isLoaded())
            {
               return false;
            }
         }
         return true;
      }
      
      private function parseData(param1:Object) : void
      {
         this.parseSpawnPoints(param1.spawn_points);
         this._width = param1.width;
         this._height = param1.height;
         this._name = param1.level_name;
         this._zoomSide = param1.zoom_side != null ? param1.zoom_side : "width";
         this._theme = LevelThemes.findTheme(param1.theme);
         this.parseElements(param1.elements);
         this.parsePowerUps(param1.power_ups);
         this._levelPowerUpPercentage = param1.power_up_percentage != null ? int(param1.power_up_percentage) : 0;
         this._levelWaterLine = param1.water_line != null ? int(param1.water_line) : int(this._height * 0.75);
         this._levelWaterDensity = param1.water_density != null ? Number(param1.water_density) : 100;
         this._levelWaterLinearDrag = param1.water_lineardrag != null ? Number(param1.water_lineardrag) : 2;
         this._levelWaterAngularDrag = param1.water_angulardrag != null ? int(param1.water_angulardrag) : 1;
         this._levelWaterVelocity = param1.water_velocity_x != null ? new Point(param1.water_velocity_x,param1.water_velocity_y) : new Point(0,0);
         this._parallaxData = param1.parallax_layers;
         this.parseParallaxes();
         this.parseJoints(param1.joints);
      }
      
      private function parseSpawnPoints(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = param1 is Array ? param1 as Array : [param1];
         for each(_loc3_ in _loc2_)
         {
            this._spawnPoints.push(new Vec2(_loc3_.x,_loc3_.y));
         }
      }
      
      private function parseElements(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = param1 is Array ? param1 as Array : [param1];
         for each(_loc3_ in _loc2_)
         {
            this._elements.push(new Element(_loc3_));
         }
      }
      
      private function parseJoints(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = null;
         if(param1)
         {
            _loc2_ = param1 is Array ? param1 as Array : [param1];
            for each(_loc3_ in _loc2_)
            {
               this._joints.push(new Joint(_loc3_,this));
            }
         }
      }
      
      private function parsePowerUps(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = null;
         if(param1)
         {
            _loc2_ = param1 is Array ? param1 as Array : [param1];
            for each(_loc3_ in _loc2_)
            {
               this._powerUps.push(new LevelPowerUp(_loc3_));
            }
         }
      }
      
      public function parseParallaxes() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = null;
         if(this._parallaxData)
         {
            this._parallaxLayers = new Vector.<ParallaxLayer>();
            _loc1_ = this._parallaxData is Array ? this._parallaxData as Array : [this._parallaxData];
            for each(_loc2_ in _loc1_)
            {
               this._parallaxLayers.push(new ParallaxLayer(_loc2_,this));
            }
         }
      }
   }
}

