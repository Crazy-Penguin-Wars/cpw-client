package tuxwars.battle.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import nape.phys.BodyType;
   import nape.phys.Material;
   import nape.shape.Circle;
   import tuxwars.battle.world.DynamicBodyManager;
   import tuxwars.battle.world.DynamicBodyManagerPreLoader;
   
   public class PhysicsReference
   {
      
      private static const SHAPE_CIRCLE:String = "Circle";
      
      private static const SHAPE_POLYGON:String = "Polygon";
      
      private static const DYNAMIC_BODY:String = "dynamic";
      
      private static const STATIC_BODY:String = "static";
      
      private static const DENSITY:String = "Density";
      
      private static const FRICTION:String = "Friction";
      
      private static const RESTITUTION:String = "Restitution";
      
      private static const ALLOW_SLEEP:String = "AllowSleep";
      
      private static const FIXED_ROTATION:String = "FixedRotation";
      
      private static const BODY_TYPE:String = "BodyType";
      
      private static const SHAPE:String = "Shape";
      
      private static const RADIUS:String = "Radius";
      
      private static const BULLET:String = "Bullet";
      
      private static const IS_SENSOR:String = "IsSensor";
      
      private static const PHYSICS_XML:String = "PhysicsXML";
      
      private static const FIXTURE_NAME:String = "FixtureName";
      
      private static const GRAVITY_SCALE:String = "GravityScale";
       
      
      private const _bodyDef:BodyDef = new BodyDef();
      
      private const _field_cache:Object = {};
      
      private const _shapes:Array = [];
      
      private var _bodyManager:DynamicBodyManager;
      
      private var loaded:Boolean;
      
      private var row:Row;
      
      public function PhysicsReference(row:Row)
      {
         super();
         this.row = row;
         if(shape == "Polygon" && physicsXLM != null)
         {
            _bodyManager = DynamicBodyManagerPreLoader.getBodyManager(physicsXLM);
         }
         createShapes();
         createBodyDef();
         loaded = true;
      }
      
      public function isLoaded() : Boolean
      {
         return loaded;
      }
      
      public function get shapes() : Array
      {
         return _shapes;
      }
      
      public function get bodyDef() : BodyDef
      {
         return _bodyDef;
      }
      
      private function createBodyDef() : void
      {
         _bodyDef.allowSleep = allowSleep;
         _bodyDef.bullet = isBullet();
         _bodyDef.fixedRotation = fixedRotation;
         _bodyDef.gravityScale = gravityScale;
         _bodyDef.type = bodyType;
      }
      
      private function get allowSleep() : Boolean
      {
         var _loc1_:Field = getField("AllowSleep");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : true;
      }
      
      private function get fixedRotation() : Boolean
      {
         var _loc1_:Field = getField("FixedRotation");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : true;
      }
      
      private function getField(name:String) : Field
      {
         if(!_field_cache.hasOwnProperty(name))
         {
            var _loc3_:* = name;
            var _loc2_:Row = row;
            §§push(_field_cache);
            §§push(name);
            if(!_loc2_._cache[_loc3_])
            {
               _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
            }
            §§pop()[§§pop()] = _loc2_._cache[_loc3_];
         }
         return _field_cache[name];
      }
      
      public function get fixtureName() : String
      {
         var _loc1_:Field = getField("FixtureName");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      private function get physicsXLM() : String
      {
         var _loc1_:Field = getField("PhysicsXML");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      private function isBullet() : Boolean
      {
         var _loc1_:Field = getField("Bullet");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : false;
      }
      
      private function get gravityScale() : Number
      {
         var _loc1_:Field = getField("GravityScale");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 1;
      }
      
      private function isSensor() : Boolean
      {
         var _loc1_:Field = getField("IsSensor");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : false;
      }
      
      public function get radius() : int
      {
         var _loc1_:Field = getField("Radius");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 5;
      }
      
      private function get bodyType() : BodyType
      {
         var _loc2_:Field = getField("BodyType");
         var _loc3_:*;
         var _loc1_:String = _loc2_ != null ? (_loc3_ = _loc2_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : "dynamic";
         switch(_loc1_)
         {
            case "dynamic":
               return BodyType.DYNAMIC;
            case "static":
               return BodyType.STATIC;
            default:
               LogUtils.log("Unknown body type: " + _loc1_,this,3,"All",true,true,true);
               return BodyType.STATIC;
         }
      }
      
      public function get bodyManager() : DynamicBodyManager
      {
         return _bodyManager;
      }
      
      private function get density() : Number
      {
         var _loc1_:Field = getField("Density");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 75;
      }
      
      private function get friction() : Number
      {
         var _loc1_:Field = getField("Friction");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0.3;
      }
      
      private function get restitution() : Number
      {
         var _loc1_:Field = getField("Restitution");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      private function createShapes() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         switch(shape)
         {
            case "Circle":
               _loc1_ = new Circle(radius);
               _loc2_ = new Material();
               _loc2_.density = density;
               _loc2_.dynamicFriction = friction;
               _loc2_.elasticity = restitution;
               _loc1_.sensorEnabled = isSensor();
               _loc1_.material = _loc2_;
               _shapes.push(_loc1_);
               break;
            case "Polygon":
               break;
            default:
               throw new Error("Shape not supported: " + shape);
         }
      }
      
      private function get shape() : String
      {
         var _loc1_:Field = getField("Shape");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "Circle";
      }
   }
}
