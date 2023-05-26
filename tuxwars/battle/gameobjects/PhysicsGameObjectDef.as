package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GameData;
   import nape.geom.Vec2;
   import nape.shape.Shape;
   import nape.space.Space;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.BodyDef;
   import tuxwars.battle.data.PhysicsReference;
   import tuxwars.battle.data.TuxGameObjectData;
   import tuxwars.battle.world.DynamicBodyManager;
   
   public class PhysicsGameObjectDef extends TuxGameObjectDef
   {
       
      
      private const _shapes:Array = [];
      
      private const _bodyDef:BodyDef = new BodyDef();
      
      private var _space:Space;
      
      private var _fixtureName:String;
      
      private var _bodyManager:DynamicBodyManager;
      
      public function PhysicsGameObjectDef(space:Space)
      {
         super();
         _space = space;
         _bodyDef.position = Vec2.get();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _space = null;
      }
      
      public function get shapes() : Array
      {
         return _shapes;
      }
      
      public function get bodyDef() : BodyDef
      {
         return _bodyDef;
      }
      
      public function get space() : Space
      {
         return _space;
      }
      
      public function get bodyManager() : DynamicBodyManager
      {
         return _bodyManager;
      }
      
      public function get fixtureName() : String
      {
         return _fixtureName;
      }
      
      public function get position() : Vec2
      {
         return _bodyDef.position;
      }
      
      public function set position(pos:Vec2) : void
      {
         _bodyDef.position = pos;
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not a TuxGameObjectData.",true,data is TuxGameObjectData);
         var _loc2_:TuxGameObjectData = data as TuxGameObjectData;
         var _loc3_:PhysicsReference = _loc2_.getPhysics();
         if(_loc3_)
         {
            loadPhysicsReference(_loc3_);
            _bodyManager = _loc2_.getPhysics().bodyManager;
            _fixtureName = _loc2_.getPhysics().fixtureName;
         }
         else if(_loc2_.hasPhysicsToLoad())
         {
            assert("Object has physics to load but physics is null!",true,_loc3_);
         }
      }
      
      public function loadPhysicsReference(ref:PhysicsReference) : void
      {
         assert("PhysicsReference is null.",true,ref != null);
         for each(var shape in ref.shapes)
         {
            _shapes.push(shape.copy());
         }
         setupBodyDef(ref.bodyDef);
      }
      
      protected function setupBodyDef(def:BodyDef) : void
      {
         _bodyDef.angle = def.angle;
         _bodyDef.awake = def.awake;
         _bodyDef.bullet = def.bullet;
         _bodyDef.fixedRotation = def.fixedRotation;
         _bodyDef.linearVelocity = def.linearVelocity != null ? def.linearVelocity.copy() : null;
         _bodyDef.position = def.position != null ? def.position.copy() : null;
         _bodyDef.type = def.type;
         _bodyDef.gravityScale = def.gravityScale;
      }
   }
}
