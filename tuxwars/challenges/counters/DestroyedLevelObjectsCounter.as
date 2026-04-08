package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeLevelObjectDestroyed;
   
   public class DestroyedLevelObjectsCounter extends Counter
   {
      public function DestroyedLevelObjectsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleLevelObjectDestroyed(param1:ChallengeLevelObjectDestroyed) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Tagger = null;
         if(param1.levelObject)
         {
            _loc2_ = param1.levelObject.tag.findLatestPlayerTagger();
            if(_loc2_)
            {
               _loc3_ = _loc2_.gameObject;
               if(_loc3_._id == playerId)
               {
                  updateValue(1);
               }
            }
         }
      }
   }
}

