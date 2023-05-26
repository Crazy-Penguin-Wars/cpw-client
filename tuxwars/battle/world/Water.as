package tuxwars.battle.world
{
   import flash.geom.Point;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyType;
   import nape.shape.Polygon;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.follower.Followers;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class Water implements Collider
   {
      
      public static const WATER_MASK:int = 2;
       
      
      private const bodies:Vector.<Body> = new Vector.<Body>();
      
      private const toAdd:Vector.<Body> = new Vector.<Body>();
      
      private const toRemove:Vector.<Body> = new Vector.<Body>();
      
      private var body:Body;
      
      private var water:Polygon;
      
      private var _world:PhysicsWorld;
      
      private var _followersData:Vector.<FollowerData>;
      
      public function Water(world:PhysicsWorld, density:Number, linearDrag:Number, angularDrag:Number, velocity:Point, followersData:Vector.<FollowerData>)
      {
         super();
         _followersData = followersData;
         _world = world;
         createBody(world,density);
      }
      
      public function dispose() : void
      {
         bodies.splice(0,bodies.length);
         toAdd.splice(0,toAdd.length);
         toRemove.splice(0,toRemove.length);
         body = null;
      }
      
      public function physicsUpdate() : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc1_:* = null;
         addBodies();
         removeBodies();
         for each(var body in bodies)
         {
            _loc4_ = body.userData.gameObject as PlayerGameObject;
            if(_loc4_ && _loc4_.bodyLocation)
            {
               _loc2_ = _loc4_.bodyLocation;
               for each(var followerData in _followersData)
               {
                  _loc7_ = _loc4_.getFollower(followerData.id);
                  if(!_loc7_)
                  {
                     _loc6_ = _loc4_.tag.findLatestPlayerTagger();
                     _loc1_ = Followers.createFollower(followerData.id,_loc2_,_world,null,null,_loc4_,_loc6_ != null ? _loc6_ : new Tagger(_loc4_));
                  }
                  else
                  {
                     _loc7_.resetLifeTime();
                  }
               }
            }
         }
      }
      
      private function createBody(world:PhysicsWorld, density:Number) : void
      {
         var _loc3_:Number = world.level.height - world.level.waterLine;
         water = new Polygon(Polygon.rect(0,0,world.level.width,_loc3_,true));
         water.fluidEnabled = true;
         water.fluidProperties.density = density;
         water.filter.collisionMask = 0;
         water.filter.fluidMask = 2;
         body = new Body(BodyType.STATIC);
         body.position = Vec2.weak(0,world.level.waterLine);
         body.userData.gameObject = this;
         body.shapes.add(water);
         body.space = world.space;
      }
      
      public function get id() : String
      {
         return "WATER";
      }
      
      public function handleBeginContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
         toAdd.push(otherBody);
      }
      
      public function handleOngoingContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
      }
      
      public function handleEndContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
         toRemove.push(otherBody);
      }
      
      private function addBodies() : void
      {
         var _loc2_:* = null;
         for each(var body in toAdd)
         {
            bodies.push(body);
            _loc2_ = body.userData.gameObject as PhysicsGameObject;
            if(_loc2_)
            {
               _loc2_.enteredWater();
            }
         }
         toAdd.splice(0,toAdd.length);
      }
      
      private function removeBodies() : void
      {
         var _loc2_:* = null;
         for each(var body in toRemove)
         {
            removeBody(body);
            _loc2_ = body.userData.gameObject as PhysicsGameObject;
            if(_loc2_)
            {
               _loc2_.exitedWater();
            }
         }
         toRemove.splice(0,toRemove.length);
      }
      
      private function removeBody(body:Body) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:int = bodies.indexOf(body);
         if(_loc3_ >= 0)
         {
            bodies.splice(_loc3_,1);
            _loc4_ = body.userData.gameObject as PhysicsGameObject;
            if(_loc4_)
            {
               for each(var fod in _followersData)
               {
                  _loc5_ = _loc4_.getFollower(fod.id);
                  if(_loc5_)
                  {
                     _loc5_.markForRemoval();
                  }
               }
            }
         }
      }
   }
}
