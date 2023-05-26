package tuxwars.battle.missiles
{
   import com.citrusengine.physics.PhysicsCollisionCategories;
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import org.odefu.flash.display.OdefuMovieClip;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.emitters.FiringDirection;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.utils.PerformanceTuner;
   import tuxwars.items.references.EmissionReference;
   
   public class Missile extends PhysicsEmissionGameObject implements FiringDirection
   {
      
      private static const BULLET_HIT:String = "hit";
       
      
      private var missileTailLocation:Point;
      
      private var previousLocation:Point;
      
      protected var _markedForExplosion:Boolean;
      
      private var _particleEffect:ParticleReference;
      
      private var _particleStreamSpawnDistance:int;
      
      private var _particleStreamSpawnTime:int;
      
      private var _particleSpawnTimer:int;
      
      private var _boosterExplosionEmissions:Array;
      
      private var _explosionDirection:Vec2;
      
      public function Missile(def:MissileDef, game:DCGame)
      {
         missileTailLocation = new Point(-2147483648,-2147483648);
         previousLocation = new Point(-2147483648,-2147483648);
         super(def,game);
         _particleEffect = def.particleEffect;
         _particleStreamSpawnDistance = def.particleStreamSpawnDistance;
         _particleStreamSpawnDistance += _particleStreamSpawnDistance * PerformanceTuner._particleStreamSpawnDistanceAugmentationPercentage / 100;
         _particleStreamSpawnTime = def.particleStreamSpawnTime;
         _particleStreamSpawnTime += _particleStreamSpawnTime * PerformanceTuner._particleStreamSpawnTimeAugmentationPercentage / 100;
         _particleSpawnTimer = 0;
         allowDisplayObjectRotation = false;
         playCollisionSounds = true;
         setCollisionFilterValues(PhysicsCollisionCategories.Get("MISSILE"),PhysicsCollisionCategories.GetAllExcept("MISSILE"));
         tag.allowClear = false;
      }
      
      override public function dispose() : void
      {
         _particleEffect = null;
         super.dispose();
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var j:int = 0;
         super.physicsUpdate(deltaTime);
         if(!body)
         {
            return;
         }
         if(!isInitialized(previousLocation))
         {
            if(_particleStreamSpawnDistance > 0)
            {
               previousLocation = body.position.toPoint();
            }
         }
         else
         {
            if(!_markedForExplosion)
            {
               missileTailLocation = body.position.toPoint();
            }
            else if(location)
            {
               missileTailLocation = location.toPoint();
            }
            if(isInitialized(missileTailLocation) && isInitialized(previousLocation))
            {
               _loc4_ = Point.distance(previousLocation,missileTailLocation);
               if(Math.abs(_loc4_) >= _particleStreamSpawnDistance)
               {
                  _loc3_ = (missileTailLocation.x - previousLocation.x) / _loc4_;
                  _loc2_ = (missileTailLocation.y - previousLocation.y) / _loc4_;
                  for(j = 0; j < _loc4_ - (_particleStreamSpawnDistance >> 1); )
                  {
                     (this.game as tuxwars.TuxWarsGame).tuxWorld.addParticle(_particleEffect,previousLocation.x + j * _loc3_,previousLocation.y + j * _loc2_,this._displayObject.rotation);
                     j += _particleStreamSpawnDistance;
                  }
                  previousLocation = missileTailLocation.clone();
               }
            }
         }
         if(_particleStreamSpawnTime > 0)
         {
            _particleSpawnTimer += deltaTime;
            if(_particleSpawnTimer >= _particleStreamSpawnTime)
            {
               if(!_markedForExplosion)
               {
                  missileTailLocation = body.position.toPoint();
               }
               else if(location)
               {
                  missileTailLocation = location.toPoint();
               }
               if(isInitialized(missileTailLocation))
               {
                  (this.game as tuxwars.TuxWarsGame).tuxWorld.addParticle(_particleEffect,missileTailLocation.x,missileTailLocation.y,this._displayObject.rotation);
               }
               _particleSpawnTimer -= _particleStreamSpawnTime;
            }
         }
      }
      
      public function get explosionDirection() : Vec2
      {
         return _explosionDirection;
      }
      
      public function get particleRef() : ParticleReference
      {
         return _particleEffect;
      }
      
      public function get markedForExplosion() : Boolean
      {
         return _markedForExplosion;
      }
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         switch(type)
         {
            case "weapon":
               break;
            case "missile":
               break;
            default:
               return super.affectsGameObject(type,taggerGameObject);
         }
         return true;
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         var _loc3_:* = null;
         var _loc4_:Vec2 = findFirstCollisionPosition(arbiterList);
         super.handleCollision(otherBody,arbiterList);
         if(!_markedForExplosion)
         {
            if(body.isBullet)
            {
               _loc3_ = !!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null;
               if(_loc3_ && _loc3_.indexOfLabel("hit") != -1)
               {
                  _loc3_.gotoAndStop("hit");
               }
            }
            markforExplosion();
            body.velocity.setxy(0,0);
            body.allowMovement = false;
            location = body.position.copy();
            emitLocation = body.position.copy();
            this._displayObject.visible = false;
            LogUtils.log("Missile explodes on contact with " + otherBody.userData.gameObject + " at " + location + " contact point: " + _loc4_ + " target loc: " + otherBody.position,this,1,"Collision",false,false,false);
         }
      }
      
      override public function triggerEmission() : void
      {
         var _loc1_:* = null;
         if(!_markedForExplosion)
         {
            if(body.isBullet)
            {
               _loc1_ = !!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null;
               if(_loc1_ && DCUtils.indexOfLabel(_loc1_,"hit") != -1)
               {
                  _loc1_.gotoAndStop("hit");
               }
            }
            markforExplosion();
            body.velocity.setxy(0,0);
            body.allowMovement = false;
            location = body.position.copy();
            emitLocation = body.position.copy();
            this._displayObject.visible = false;
            LogUtils.log("Missile is triggerd to explode at " + location,this,1,"Collision",false,false,false);
         }
      }
      
      override protected function updateTag(other:PhysicsGameObject) : void
      {
      }
      
      protected function markforExplosion() : void
      {
         _markedForExplosion = true;
         _explosionDirection = linearVelocity.copy();
         if(!lastLinearVelocity || lastLinearVelocity && lastLinearVelocity.length != 0)
         {
            lastLinearVelocity = linearVelocity.copy();
         }
         MessageCenter.sendMessage("MissileMarkedForExplosion");
      }
      
      public function setBoosterExplosionEmission(emission:EmissionReference) : void
      {
         if(!_boosterExplosionEmissions)
         {
            _boosterExplosionEmissions = [];
         }
         _boosterExplosionEmissions.push(emission);
      }
      
      override public function getBoosterExplosionEmissions() : Array
      {
         return _boosterExplosionEmissions;
      }
      
      private function isInitialized(p:Point) : Boolean
      {
         return p.x != -2147483648 || p.y != -2147483648;
      }
   }
}
