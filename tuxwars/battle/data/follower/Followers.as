package tuxwars.battle.data.follower
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.world.PhysicsWorld;
   
   public class Followers
   {
      private static var followersTable:Table;
      
      private static const FOLLOWERtable:String = "Follower";
      
      private static const FOLLOWER_CACHE:Object = {};
      
      public function Followers()
      {
         super();
         throw new Error("Followers is a static class!");
      }
      
      public static function createFollower(param1:String, param2:Vec2, param3:PhysicsWorld, param4:Stat, param5:Stats, param6:PhysicsGameObject, param7:Tagger) : Follower
      {
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:Follower = null;
         assert("Object to follow is not ",true,param6 is PhysicsGameObject);
         if(!param6)
         {
            LogUtils.log("Followed object: " + param6.shortName + " is null",Followers,2,"Follower",false,false,false);
            return null;
         }
         if(!param6.body)
         {
            LogUtils.log("Followed object: " + param6.shortName + " has no body",Followers,2,"Follower",false,false,false);
            return null;
         }
         if(param6._hasHPs && param6.isDeadHP() || param6 is PlayerGameObject && (Boolean((param6 as PlayerGameObject).isDead()) || Boolean((param6 as PlayerGameObject).isSpawning())))
         {
            LogUtils.log("Followed object: " + param6.shortName + " is dead",Followers,2,"Follower",false,false,false);
            return null;
         }
         var _loc10_:FollowerData = getFollowerData(param1);
         if(_loc10_.applyToObjects != null && !EmitterUtils.affectsObject(_loc10_.applyToObjects,!!param7 ? param7.gameObject : null,param6))
         {
            if(!(param6 is Follower) || _loc10_.applyToObjects != null && !EmitterUtils.affectsObject(_loc10_.applyToObjects,!!param7 ? param7.gameObject : null,(param6 as Follower).followedObject))
            {
               LogUtils.log("Followed object does not affect: " + (param6 is Follower ? (param6 as Follower).followedObject.shortName : param6.shortName),Followers,0,"Follower",false,false,false);
               return null;
            }
         }
         if(_loc10_.type == "Status" || _loc10_.type == "StatusPermanent")
         {
            _loc8_ = param6.followers;
            for each(_loc13_ in _loc8_)
            {
               if((_loc13_._type == "Status" || _loc13_._type == "StatusPermanent") && _loc15_._id == _loc10_.id)
               {
                  LogUtils.log("Found matching status on object: " + param6.shortName,Followers,0,"Follower",false,false,false);
                  _loc13_.resetLifeTime();
                  return null;
               }
            }
         }
         var _loc11_:FollowerDef = createFollowerDefFromData(_loc10_,param2,param3,param4);
         var _loc12_:Follower = param3.createGameObject(_loc11_);
         _loc12_.init(param6,param7);
         _loc12_.playerBoosterStats = param5;
         LogUtils.log("Created Follower: " + _loc12_.shortName + " who followes: " + param6.shortName,Followers,4,"Follower",true,false,false);
         if(Boolean(_loc11_) && Boolean(_loc11_.followers))
         {
            for each(_loc14_ in _loc11_.followers)
            {
               if(parentIsNotSameIdAsFollower(_loc12_,_loc14_.id))
               {
                  _loc9_ = createFollower(_loc14_.id,param2,param3,param4,param5,_loc12_,param7);
               }
               else
               {
                  LogUtils.log("SubFollower is same as one of its parent Followers id: " + _loc14_.id,Followers,3,"Follower",true,true,true);
               }
            }
         }
         return _loc12_;
      }
      
      private static function parentIsNotSameIdAsFollower(param1:PhysicsGameObject, param2:String) : Boolean
      {
         var _loc3_:* = undefined;
         if(param1 is Follower)
         {
            if(parentIsNotSameIdAsFollower((param1 as Follower).followedObjectReal,param2))
            {
               _loc3_ = param1;
               return _loc3_.id != param2;
            }
            return false;
         }
         return true;
      }
      
      private static function createFollowerDefFromData(param1:FollowerData, param2:Vec2, param3:PhysicsWorld, param4:Stat) : FollowerDef
      {
         var _loc5_:FollowerDef = new FollowerDef(param3.space);
         _loc5_.loadDataConf(param1);
         _loc5_.position = param2.copy();
         _loc5_.playerAttackValue = !!param4 ? param4.clone() : null;
         return _loc5_;
      }
      
      public static function getFollowersData(param1:Array) : Vector.<FollowerData>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<FollowerData> = new Vector.<FollowerData>();
         if(param1)
         {
            for each(_loc3_ in param1)
            {
               if(_loc3_ is Row)
               {
                  _loc2_.push(getFollowerData(_loc3_.id));
               }
            }
         }
         return _loc2_;
      }
      
      private static function getFollowerData(param1:String) : FollowerData
      {
         var _loc4_:Row = null;
         if(FOLLOWER_CACHE.hasOwnProperty(param1))
         {
            return FOLLOWER_CACHE[param1];
         }
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[param1])
         {
            _loc4_ = DCUtils.find(_loc2_.rows,"id",param1);
            if(!_loc4_)
            {
               LogUtils.log("No row with name: \'" + param1 + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[param1] = _loc4_;
         }
         var _loc3_:FollowerData = new FollowerData(_loc2_.getCache[param1]);
         FOLLOWER_CACHE[param1] = _loc3_;
         return _loc3_;
      }
      
      private static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!followersTable)
         {
            _loc1_ = "Follower";
            followersTable = ProjectManager.findTable(_loc1_);
         }
         return followersTable;
      }
   }
}

