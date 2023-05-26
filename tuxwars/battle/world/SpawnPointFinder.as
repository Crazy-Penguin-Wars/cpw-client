package tuxwars.battle.world
{
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.Random;
   import nape.geom.AABB;
   import nape.geom.Ray;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.shape.Circle;
   import nape.shape.Shape;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.LevelGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   
   public class SpawnPointFinder
   {
      
      private static const NUM_LOCATIONS:int = 100;
      
      private static const TOP_HUD_HEIGHT:int = 69;
       
      
      private var world:TuxWorld;
      
      private var _randomPoint:Boolean;
      
      private var random:Random;
      
      public function SpawnPointFinder(world:TuxWorld, random:Random = null)
      {
         super();
         this.world = world;
         this.random = random != null ? random : BattleManager.getRandom();
      }
      
      public function findSpawnLocation(size:Number) : Vec2
      {
         var _loc22_:Number = NaN;
         _loc22_ = 46;
         var _loc21_:Number = NaN;
         var _loc3_:* = null;
         var _loc23_:Number = NaN;
         var _loc2_:* = null;
         var pos:* = NaN;
         var _loc19_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc14_:* = undefined;
         var _loc17_:int = 0;
         var _loc4_:* = null;
         var _loc9_:* = null;
         LogUtils.log("Finding spawn location...",this,1,"PhysicsWorld",false,false,false);
         var _loc7_:Number = world.calculateNormalZoomLevel();
         var _loc12_:int = world.physicsWorld.level.width * 0.5 - 760 / _loc7_ * 0.5;
         var _loc13_:int = world.physicsWorld.level.height * 0.5 - 668 / _loc7_ * 0.5;
         var _loc6_:AABB = new AABB(_loc12_,_loc13_,760 / _loc7_,668 / _loc7_);
         var _loc20_:Vector.<PhysicsGameObject> = world.getAffectedGameObjectsInAABB(_loc6_,false);
         var _loc15_:AABB = new AABB();
         var locations:Vector.<Vec2> = new Vector.<Vec2>();
         for each(var obj in _loc20_)
         {
            if(obj is TerrainGameObject)
            {
               _loc21_ = Number(Circle(BattleManager.getLocalPlayer().body.shapes.at(0)).radius);
               if(_loc21_ > 0)
               {
                  _loc3_ = TerrainGameObject(obj);
                  _loc23_ = _loc3_.bodyLocation.x;
                  _loc2_ = _loc3_.generateAABB();
                  if(_loc2_)
                  {
                     pos = _loc21_;
                     while(_loc2_.width > pos)
                     {
                        locations.push(new Vec2(_loc23_ + _loc2_.x + pos,46));
                        pos += _loc21_ * 2;
                     }
                  }
               }
               else
               {
                  LogUtils.log("Player radius is 0 or less, findSpawnLocation not work correct",this,2,"Player",false,false,false);
               }
            }
            else if(obj is LevelGameObject)
            {
               _loc19_ = BattleManager.getLocalPlayer().body.mass;
               if(_loc19_ > 0)
               {
                  _loc10_ = obj.body.mass;
                  if(_loc10_ > _loc19_ && (obj as LevelGameObject).material != "Ice")
                  {
                     locations.push(new Vec2(obj.body.position.x,46));
                  }
               }
               else
               {
                  LogUtils.log("Player mass is 0 or less, findSpawnLocation not work correct",this,2,"Player",false,false,false);
               }
            }
         }
         if(locations.length < 1)
         {
            locations = createRayCastLocations();
         }
         while(locations.length > 0)
         {
            LogUtils.log("Call to random findSpawnLocation() locations",this,0,"Random",false,false,false);
            _loc5_ = random.integer(locations.length);
            _loc8_ = locations.splice(_loc5_,1)[0];
            LogUtils.log("Try spawn line: " + _loc8_,this,1,"PhysicsWorld",false,false,false);
            _loc14_ = getLandingPoints(_loc8_);
            LogUtils.log("Got # landing points: " + _loc14_.length,this,1,"PhysicsWorld",false,false,false);
            while(_loc14_.length > 0)
            {
               LogUtils.log("Call to random findSpawnLocation() land points",this,0,"Random",false,false,false);
               _loc17_ = random.integer(_loc14_.length);
               _loc4_ = _loc14_.splice(_loc17_,1)[0];
               _loc4_.y -= size;
               moveAABBTo(_loc15_,_loc4_,size);
               LogUtils.log("Testing land point: " + _loc4_,this,1,"PhysicsWorld",false,false,false);
               if(!intersectsFixture(_loc15_))
               {
                  return _loc4_;
               }
               LogUtils.log("Not valid land point: " + _loc4_ + " and not valid AABB: " + _loc15_,this,1,"PhysicsWorld",false,false,false);
            }
         }
         _randomPoint = true;
         while(true)
         {
            _loc9_ = randomPointOnScreen();
            moveAABBTo(_loc15_,_loc9_,size);
            LogUtils.log("Testing random point: " + _loc9_,this,1,"PhysicsWorld",false,false,false);
            if(!intersectsFixture(_loc15_))
            {
               break;
            }
            LogUtils.log("Not valid random point: " + _loc9_ + " and not valid AABB: " + _loc15_,this,1,"PhysicsWorld",false,false,false);
         }
         return _loc9_;
      }
      
      public function get wasRandomPoint() : Boolean
      {
         return _randomPoint;
      }
      
      public function isValidPoint(point:Vec2, size:Number) : Boolean
      {
         var _loc3_:AABB = new AABB();
         moveAABBTo(_loc3_,point,size);
         return !intersectsFixture(_loc3_);
      }
      
      private function randomPointOnScreen() : Vec2
      {
         var _loc1_:int = world.physicsWorld.level.width * 0.5 - 760 * 0.5;
         var _loc3_:int = world.physicsWorld.level.width * 0.5 + 760 * 0.5;
         var _loc2_:int = world.physicsWorld.level.height * 0.5 - 668 * 0.5 + 69;
         var _loc4_:int = world.physicsWorld.level.height * 0.5 + 668 * 0.5;
         LogUtils.log("Call to random randomPointOnScreen()",this,0,"Random",false,false,false);
         return new Vec2(random.integer(_loc1_,_loc3_),random.integer(_loc2_,_loc4_));
      }
      
      private function createRayCastLocations() : Vector.<Vec2>
      {
         var i:int = 0;
         var _loc3_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc1_:int = world.physicsWorld.level.width * 0.5 - 760 * 0.5;
         var _loc2_:int = world.physicsWorld.level.width * 0.5 + 760 * 0.5;
         var _loc5_:int = _loc2_ / 100;
         var _loc4_:Vec2 = new Vec2();
         _loc4_.y = 69;
         LogUtils.log("Creating raycast locations, start x: " + _loc1_ + " end x: " + _loc2_ + " step: " + _loc5_,this,1,"PhysicsWorld",false,false,false);
         for(i = 0; i < 100; )
         {
            _loc4_.x = i * _loc5_ + _loc1_;
            if(_loc4_.x < _loc1_ + _loc2_)
            {
               _loc3_.push(_loc4_);
            }
            i++;
         }
         return _loc3_;
      }
      
      private function getLandingPoints(point:Vec2) : Vector.<Vec2>
      {
         var i:int = 0;
         var _loc2_:* = null;
         var _loc6_:Vec2 = new Vec2(point.x,world.physicsWorld.level.waterLine);
         var _loc7_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc4_:Ray = new Ray(point,_loc6_.sub(point));
         var _loc5_:RayResultList = world.physicsWorld.space.rayMultiCast(_loc4_);
         var _loc3_:int = _loc5_.length;
         for(i = 0; i < _loc3_; )
         {
            _loc2_ = _loc5_.at(i);
            if(!_loc2_.shape.fluidEnabled && !_loc2_.shape.sensorEnabled)
            {
               _loc7_.push(_loc4_.at(_loc2_.distance));
            }
            i++;
         }
         return _loc7_;
      }
      
      private function intersectsFixture(aabb:AABB) : Boolean
      {
         var i:int = 0;
         var _loc2_:* = null;
         var _loc3_:BodyList = world.physicsWorld.space.bodiesInAABB(aabb);
         for(i = 0; i < _loc3_.length; )
         {
            _loc2_ = _loc3_.at(i);
            if(!isSensor(_loc2_))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function isSensor(body:Body) : Boolean
      {
         var i:int = 0;
         var _loc2_:* = null;
         for(i = 0; i < body.shapes.length; )
         {
            _loc2_ = body.shapes.at(i);
            if(_loc2_.sensorEnabled)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function moveAABBTo(aabb:AABB, centerLoc:Vec2, size:Number) : void
      {
         var _loc4_:Number = size * 0.5;
         aabb.x = centerLoc.x - _loc4_;
         aabb.y = centerLoc.y - _loc4_;
         aabb.width = size;
         aabb.height = size;
      }
   }
}
