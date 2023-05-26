package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class DistanceGreaterPlayerAndObjectInExplosionCounter extends Counter
   {
       
      
      public function DistanceGreaterPlayerAndObjectInExplosionCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = msg.firingPlayer;
         if(playerId == _loc7_._id)
         {
            for each(var player in msg.affectedGameObjects)
            {
               var _loc8_:* = player;
               if(_loc8_._id == playerId)
               {
                  for each(var target in msg.affectedGameObjects)
                  {
                     if(!(target is PlayerGameObject) || _loc9_._id != playerId)
                     {
                        if(ChallengeParamReference.getAffectsObject(target,params))
                        {
                           _loc5_ = target.bodyLocation;
                           _loc6_ = msg.firingPlayer.bodyLocation;
                           _loc2_ = _loc6_.sub(_loc5_);
                           if(_loc2_.length >= value)
                           {
                              updateValue(_loc2_.length - value);
                           }
                        }
                     }
                  }
                  return;
               }
            }
            var _loc14_:* = msg.firingPlayer;
            LogUtils.log(toString() + " player not in explosion " + _loc14_._id,this,0,"Challenges",false,false,false);
         }
      }
   }
}
