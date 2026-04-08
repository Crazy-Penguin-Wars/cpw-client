package tuxwars.battle.missiles
{
   import com.citrusengine.physics.*;
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.geom.*;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import org.odefu.flash.display.OdefuMovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.utils.*;
   import tuxwars.items.references.EmissionReference;
   
   public class Missile extends PhysicsEmissionGameObject implements FiringDirection
   {
      private static const BULLET_HIT:String = "hit";
      
      private var missileTailLocation:Point = new Point(-2147483648,-2147483648);
      
      private var previousLocation:Point = new Point(-2147483648,-2147483648);
      
      protected var _markedForExplosion:Boolean;
      
      private var _particleEffect:ParticleReference;
      
      private var _particleStreamSpawnDistance:int;
      
      private var _particleStreamSpawnTime:int;
      
      private var _particleSpawnTimer:int;
      
      private var _boosterExplosionEmissions:Array;
      
      private var _explosionDirection:Vec2;
      
      public function Missile(param1:MissileDef, param2:DCGame)
      {
         super(param1,param2);
         this._particleEffect = param1.particleEffect;
         this._particleStreamSpawnDistance = param1.particleStreamSpawnDistance;
         this._particleStreamSpawnDistance += this._particleStreamSpawnDistance * PerformanceTuner._particleStreamSpawnDistanceAugmentationPercentage / 100;
         this._particleStreamSpawnTime = param1.particleStreamSpawnTime;
         this._particleStreamSpawnTime += this._particleStreamSpawnTime * PerformanceTuner._particleStreamSpawnTimeAugmentationPercentage / 100;
         this._particleSpawnTimer = 0;
         allowDisplayObjectRotation = false;
         playCollisionSounds = true;
         setCollisionFilterValues(PhysicsCollisionCategories.Get("MISSILE"),PhysicsCollisionCategories.GetAllExcept("MISSILE"));
         tag.allowClear = false;
      }
      
      override public function dispose() : void
      {
         this._particleEffect = null;
         super.dispose();
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:int = 0;
         super.physicsUpdate(param1);
         if(!body)
         {
            return;
         }
         if(!this.isInitialized(this.previousLocation))
         {
            if(this._particleStreamSpawnDistance > 0)
            {
               this.previousLocation = body.position.toPoint();
            }
         }
         else
         {
            if(!this._markedForExplosion)
            {
               this.missileTailLocation = body.position.toPoint();
            }
            else if(location)
            {
               this.missileTailLocation = location.toPoint();
            }
            if(Boolean(this.isInitialized(this.missileTailLocation)) && Boolean(this.isInitialized(this.previousLocation)))
            {
               _loc2_ = Number(Point.distance(this.previousLocation,this.missileTailLocation));
               if(Math.abs(_loc2_) >= this._particleStreamSpawnDistance)
               {
                  _loc3_ = (this.missileTailLocation.x - this.previousLocation.x) / _loc2_;
                  _loc4_ = (this.missileTailLocation.y - this.previousLocation.y) / _loc2_;
                  _loc5_ = 0;
                  while(_loc5_ < _loc2_ - (this._particleStreamSpawnDistance >> 1))
                  {
                     (this.game as TuxWarsGame).tuxWorld.addParticle(this._particleEffect,this.previousLocation.x + _loc5_ * _loc3_,this.previousLocation.y + _loc5_ * _loc4_,this._displayObject.rotation);
                     _loc5_ += this._particleStreamSpawnDistance;
                  }
                  this.previousLocation = this.missileTailLocation.clone();
               }
            }
         }
         if(this._particleStreamSpawnTime > 0)
         {
            this._particleSpawnTimer += param1;
            if(this._particleSpawnTimer >= this._particleStreamSpawnTime)
            {
               if(!this._markedForExplosion)
               {
                  this.missileTailLocation = body.position.toPoint();
               }
               else if(location)
               {
                  this.missileTailLocation = location.toPoint();
               }
               if(this.isInitialized(this.missileTailLocation))
               {
                  (this.game as TuxWarsGame).tuxWorld.addParticle(this._particleEffect,this.missileTailLocation.x,this.missileTailLocation.y,this._displayObject.rotation);
               }
               this._particleSpawnTimer -= this._particleStreamSpawnTime;
            }
         }
      }
      
      public function get explosionDirection() : Vec2
      {
         return this._explosionDirection;
      }
      
      public function get particleRef() : ParticleReference
      {
         return this._particleEffect;
      }
      
      public function get markedForExplosion() : Boolean
      {
         return this._markedForExplosion;
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         switch(param1)
         {
            case "weapon":
            case "missile":
               return true;
            default:
               return super.affectsGameObject(param1,param2);
         }
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         var _loc3_:OdefuMovieClip = null;
         var _loc4_:Vec2 = findFirstCollisionPosition(param2);
         super.handleCollision(param1,param2);
         if(!this._markedForExplosion)
         {
            if(body.isBullet)
            {
               _loc3_ = !!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null;
               if(Boolean(_loc3_) && _loc3_.indexOfLabel("hit") != -1)
               {
                  _loc3_.gotoAndStop("hit");
               }
            }
            this.markforExplosion();
            body.velocity.setxy(0,0);
            body.allowMovement = false;
            location = body.position.copy();
            emitLocation = body.position.copy();
            this._displayObject.visible = false;
            LogUtils.log("Missile explodes on contact with " + param1.userData.gameObject + " at " + location + " contact point: " + _loc4_ + " target loc: " + param1.position,this,1,"Collision",false,false,false);
         }
      }
      
      override public function triggerEmission() : void
      {
         var _loc1_:MovieClip = null;
         if(!this._markedForExplosion)
         {
            if(body.isBullet)
            {
               _loc1_ = !!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null;
               if(Boolean(_loc1_) && DCUtils.indexOfLabel(_loc1_,"hit") != -1)
               {
                  _loc1_.gotoAndStop("hit");
               }
            }
            this.markforExplosion();
            body.velocity.setxy(0,0);
            body.allowMovement = false;
            location = body.position.copy();
            emitLocation = body.position.copy();
            this._displayObject.visible = false;
            LogUtils.log("Missile is triggerd to explode at " + location,this,1,"Collision",false,false,false);
         }
      }
      
      override protected function updateTag(param1:PhysicsGameObject) : void
      {
      }
      
      protected function markforExplosion() : void
      {
         this._markedForExplosion = true;
         this._explosionDirection = linearVelocity.copy();
         if(!lastLinearVelocity || lastLinearVelocity && lastLinearVelocity.length != 0)
         {
            lastLinearVelocity = linearVelocity.copy();
         }
         MessageCenter.sendMessage("MissileMarkedForExplosion");
      }
      
      public function setBoosterExplosionEmission(param1:EmissionReference) : void
      {
         if(!this._boosterExplosionEmissions)
         {
            this._boosterExplosionEmissions = [];
         }
         this._boosterExplosionEmissions.push(param1);
      }
      
      override public function getBoosterExplosionEmissions() : Array
      {
         return this._boosterExplosionEmissions;
      }
      
      private function isInitialized(param1:Point) : Boolean
      {
         return param1.x != -2147483648 || param1.y != -2147483648;
      }
   }
}

