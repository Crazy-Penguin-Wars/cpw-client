package tuxwars.battle.world
{
   import flash.geom.Point;
   import nape.dynamics.ArbiterList;
   import nape.geom.*;
   import nape.phys.*;
   import nape.shape.*;
   import tuxwars.battle.data.follower.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   
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
      
      public function Water(param1:PhysicsWorld, param2:Number, param3:Number, param4:Number, param5:Point, param6:Vector.<FollowerData>)
      {
         super();
         this._followersData = param6;
         this._world = param1;
         this.createBody(param1,param2);
      }
      
      public function dispose() : void
      {
         this.bodies.splice(0,this.bodies.length);
         this.toAdd.splice(0,this.toAdd.length);
         this.toRemove.splice(0,this.toRemove.length);
         this.body = null;
      }
      
      public function physicsUpdate() : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc1_:PhysicsGameObject = null;
         var _loc2_:Vec2 = null;
         var _loc3_:Follower = null;
         var _loc4_:Tagger = null;
         var _loc5_:Follower = null;
         this.addBodies();
         this.removeBodies();
         for each(_loc6_ in this.bodies)
         {
            _loc1_ = _loc6_.userData.gameObject as PlayerGameObject;
            if(Boolean(_loc1_) && Boolean(_loc1_.bodyLocation))
            {
               _loc2_ = _loc1_.bodyLocation;
               for each(_loc7_ in this._followersData)
               {
                  _loc3_ = _loc1_.getFollower(_loc7_.id);
                  if(!_loc3_)
                  {
                     _loc4_ = _loc1_.tag.findLatestPlayerTagger();
                     _loc5_ = Followers.createFollower(_loc7_.id,_loc2_,this._world,null,null,_loc1_,_loc4_ != null ? _loc4_ : new Tagger(_loc1_));
                  }
                  else
                  {
                     _loc3_.resetLifeTime();
                  }
               }
            }
         }
      }
      
      private function createBody(param1:PhysicsWorld, param2:Number) : void
      {
         var _loc3_:Number = param1.level.height - param1.level.waterLine;
         this.water = new Polygon(Polygon.rect(0,0,param1.level.width,_loc3_,true));
         this.water.fluidEnabled = true;
         this.water.fluidProperties.density = param2;
         this.water.filter.collisionMask = 0;
         this.water.filter.fluidMask = 2;
         this.body = new Body(BodyType.STATIC);
         this.body.position = Vec2.weak(0,param1.level.waterLine);
         this.body.userData.gameObject = this;
         this.body.shapes.add(this.water);
         this.body.space = param1.space;
      }
      
      public function get id() : String
      {
         return "WATER";
      }
      
      public function handleBeginContact(param1:Body, param2:ArbiterList) : void
      {
         this.toAdd.push(param1);
      }
      
      public function handleOngoingContact(param1:Body, param2:ArbiterList) : void
      {
      }
      
      public function handleEndContact(param1:Body, param2:ArbiterList) : void
      {
         this.toRemove.push(param1);
      }
      
      private function addBodies() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:PhysicsGameObject = null;
         for each(_loc2_ in this.toAdd)
         {
            this.bodies.push(_loc2_);
            _loc1_ = _loc2_.userData.gameObject as PhysicsGameObject;
            if(_loc1_)
            {
               _loc1_.enteredWater();
            }
         }
         this.toAdd.splice(0,this.toAdd.length);
      }
      
      private function removeBodies() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:PhysicsGameObject = null;
         for each(_loc2_ in this.toRemove)
         {
            this.removeBody(_loc2_);
            _loc1_ = _loc2_.userData.gameObject as PhysicsGameObject;
            if(_loc1_)
            {
               _loc1_.exitedWater();
            }
         }
         this.toRemove.splice(0,this.toRemove.length);
      }
      
      private function removeBody(param1:Body) : void
      {
         var _loc5_:* = undefined;
         var _loc2_:PhysicsGameObject = null;
         var _loc3_:Follower = null;
         var _loc4_:int = int(this.bodies.indexOf(param1));
         if(_loc4_ >= 0)
         {
            this.bodies.splice(_loc4_,1);
            _loc2_ = param1.userData.gameObject as PhysicsGameObject;
            if(_loc2_)
            {
               for each(_loc5_ in this._followersData)
               {
                  _loc3_ = _loc2_.getFollower(_loc5_.id);
                  if(_loc3_)
                  {
                     _loc3_.markForRemoval();
                  }
               }
            }
         }
      }
   }
}

