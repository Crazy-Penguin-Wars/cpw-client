package tuxwars.trophys
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.data.challenges.ChallengesData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.TrophyData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.player.Player;
   
   public class TrophyManager
   {
      
      private static const CHALLENGE_TYPES:Array = ["Battle","Grind","Skill","Impossible"];
      
      private static const FIRST_CHALLENGES:Object = {};
      
      private static var initialized:Boolean = false;
       
      
      public function TrophyManager()
      {
         super();
         throw new Error("TrophyManager is a static class!");
      }
      
      public static function addTrophies(player:Player) : void
      {
         var _loc2_:* = null;
         var challengeData:* = null;
         var tempChallengeData:* = null;
         var hasTrophy:Boolean = false;
         if(!initialized)
         {
            for each(var type in CHALLENGE_TYPES)
            {
               _loc2_ = ChallengesData.findFirstChallengeOfType(type);
               if(_loc2_)
               {
                  FIRST_CHALLENGES[type] = _loc2_;
               }
            }
         }
         var _loc8_:Object = {};
         var _loc18_:int = 0;
         var _loc16_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         for each(var challenge in tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(player.id).activeChallenges)
         {
            _loc8_[challenge.type] = challenge;
         }
         var _loc13_:Vector.<ChallengeData> = new Vector.<ChallengeData>();
         for each(challengeData in FIRST_CHALLENGES)
         {
            if(_loc8_[challengeData.type] != null)
            {
               while(challengeData.id != Challenge(_loc8_[challengeData.type]).id)
               {
                  _loc13_.push(challengeData);
                  tempChallengeData = null;
                  for each(var nextId in challengeData.nextChallengeIds)
                  {
                     tempChallengeData = ChallengesData.getChallengeData(nextId);
                     if(tempChallengeData.type == challengeData.type)
                     {
                        challengeData = tempChallengeData;
                        break;
                     }
                  }
               }
            }
         }
         challengeData = null;
         var trophys:Vector.<ItemData> = ItemManager.findItemDatas("Trophy");
         for each(var tropyhData in trophys)
         {
            hasTrophy = true;
            for each(var challengeId in tropyhData.requiredChallenges)
            {
               challengeData = ChallengesData.getChallengeData(challengeId);
               if(_loc13_.indexOf(challengeData) == -1)
               {
                  hasTrophy = false;
                  break;
               }
            }
            if(hasTrophy && !player.inventory.getItem(tropyhData.id))
            {
               player.inventory.addItem(tropyhData.id);
            }
         }
      }
   }
}
