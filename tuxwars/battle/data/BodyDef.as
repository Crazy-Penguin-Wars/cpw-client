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
      
      private var _userData;
      
      public function BodyDef(type:BodyType = null, allowSleep:Boolean = true, bullet:Boolean = false, fixedRotation:Boolean = false, gravityScale:Number = 1)
      {
         super();
         _allowSleep = allowSleep;
         _fixedRotation = fixedRotation;
         _bullet = bullet;
         _gravityScale = gravityScale;
         _type = type;
      }
      
      public function get userData() : *
      {
         return _userData;
      }
      
      public function set userData(value:*) : void
      {
         _userData = value;
      }
      
      public function get linearVelocity() : Vec2
      {
         return _linearVelocity;
      }
      
      public function set linearVelocity(value:Vec2) : void
      {
         _linearVelocity = value;
      }
      
      public function get awake() : Boolean
      {
         return _awake;
      }
      
      public function set awake(value:Boolean) : void
      {
         _awake = value;
      }
      
      public function get angle() : Number
      {
         return _angle;
      }
      
      public function set angle(value:Number) : void
      {
         _angle = value;
      }
      
      public function get position() : Vec2
      {
         return _position;
      }
      
      public function set position(value:Vec2) : void
      {
         _position = value;
      }
      
      public function get type() : BodyType
      {
         return _type;
      }
      
      public function set type(value:BodyType) : void
      {
         _type = value;
      }
      
      public function get gravityScale() : Number
      {
         return _gravityScale;
      }
      
      public function set gravityScale(value:Number) : void
      {
         _gravityScale = value;
      }
      
      public function get bullet() : Boolean
      {
         return _bullet;
      }
      
      public function set bullet(value:Boolean) : void
      {
         _bullet = value;
      }
      
      public function get fixedRotation() : Boolean
      {
         return _fixedRotation;
      }
      
      public function set fixedRotation(value:Boolean) : void
      {
         _fixedRotation = value;
      }
      
      public function get allowSleep() : Boolean
      {
         return _allowSleep;
      }
      
      public function set allowSleep(value:Boolean) : void
      {
         _allowSleep = value;
      }
   }
}
