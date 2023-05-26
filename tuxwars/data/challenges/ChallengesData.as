package tuxwars.data.challenges
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.LogUtils;
   import tuxwars.data.Tuner;
   
   public class ChallengesData
   {
      
      private static const TABLE:String = "Challenge";
      
      private static const TYPE:String = "Type";
      
      private static const CACHE:Object = {};
      
      private static var table:Table;
       
      
      public function ChallengesData()
      {
         super();
         throw new Error("ChallengesData is a static class!");
      }
      
      public static function getChallengeData(id:String) : ChallengeData
      {
         var _loc2_:* = null;
         if(!CACHE.hasOwnProperty(id))
         {
            var _loc4_:* = id;
            var _loc3_:* = getTable();
            if(!_loc3_._cache[_loc4_])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
               }
               _loc3_._cache[_loc4_] = _loc5_;
            }
            _loc2_ = _loc3_._cache[_loc4_];
            if(_loc2_)
            {
               CACHE[id] = new ChallengeData(_loc2_);
            }
            else
            {
               LogUtils.log("ChallengeData for id: " + id + " not found!","ChallengesData",3,"ChallengeData",false,false,true);
            }
         }
         return CACHE[id];
      }
      
      public static function findChallengesOfType(type:String) : Vector.<ChallengeData>
      {
         var _loc3_:* = null;
         var _loc2_:Vector.<ChallengeData> = new Vector.<ChallengeData>();
         var _loc5_:* = getTable();
         for each(var row in _loc5_._rows)
         {
            _loc3_ = new ChallengeData(row);
            if(_loc3_.type == type)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function findFirstChallengeOfType(type:String) : ChallengeData
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc6_:Tuner = Tuner;
         var _loc11_:Field = tuxwars.data.Tuner.getField("FirstChallenges");
         for each(var firstChallengeId in !!_loc11_ ? _loc11_.value : [])
         {
            _loc5_ = getChallengeData(firstChallengeId);
            if(_loc5_.type == type)
            {
               return _loc5_;
            }
            for each(var id in _loc5_.nextChallengeIds)
            {
               _loc3_ = findTypeFrom(getChallengeData(id),type);
               if(_loc3_)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public static function findIndex(challenge:ChallengeData) : int
      {
         var _loc4_:Vector.<ChallengeData> = findChallengesOfType(challenge.type);
         var index:int = 1;
         var previousChallenge:ChallengeData = findPreviousChallenge(challenge.id,_loc4_);
         while(previousChallenge != null)
         {
            index++;
            previousChallenge = findPreviousChallenge(previousChallenge.id,_loc4_);
         }
         return index;
      }
      
      public static function getTable() : Table
      {
         if(!table)
         {
            var _loc1_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable("Challenge");
         }
         return table;
      }
      
      private static function findPreviousChallenge(id:String, challenges:Vector.<ChallengeData>) : ChallengeData
      {
         for each(var challenge in challenges)
         {
            if(challenge.nextChallengeIds.indexOf(id) != -1)
            {
               return challenge;
            }
         }
         return null;
      }
      
      private static function findTypeFrom(challengeData:ChallengeData, type:String) : ChallengeData
      {
         var _loc4_:* = null;
         if(challengeData.type == type)
         {
            return challengeData;
         }
         for each(var id in challengeData.nextChallengeIds)
         {
            _loc4_ = findTypeFrom(getChallengeData(id),type);
            if(_loc4_)
            {
               return _loc4_;
            }
         }
         return null;
      }
   }
}
