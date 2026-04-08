package tuxwars.battle.world
{
   import com.dchoc.utils.*;
   import nape.geom.*;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.shape.*;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.*;
   
   public class SpawnPointFinder
   {
      private static const NUM_LOCATIONS:int = 100;
      
      private static const TOP_HUD_HEIGHT:int = 69;
      
      private var world:TuxWorld;
      
      private var _randomPoint:Boolean;
      
      private var random:Random;
      
      public function SpawnPointFinder(param1:TuxWorld, param2:Random = null)
      {
         super();
         this.world = param1;
         this.random = param2 != null ? param2 : BattleManager.getRandom();
      }
      
      public function findSpawnLocation(param1:Number) : Vec2
      {
         var _loc23_:* = undefined;
         var _loc2_:Number = Number(NaN);
         _loc2_ = 46;
         var _loc3_:Number = Number(NaN);
         var _loc4_:TerrainGameObject = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:AABB = null;
         var _loc7_:* = NaN;
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:int = 0;
         var _loc11_:Vec2 = null;
         var _loc12_:* = undefined;
         var _loc13_:int = 0;
         var _loc14_:Vec2 = null;
         var _loc15_:Vec2 = null;
         LogUtils.log("Finding spawn location...",this,1,"PhysicsWorld",false,false,false);
         var _loc16_:Number = Number(this.world.calculateNormalZoomLevel());
         var _loc17_:int = this.world.physicsWorld.level.width * 0.5 - 760 / _loc16_ * 0.5;
         var _loc18_:int = this.world.physicsWorld.level.height * 0.5 - 668 / _loc16_ * 0.5;
         var _loc19_:AABB = new AABB(_loc17_,_loc18_,760 / _loc16_,668 / _loc16_);
         var _loc20_:Vector.<PhysicsGameObject> = this.world.getAffectedGameObjectsInAABB(_loc19_,false);
         var _loc21_:AABB = new AABB();
         var _loc22_:Vector.<Vec2> = new Vector.<Vec2>();
         for each(_loc23_ in _loc20_)
         {
            if(_loc23_ is TerrainGameObject)
            {
               _loc3_ = Number(Circle(BattleManager.getLocalPlayer().body.shapes.at(0)).radius);
               if(_loc3_ > 0)
               {
                  _loc4_ = TerrainGameObject(_loc23_);
                  _loc5_ = _loc4_.bodyLocation.x;
                  _loc6_ = _loc4_.generateAABB();
                  if(_loc6_)
                  {
                     _loc7_ = _loc3_;
                     while(_loc6_.width > _loc7_)
                     {
                        _loc22_.push(new Vec2(_loc5_ + _loc6_.x + _loc7_,46));
                        _loc7_ += _loc3_ * 2;
                     }
                  }
               }
               else
               {
                  LogUtils.log("Player radius is 0 or less, findSpawnLocation not work correct",this,2,"Player",false,false,false);
               }
            }
            else if(_loc23_ is LevelGameObject)
            {
               _loc8_ = Number(BattleManager.getLocalPlayer().body.mass);
               if(_loc8_ > 0)
               {
                  _loc9_ = Number(_loc23_.body.mass);
                  if(_loc9_ > _loc8_ && (_loc23_ as LevelGameObject).material != "Ice")
                  {
                     _loc22_.push(new Vec2(_loc23_.body.position.x,46));
                  }
               }
               else
               {
                  LogUtils.log("Player mass is 0 or less, findSpawnLocation not work correct",this,2,"Player",false,false,false);
               }
            }
         }
         if(_loc22_.length < 1)
         {
            _loc22_ = this.createRayCastLocations();
         }
         while(_loc22_.length > 0)
         {
            LogUtils.log("Call to random findSpawnLocation() locations",this,0,"Random",false,false,false);
            _loc10_ = int(this.random.integer(_loc22_.length));
            _loc11_ = _loc22_.splice(_loc10_,1)[0];
            LogUtils.log("Try spawn line: " + _loc11_,this,1,"PhysicsWorld",false,false,false);
            _loc12_ = this.getLandingPoints(_loc11_);
            LogUtils.log("Got # landing points: " + _loc12_.length,this,1,"PhysicsWorld",false,false,false);
            while(_loc12_.length > 0)
            {
               LogUtils.log("Call to random findSpawnLocation() land points",this,0,"Random",false,false,false);
               _loc13_ = int(this.random.integer(_loc12_.length));
               _loc14_ = _loc12_.splice(_loc13_,1)[0];
               _loc14_.y -= param1;
               this.moveAABBTo(_loc21_,_loc14_,param1);
               LogUtils.log("Testing land point: " + _loc14_,this,1,"PhysicsWorld",false,false,false);
               if(!this.intersectsFixture(_loc21_))
               {
                  return _loc14_;
               }
               LogUtils.log("Not valid land point: " + _loc14_ + " and not valid AABB: " + _loc21_,this,1,"PhysicsWorld",false,false,false);
            }
         }
         this._randomPoint = true;
         while(true)
         {
            _loc15_ = this.randomPointOnScreen();
            this.moveAABBTo(_loc21_,_loc15_,param1);
            LogUtils.log("Testing random point: " + _loc15_,this,1,"PhysicsWorld",false,false,false);
            if(!this.intersectsFixture(_loc21_))
            {
               break;
            }
            LogUtils.log("Not valid random point: " + _loc15_ + " and not valid AABB: " + _loc21_,this,1,"PhysicsWorld",false,false,false);
         }
         return _loc15_;
      }
      
      public function get wasRandomPoint() : Boolean
      {
         return this._randomPoint;
      }
      
      public function isValidPoint(param1:Vec2, param2:Number) : Boolean
      {
         var _loc3_:AABB = new AABB();
         this.moveAABBTo(_loc3_,param1,param2);
         return !this.intersectsFixture(_loc3_);
      }
      
      private function randomPointOnScreen() : Vec2
      {
         var _loc1_:int = this.world.physicsWorld.level.width * 0.5 - 760 * 0.5;
         var _loc2_:int = this.world.physicsWorld.level.width * 0.5 + 760 * 0.5;
         var _loc3_:int = this.world.physicsWorld.level.height * 0.5 - 668 * 0.5 + 69;
         var _loc4_:int = this.world.physicsWorld.level.height * 0.5 + 668 * 0.5;
         LogUtils.log("Call to random randomPointOnScreen()",this,0,"Random",false,false,false);
         return new Vec2(this.random.integer(_loc1_,_loc2_),this.random.integer(_loc3_,_loc4_));
      }
      
      private function createRayCastLocations() : Vector.<Vec2>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc3_:int = this.world.physicsWorld.level.width * 0.5 - 760 * 0.5;
         var _loc4_:int = this.world.physicsWorld.level.width * 0.5 + 760 * 0.5;
         var _loc5_:int = _loc4_ / 100;
         var _loc6_:Vec2 = new Vec2();
         _loc6_.y = 69;
         LogUtils.log("Creating raycast locations, start x: " + _loc3_ + " end x: " + _loc4_ + " step: " + _loc5_,this,1,"PhysicsWorld",false,false,false);
         _loc1_ = 0;
         while(_loc1_ < 100)
         {
            _loc6_.x = _loc1_ * _loc5_ + _loc3_;
            if(_loc6_.x < _loc3_ + _loc4_)
            {
               _loc2_.push(_loc6_);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      private function getLandingPoints(param1:Vec2) : Vector.<Vec2>
      {
         var _loc2_:int = 0;
         var _loc3_:RayResult = null;
         var _loc4_:Vec2 = new Vec2(param1.x,this.world.physicsWorld.level.waterLine);
         var _loc5_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc6_:Ray = new Ray(param1,_loc4_.sub(param1));
         var _loc7_:RayResultList = this.world.physicsWorld.space.rayMultiCast(_loc6_);
         var _loc8_:int = _loc7_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc8_)
         {
            _loc3_ = _loc7_.at(_loc2_);
            if(!_loc3_.shape.fluidEnabled && !_loc3_.shape.sensorEnabled)
            {
               _loc5_.push(_loc6_.at(_loc3_.distance));
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      private function intersectsFixture(param1:AABB) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Body = null;
         var _loc4_:BodyList = this.world.physicsWorld.space.bodiesInAABB(param1);
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc3_ = _loc4_.at(_loc2_);
            if(!this.isSensor(_loc3_))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function isSensor(param1:Body) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Shape = null;
         _loc2_ = 0;
         while(_loc2_ < param1.shapes.length)
         {
            _loc3_ = param1.shapes.at(_loc2_);
            if(_loc3_.sensorEnabled)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function moveAABBTo(param1:AABB, param2:Vec2, param3:Number) : void
      {
         var _loc4_:Number = param3 * 0.5;
         param1.x = param2.x - _loc4_;
         param1.y = param2.y - _loc4_;
         param1.width = param3;
         param1.height = param3;
      }
   }
}

