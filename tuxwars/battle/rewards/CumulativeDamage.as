package tuxwars.battle.rewards
{
   import com.dchoc.utils.*;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.data.*;
   
   public class CumulativeDamage
   {
      private var lifeTime:int;
      
      private var player:PlayerGameObject;
      
      private var targetObject:PhysicsGameObject;
      
      private var world:TuxWorld;
      
      private var _damageSources:Vector.<Damage> = new Vector.<Damage>();
      
      public function CumulativeDamage(param1:PhysicsGameObject, param2:Damage, param3:TuxWorld)
      {
         super();
         this.lifeTime = RewardConfig.getDamageCollectionTime();
         this.player = param2.taggingPlayer;
         this.targetObject = param1;
         this.world = param3;
         this.pushDamage(param2);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         this.world = null;
         this.player = null;
         this.targetObject = null;
         for each(_loc1_ in this._damageSources)
         {
            _loc1_.dispose();
         }
         this._damageSources.splice(0,this._damageSources.length);
      }
      
      public function isTriggered() : Boolean
      {
         return this.lifeTime <= 0;
      }
      
      public function isPlayer(param1:PlayerGameObject) : Boolean
      {
         return this.player == param1;
      }
      
      public function get damagerSources() : Vector.<Damage>
      {
         return this._damageSources;
      }
      
      private function pushDamage(param1:Damage) : void
      {
         if(this.isPlayer(param1.taggingPlayer))
         {
            this._damageSources.push(param1);
         }
         else
         {
            LogUtils.log("Not correct player!",this,3,"CumulativeDamage",true,true,true);
         }
      }
      
      public function addDamage(param1:Damage) : void
      {
         this.pushDamage(param1);
      }
      
      private function getAccumulatedDamage() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for each(_loc2_ in this._damageSources)
         {
            _loc1_ += _loc2_.amount;
         }
         return _loc1_;
      }
      
      public function physicsUpdate(param1:int) : void
      {
         var _loc7_:PlayerGameObject = null;
         var _loc8_:PhysicsGameObject = null;
         var _loc9_:PhysicsGameObject = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:AvatarGameObject = null;
         var _loc5_:TextEffect = null;
         var _loc6_:String = null;
         this.lifeTime -= param1;
         if(this.targetObject != null)
         {
            _loc2_ = Boolean(this.targetObject.isDeadHP()) || Boolean(_loc7_._markedForRemoval);
            if(this.lifeTime <= 0 || _loc2_)
            {
               if(_loc2_)
               {
                  this.lifeTime = 0;
               }
               _loc3_ = int(this.getAccumulatedDamage());
               this.targetObject.reduceHitPoints(this.cumulativeDamageObject);
               if(this.player != null)
               {
                  if(this.player.rewardsHandler)
                  {
                     this.player.rewardsHandler.damageDoneToTarget(_loc3_,this.targetObject);
                  }
                  else
                  {
                     _loc7_ = this.player;
                     LogUtils.log("PlayerID: " + _loc7_._id + " rewards handler is null",this,2,"CumulativeDamage");
                  }
               }
               else
               {
                  LogUtils.log("player is null",this,2,"CumulativeDamage");
               }
               if(this.targetObject is AvatarGameObject)
               {
                  if(Boolean(this.player) && this.player != this.targetObject)
                  {
                     _loc8_ = this.targetObject;
                     this.player.addScoreFromDamage(_loc8_._id,_loc3_);
                  }
                  else if(this.player && this.player == this.targetObject && _loc3_ > 0)
                  {
                     _loc9_ = this.targetObject;
                     this.player.reduceScoreFromDamage(_loc9_._id,_loc3_);
                  }
                  _loc4_ = AvatarGameObject(this.targetObject);
                  if(_loc3_ > 0)
                  {
                     _loc5_ = this.world.addTextEffect(0,_loc3_.toString(),_loc4_.container.x,_loc4_.container.y,false);
                     this.world.ignoreLevelSizeScale(_loc5_.movieClip,true,false);
                  }
                  else if(_loc3_ < 0)
                  {
                     LogUtils.log("Cumulative damage is healing",this,2,"CumulativeDamage");
                     _loc6_ = Math.abs(_loc3_).toString();
                     _loc5_ = this.world.addTextEffect(1,_loc6_,_loc4_.container.x,_loc4_.container.y,false);
                     this.world.ignoreLevelSizeScale(_loc5_.movieClip,true,false);
                  }
               }
            }
         }
         else
         {
            LogUtils.log("targetObject is null",this,2,"DamageApply");
         }
      }
      
      private function get cumulativeDamageObject() : Damage
      {
         var _loc2_:* = undefined;
         var _loc1_:Damage = new Damage(this,"C","-1",0,null,this.player);
         for each(_loc2_ in this._damageSources)
         {
            _loc1_.addDamage(_loc2_.damageSourceClasses[0],_loc2_.idsOfDamageWithDamage[0],_loc2_.uniquesIdsOfDamage[0],_loc2_.amount,_loc2_.locations[0]);
         }
         return _loc1_;
      }
   }
}

