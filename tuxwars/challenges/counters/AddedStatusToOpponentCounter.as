package tuxwars.challenges.counters
{
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class AddedStatusToOpponentCounter extends Counter
   {
       
      
      public function AddedStatusToOpponentCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var emissionsFollowersDataToApply:* = undefined;
         var _loc6_:* = msg.firingPlayer;
         if(_loc6_._id == playerId)
         {
            if(params)
            {
               if(msg.emissionExplosionRef)
               {
                  emissionsFollowersDataToApply = msg.emissionReference.followers;
                  if(emissionsFollowersDataToApply)
                  {
                     for each(var targetStatusID in params.statusIDs)
                     {
                        for each(var row in emissionsFollowersDataToApply)
                        {
                           if(row && row.id == targetStatusID)
                           {
                              for each(var opponent in msg.affectedPlayers)
                              {
                                 var _loc7_:* = opponent;
                                 if(_loc7_._id != playerId && opponent.getFollower(targetStatusID) != null)
                                 {
                                    updateValue(1);
                                    return;
                                 }
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     LogUtils.log(toString() + " EmissionReference has no followers",this,0,"Challenges",false,false,false);
                  }
               }
               else
               {
                  LogUtils.log(toString() + "EmissionReference is null",this,0,"Challenges",false,false,false);
               }
            }
            else
            {
               LogUtils.log(toString() + " params null",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}
