package tuxwars.battle.data.follower
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.emitters.EmitterUtils;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.FollowerDef;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.world.PhysicsWorld;
   
   public class Followers
   {
      
      private static const FOLLOWER_TABLE:String = "Follower";
      
      private static const FOLLOWER_CACHE:Object = {};
      
      private static var followersTable:Table;
       
      
      public function Followers()
      {
         super();
         throw new Error("Followers is a static class!");
      }
      
      public static function createFollower(name:String, loc:Vec2, world:PhysicsWorld, firingObjectsAttack:Stat, firingObjectsPlayerBoosterStats:Stats, objectToFollow:PhysicsGameObject, tagger:Tagger) : Follower
      {
         var _loc10_:* = undefined;
         var _loc13_:* = null;
         assert("Object to follow is not ",true,objectToFollow is PhysicsGameObject);
         if(!objectToFollow)
         {
            LogUtils.log("Followed object: " + objectToFollow.shortName + " is null",Followers,2,"Follower",false,false,false);
            return null;
         }
         if(!objectToFollow.body)
         {
            LogUtils.log("Followed object: " + objectToFollow.shortName + " has no body",Followers,2,"Follower",false,false,false);
            return null;
         }
         if(objectToFollow._hasHPs && objectToFollow.isDeadHP() || objectToFollow is PlayerGameObject && ((objectToFollow as PlayerGameObject).isDead() || (objectToFollow as PlayerGameObject).isSpawning()))
         {
            LogUtils.log("Followed object: " + objectToFollow.shortName + " is dead",Followers,2,"Follower",false,false,false);
            return null;
         }
         var _loc12_:FollowerData = getFollowerData(name);
         if(_loc12_.applyToObjects != null && !EmitterUtils.affectsObject(_loc12_.applyToObjects,!!tagger ? tagger.gameObject : null,objectToFollow))
         {
            if(!(objectToFollow is Follower) || _loc12_.applyToObjects != null && !EmitterUtils.affectsObject(_loc12_.applyToObjects,!!tagger ? tagger.gameObject : null,(objectToFollow as Follower).followedObject))
            {
               LogUtils.log("Followed object does not affect: " + (objectToFollow is Follower ? (objectToFollow as Follower).followedObject.shortName : objectToFollow.shortName),Followers,0,"Follower",false,false,false);
               return null;
            }
         }
         if(_loc12_.type == "Status" || _loc12_.type == "StatusPermanent")
         {
            _loc10_ = objectToFollow.followers;
            for each(var fo in _loc10_)
            {
               if((fo._type == "Status" || fo._type == "StatusPermanent") && _loc15_._id == _loc12_.id)
               {
                  LogUtils.log("Found matching status on object: " + objectToFollow.shortName,Followers,0,"Follower",false,false,false);
                  fo.resetLifeTime();
                  return null;
               }
            }
         }
         var _loc8_:FollowerDef = createFollowerDefFromData(_loc12_,loc,world,firingObjectsAttack);
         var _loc9_:Follower = world.createGameObject(_loc8_);
         _loc9_.init(objectToFollow,tagger);
         _loc9_.playerBoosterStats = firingObjectsPlayerBoosterStats;
         LogUtils.log("Created Follower: " + _loc9_.shortName + " who followes: " + objectToFollow.shortName,Followers,4,"Follower",true,false,false);
         if(_loc8_ && _loc8_.followers)
         {
            for each(var r in _loc8_.followers)
            {
               if(parentIsNotSameIdAsFollower(_loc9_,r.id))
               {
                  _loc13_ = createFollower(r.id,loc,world,firingObjectsAttack,firingObjectsPlayerBoosterStats,_loc9_,tagger);
               }
               else
               {
                  LogUtils.log("SubFollower is same as one of its parent Followers id: " + r.id,Followers,3,"Follower",true,true,true);
               }
            }
         }
         return _loc9_;
      }
      
      private static function parentIsNotSameIdAsFollower(followedObject:PhysicsGameObject, newFollowerID:String) : Boolean
      {
         if(followedObject is Follower)
         {
            if(parentIsNotSameIdAsFollower((followedObject as Follower).followedObjectReal,newFollowerID))
            {
               var _loc3_:* = followedObject;
               return _loc3_._id != newFollowerID;
            }
            return false;
         }
         return true;
      }
      
      private static function createFollowerDefFromData(followerData:FollowerData, loc:Vec2, world:PhysicsWorld, firingObjectsAttack:Stat) : FollowerDef
      {
         var _loc5_:FollowerDef = new FollowerDef(world.space);
         _loc5_.loadDataConf(followerData);
         _loc5_.position = loc.copy();
         _loc5_.playerAttackValue = !!firingObjectsAttack ? firingObjectsAttack.clone() : null;
         return _loc5_;
      }
      
      public static function getFollowersData(array:Array) : Vector.<FollowerData>
      {
         var _loc3_:Vector.<FollowerData> = new Vector.<FollowerData>();
         if(array)
         {
            for each(var r in array)
            {
               if(r is Row)
               {
                  _loc3_.push(getFollowerData(r.id));
               }
            }
         }
         return _loc3_;
      }
      
      private static function getFollowerData(name:String) : FollowerData
      {
         if(FOLLOWER_CACHE.hasOwnProperty(name))
         {
            return FOLLOWER_CACHE[name];
         }
         var _loc4_:* = name;
         var _loc3_:* = getTable();
         §§push(§§findproperty(FollowerData));
         if(!_loc3_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc4_] = _loc5_;
         }
         var _loc2_:FollowerData = new §§pop().FollowerData(_loc3_._cache[_loc4_]);
         FOLLOWER_CACHE[name] = _loc2_;
         return _loc2_;
      }
      
      private static function getTable() : Table
      {
         if(!followersTable)
         {
            var _loc1_:ProjectManager = ProjectManager;
            followersTable = com.dchoc.projectdata.ProjectManager.projectData.findTable("Follower");
         }
         return followersTable;
      }
   }
}
