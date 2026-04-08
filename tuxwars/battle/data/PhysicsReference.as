package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import nape.phys.*;
   import nape.shape.*;
   import tuxwars.battle.world.*;
   
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
      
      public function PhysicsReference(param1:Row)
      {
         super();
         this.row = param1;
         if(this.shape == "Polygon" && this.physicsXLM != null)
         {
            this._bodyManager = DynamicBodyManagerPreLoader.getBodyManager(this.physicsXLM);
         }
         this.createShapes();
         this.createBodyDef();
         this.loaded = true;
      }
      
      public function isLoaded() : Boolean
      {
         return this.loaded;
      }
      
      public function get shapes() : Array
      {
         return this._shapes;
      }
      
      public function get bodyDef() : BodyDef
      {
         return this._bodyDef;
      }
      
      private function createBodyDef() : void
      {
         this._bodyDef.allowSleep = this.allowSleep;
         this._bodyDef.bullet = this.isBullet();
         this._bodyDef.fixedRotation = this.fixedRotation;
         this._bodyDef.gravityScale = this.gravityScale;
         this._bodyDef.type = this.bodyType;
      }
      
      private function get allowSleep() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("AllowSleep");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : true;
      }
      
      private function get fixedRotation() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("FixedRotation");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : true;
      }
      
      private function getField(param1:String) : Field
      {
         var _loc2_:Row = null;
         if(!this._field_cache.hasOwnProperty(param1))
         {
            _loc2_ = this.row;
            if(!_loc2_.getCache[param1])
            {
               _loc2_.getCache[param1] = DCUtils.find(_loc2_.getFields(),"name",param1);
            }
            this._field_cache[param1] = _loc2_.getCache[param1];
         }
         return this._field_cache[param1];
      }
      
      public function get fixtureName() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("FixtureName");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      private function get physicsXLM() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("PhysicsXML");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      private function isBullet() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Bullet");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : false;
      }
      
      private function get gravityScale() : Number
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("GravityScale");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Number(_loc2_.overrideValue) : Number(_loc2_._value)) : 1;
      }
      
      private function isSensor() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("IsSensor");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : false;
      }
      
      public function get radius() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Radius");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 5;
      }
      
      private function get bodyType() : BodyType
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("BodyType");
         var _loc3_:String = _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "dynamic";
         switch(_loc3_)
         {
            case "dynamic":
               return BodyType.DYNAMIC;
            case "static":
               return BodyType.STATIC;
            default:
               LogUtils.log("Unknown body type: " + _loc3_,this,3,"All",true,true,true);
               return BodyType.STATIC;
         }
      }
      
      public function get bodyManager() : DynamicBodyManager
      {
         return this._bodyManager;
      }
      
      private function get density() : Number
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Density");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Number(_loc2_.overrideValue) : Number(_loc2_._value)) : 75;
      }
      
      private function get friction() : Number
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Friction");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Number(_loc2_.overrideValue) : Number(_loc2_._value)) : 0.3;
      }
      
      private function get restitution() : Number
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Restitution");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Number(_loc2_.overrideValue) : Number(_loc2_._value)) : 0;
      }
      
      private function createShapes() : void
      {
         var _loc1_:Circle = null;
         var _loc2_:Material = null;
         switch(this.shape)
         {
            case "Circle":
               _loc1_ = new Circle(this.radius);
               _loc2_ = new Material();
               _loc2_.density = this.density;
               _loc2_.dynamicFriction = this.friction;
               _loc2_.elasticity = this.restitution;
               _loc1_.sensorEnabled = this.isSensor();
               _loc1_.material = _loc2_;
               this._shapes.push(_loc1_);
               break;
            case "Polygon":
               break;
            default:
               throw new Error("Shape not supported: " + this.shape);
         }
      }
      
      private function get shape() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Shape");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "Circle";
      }
   }
}

