package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.PowerUpGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   
   public class CollectedPowerUpsCounter extends Counter
   {
       
      
      public function CollectedPowerUpsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handlePhysicsObjectContact(msg:ChallengePhysicsObjectContactMessage) : void
      {
         var _loc3_:PlayerGameObject = msg.object as PlayerGameObject;
         var _loc2_:PowerUpGameObject = msg.objectHit as PowerUpGameObject;
         if(_loc3_ && _loc2_)
         {
            var _loc4_:* = _loc3_;
            if(_loc4_._id == playerId)
            {
               if(params == null || params.powerUpIDs == null || params.powerUpIDs && params.powerUpIDs.indexOf("all") != -1)
               {
                  updateValue(1);
                  return;
               }
               var _loc5_:* = _loc2_;
               if(params.powerUpIDs.indexOf(_loc5_._id) != -1)
               {
                  updateValue(1);
                  return;
               }
               var _loc6_:* = _loc2_;
               LogUtils.log(toString() + " Not updated because PowerUpID: " + _loc6_._id + " not found in params.",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}
