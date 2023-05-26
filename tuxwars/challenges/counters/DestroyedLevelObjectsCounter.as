package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeLevelObjectDestroyed;
   
   public class DestroyedLevelObjectsCounter extends Counter
   {
       
      
      public function DestroyedLevelObjectsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleLevelObjectDestroyed(msg:ChallengeLevelObjectDestroyed) : void
      {
         var _loc2_:* = null;
         if(msg.levelObject)
         {
            _loc2_ = msg.levelObject.tag.findLatestPlayerTagger();
            if(_loc2_)
            {
               var _loc3_:* = _loc2_.gameObject;
               if(_loc3_._id == playerId)
               {
                  updateValue(1);
               }
            }
         }
      }
   }
}
