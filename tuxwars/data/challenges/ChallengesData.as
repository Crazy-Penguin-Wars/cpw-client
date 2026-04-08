package tuxwars.data.challenges
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.data.*;
   
   public class ChallengesData
   {
      private static var table:Table;
      
      private static const TABLE:String = "Challenge";
      
      private static const TYPE:String = "Type";
      
      private static const CACHE:Object = {};
      
      public function ChallengesData()
      {
         super();
         throw new Error("ChallengesData is a static class!");
      }
      
      public static function getChallengeData(param1:String) : ChallengeData
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:Row = null;
         var _loc2_:Row = null;
         if(!CACHE.hasOwnProperty(param1))
         {
            _loc3_ = param1;
            _loc4_ = getTable();
            if(!_loc4_.getCache[_loc3_])
            {
               _loc5_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
               if(!_loc5_)
               {
                  LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
               }
               _loc4_.getCache[_loc3_] = _loc5_;
            }
            _loc2_ = _loc4_.getCache[_loc3_];
            if(_loc2_)
            {
               CACHE[param1] = new ChallengeData(_loc2_);
            }
            else
            {
               LogUtils.log("ChallengeData for id: " + param1 + " not found!","ChallengesData",3,"ChallengeData",false,false,true);
            }
         }
         return CACHE[param1];
      }
      
      public static function findChallengesOfType(param1:String) : Vector.<ChallengeData>
      {
         var _loc5_:* = undefined;
         var _loc2_:ChallengeData = null;
         var _loc3_:Vector.<ChallengeData> = new Vector.<ChallengeData>();
         var _loc4_:* = getTable();
         for each(_loc5_ in _loc4_._rows)
         {
            _loc2_ = new ChallengeData(_loc5_);
            if(_loc2_.type == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public static function findFirstChallengeOfType(param1:String) : ChallengeData
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:ChallengeData = null;
         var _loc3_:ChallengeData = null;
         var _loc4_:Field = Tuner.getField("FirstChallenges");
         for each(_loc5_ in !!_loc4_ ? _loc4_.overrideValue : [])
         {
            _loc2_ = getChallengeData(_loc5_);
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
            for each(_loc6_ in _loc2_.nextChallengeIds)
            {
               _loc3_ = findTypeFrom(getChallengeData(_loc6_),param1);
               if(_loc3_)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public static function findIndex(param1:ChallengeData) : int
      {
         var _loc2_:Vector.<ChallengeData> = findChallengesOfType(param1.type);
         var _loc3_:int = 1;
         var _loc4_:ChallengeData = findPreviousChallenge(param1.id,_loc2_);
         while(_loc4_ != null)
         {
            _loc3_++;
            _loc4_ = findPreviousChallenge(_loc4_.id,_loc2_);
         }
         return _loc3_;
      }
      
      public static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!table)
         {
            _loc1_ = "Challenge";
            table = ProjectManager.findTable(_loc1_);
         }
         return table;
      }
      
      private static function findPreviousChallenge(param1:String, param2:Vector.<ChallengeData>) : ChallengeData
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param2)
         {
            if(_loc3_.nextChallengeIds.indexOf(param1) != -1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private static function findTypeFrom(param1:ChallengeData, param2:String) : ChallengeData
      {
         var _loc4_:* = undefined;
         var _loc3_:ChallengeData = null;
         if(param1.type == param2)
         {
            return param1;
         }
         for each(_loc4_ in param1.nextChallengeIds)
         {
            _loc3_ = findTypeFrom(getChallengeData(_loc4_),param2);
            if(_loc3_)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

