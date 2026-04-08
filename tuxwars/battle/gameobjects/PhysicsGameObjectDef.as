package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GameData;
   import nape.geom.*;
   import nape.space.Space;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.world.DynamicBodyManager;
   
   public class PhysicsGameObjectDef extends TuxGameObjectDef
   {
      private const _shapes:Array = [];
      
      private const _bodyDef:BodyDef = new BodyDef();
      
      private var _space:Space;
      
      private var _fixtureName:String;
      
      private var _bodyManager:DynamicBodyManager;
      
      public function PhysicsGameObjectDef(param1:Space)
      {
         super();
         this._space = param1;
         this._bodyDef.position = Vec2.get();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._space = null;
      }
      
      public function get shapes() : Array
      {
         return this._shapes;
      }
      
      public function get bodyDef() : BodyDef
      {
         return this._bodyDef;
      }
      
      public function get space() : Space
      {
         return this._space;
      }
      
      public function get bodyManager() : DynamicBodyManager
      {
         return this._bodyManager;
      }
      
      public function get fixtureName() : String
      {
         return this._fixtureName;
      }
      
      public function get position() : Vec2
      {
         return this._bodyDef.position;
      }
      
      public function set position(param1:Vec2) : void
      {
         this._bodyDef.position = param1;
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not a TuxGameObjectData.",true,param1 is TuxGameObjectData);
         var _loc2_:TuxGameObjectData = param1 as TuxGameObjectData;
         var _loc3_:PhysicsReference = _loc2_.getPhysics();
         if(_loc3_)
         {
            this.loadPhysicsReference(_loc3_);
            this._bodyManager = _loc2_.getPhysics().bodyManager;
            this._fixtureName = _loc2_.getPhysics().fixtureName;
         }
         else if(_loc2_.hasPhysicsToLoad())
         {
            assert("Object has physics to load but physics is null!",true,_loc3_);
         }
      }
      
      public function loadPhysicsReference(param1:PhysicsReference) : void
      {
         var _loc2_:* = undefined;
         assert("PhysicsReference is null.",true,param1 != null);
         for each(_loc2_ in param1.shapes)
         {
            this._shapes.push(_loc2_.copy());
         }
         this.setupBodyDef(param1.bodyDef);
      }
      
      protected function setupBodyDef(param1:BodyDef) : void
      {
         this._bodyDef.angle = param1.angle;
         this._bodyDef.awake = param1.awake;
         this._bodyDef.bullet = param1.bullet;
         this._bodyDef.fixedRotation = param1.fixedRotation;
         this._bodyDef.linearVelocity = param1.linearVelocity != null ? param1.linearVelocity.copy() : null;
         this._bodyDef.position = param1.position != null ? param1.position.copy() : null;
         this._bodyDef.type = param1.type;
         this._bodyDef.gravityScale = param1.gravityScale;
      }
   }
}

