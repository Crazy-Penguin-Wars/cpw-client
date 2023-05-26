package tuxwars.challenges.counters
{
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class DistanceGreaterPlayerToExplosionWithObjectCounter extends Counter
   {
       
      
      public function DistanceGreaterPlayerToExplosionWithObjectCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc6_:* = msg.firingPlayer;
         if(playerId == _loc6_._id)
         {
            for each(var target in msg.affectedGameObjects)
            {
               if(!(target is PlayerGameObject) || _loc7_._id != playerId)
               {
                  if(ChallengeParamReference.getAffectsObject(target,params))
                  {
                     _loc4_ = msg.emission.location;
                     _loc5_ = msg.firingPlayer.bodyLocation;
                     _loc2_ = _loc5_.sub(_loc4_);
                     if(_loc2_.length >= value)
                     {
                        updateValue(_loc2_.length - value);
                     }
                  }
               }
            }
         }
      }
   }
}
