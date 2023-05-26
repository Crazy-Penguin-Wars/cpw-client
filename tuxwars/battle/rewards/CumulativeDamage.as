package tuxwars.battle.rewards
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.AvatarGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.data.RewardConfig;
   
   public class CumulativeDamage
   {
       
      
      private var lifeTime:int;
      
      private var player:PlayerGameObject;
      
      private var targetObject:PhysicsGameObject;
      
      private var world:TuxWorld;
      
      private var _damageSources:Vector.<Damage>;
      
      public function CumulativeDamage(targetObject:PhysicsGameObject, damageSource:Damage, world:TuxWorld)
      {
         _damageSources = new Vector.<Damage>();
         super();
         this.lifeTime = RewardConfig.getDamageCollectionTime();
         this.player = damageSource.taggingPlayer;
         this.targetObject = targetObject;
         this.world = world;
         pushDamage(damageSource);
      }
      
      public function dispose() : void
      {
         world = null;
         player = null;
         targetObject = null;
         for each(var damageSource in _damageSources)
         {
            damageSource.dispose();
         }
         _damageSources.splice(0,_damageSources.length);
      }
      
      public function isTriggered() : Boolean
      {
         return lifeTime <= 0;
      }
      
      public function isPlayer(player:PlayerGameObject) : Boolean
      {
         return this.player == player;
      }
      
      public function get damagerSources() : Vector.<Damage>
      {
         return _damageSources;
      }
      
      private function pushDamage(damageSource:Damage) : void
      {
         if(isPlayer(damageSource.taggingPlayer))
         {
            _damageSources.push(damageSource);
         }
         else
         {
            LogUtils.log("Not correct player!",this,3,"CumulativeDamage",true,true,true);
         }
      }
      
      public function addDamage(damageSource:Damage) : void
      {
         pushDamage(damageSource);
      }
      
      private function getAccumulatedDamage() : int
      {
         var accumulatedDamage:int = 0;
         for each(var damage in _damageSources)
         {
            accumulatedDamage += damage.amount;
         }
         return accumulatedDamage;
      }
      
      public function physicsUpdate(deltaTime:int) : void
      {
         var _loc3_:Boolean = false;
         var damage:int = 0;
         var _loc5_:* = null;
         var textEffect:* = null;
         var _loc6_:* = null;
         lifeTime -= deltaTime;
         if(targetObject != null)
         {
            _loc3_ = targetObject.isDeadHP() || _loc7_._markedForRemoval;
            if(lifeTime <= 0 || _loc3_)
            {
               if(_loc3_)
               {
                  lifeTime = 0;
               }
               damage = getAccumulatedDamage();
               targetObject.reduceHitPoints(cumulativeDamageObject);
               if(player != null)
               {
                  if(player.rewardsHandler)
                  {
                     player.rewardsHandler.damageDoneToTarget(damage,targetObject);
                  }
                  else
                  {
                     var _loc8_:PlayerGameObject = player;
                     LogUtils.log("PlayerID: " + _loc8_._id + " rewards handler is null",this,2,"CumulativeDamage");
                  }
               }
               else
               {
                  LogUtils.log("player is null",this,2,"CumulativeDamage");
               }
               if(targetObject is AvatarGameObject)
               {
                  if(player && player != targetObject)
                  {
                     var _loc9_:PhysicsGameObject = targetObject;
                     player.addScoreFromDamage(_loc9_._id,damage);
                  }
                  else if(player && player == targetObject && damage > 0)
                  {
                     var _loc10_:PhysicsGameObject = targetObject;
                     player.reduceScoreFromDamage(_loc10_._id,damage);
                  }
                  _loc5_ = AvatarGameObject(targetObject);
                  if(damage > 0)
                  {
                     textEffect = world.addTextEffect(0,damage.toString(),_loc5_.container.x,_loc5_.container.y,false);
                     world.ignoreLevelSizeScale(textEffect.movieClip,true,false);
                  }
                  else if(damage < 0)
                  {
                     LogUtils.log("Cumulative damage is healing",this,2,"CumulativeDamage");
                     _loc6_ = Math.abs(damage).toString();
                     textEffect = world.addTextEffect(1,_loc6_,_loc5_.container.x,_loc5_.container.y,false);
                     world.ignoreLevelSizeScale(textEffect.movieClip,true,false);
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
         var _loc2_:Damage = new Damage(this,"C","-1",0,null,player);
         for each(var dam in _damageSources)
         {
            _loc2_.addDamage(dam.damageSourceClasses[0],dam.idsOfDamageWithDamage[0],dam.uniquesIdsOfDamage[0],dam.amount,dam.locations[0]);
         }
         return _loc2_;
      }
   }
}
