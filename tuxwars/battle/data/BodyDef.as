package tuxwars.battle.data
{
   import nape.geom.Vec2;
   import nape.phys.BodyType;
   
   public class BodyDef
   {
      private var _allowSleep:Boolean;
      
      private var _fixedRotation:Boolean;
      
      private var _bullet:Boolean;
      
      private var _gravityScale:Number;
      
      private var _type:BodyType;
      
      private var _position:Vec2;
      
      private var _angle:Number;
      
      private var _awake:Boolean;
      
      private var _linearVelocity:Vec2;
      
      private var _userData:*;
      
      public function BodyDef(param1:BodyType = null, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false, param5:Number = 1)
      {
         super();
         this._allowSleep = param2;
         this._fixedRotation = param4;
         this._bullet = param3;
         this._gravityScale = param5;
         this._type = param1;
      }
      
      public function get userData() : *
      {
         return this._userData;
      }
      
      public function set userData(param1:*) : void
      {
         this._userData = param1;
      }
      
      public function get linearVelocity() : Vec2
      {
         return this._linearVelocity;
      }
      
      public function set linearVelocity(param1:Vec2) : void
      {
         this._linearVelocity = param1;
      }
      
      public function get awake() : Boolean
      {
         return this._awake;
      }
      
      public function set awake(param1:Boolean) : void
      {
         this._awake = param1;
      }
      
      public function get angle() : Number
      {
         return this._angle;
      }
      
      public function set angle(param1:Number) : void
      {
         this._angle = param1;
      }
      
      public function get position() : Vec2
      {
         return this._position;
      }
      
      public function set position(param1:Vec2) : void
      {
         this._position = param1;
      }
      
      public function get type() : BodyType
      {
         return this._type;
      }
      
      public function set type(param1:BodyType) : void
      {
         this._type = param1;
      }
      
      public function get gravityScale() : Number
      {
         return this._gravityScale;
      }
      
      public function set gravityScale(param1:Number) : void
      {
         this._gravityScale = param1;
      }
      
      public function get bullet() : Boolean
      {
         return this._bullet;
      }
      
      public function set bullet(param1:Boolean) : void
      {
         this._bullet = param1;
      }
      
      public function get fixedRotation() : Boolean
      {
         return this._fixedRotation;
      }
      
      public function set fixedRotation(param1:Boolean) : void
      {
         this._fixedRotation = param1;
      }
      
      public function get allowSleep() : Boolean
      {
         return this._allowSleep;
      }
      
      public function set allowSleep(param1:Boolean) : void
      {
         this._allowSleep = param1;
      }
   }
}

