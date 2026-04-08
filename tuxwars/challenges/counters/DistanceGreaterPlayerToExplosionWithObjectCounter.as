package tuxwars.challenges.counters
{
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class DistanceGreaterPlayerToExplosionWithObjectCounter extends Counter
   {
      public function DistanceGreaterPlayerToExplosionWithObjectCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc6_:* = undefined;
         var _loc2_:Vec2 = null;
         var _loc3_:Vec2 = null;
         var _loc4_:Vec2 = null;
         var _loc5_:* = param1.firingPlayer;
         if(playerId == _loc5_._id)
         {
            for each(_loc6_ in param1.affectedGameObjects)
            {
               if(!(_loc6_ is PlayerGameObject) || _loc7_._id != playerId)
               {
                  if(ChallengeParamReference.getAffectsObject(_loc6_,params))
                  {
                     _loc2_ = param1.emission.location;
                     _loc3_ = param1.firingPlayer.bodyLocation;
                     _loc4_ = _loc3_.sub(_loc2_);
                     if(_loc4_.length >= value)
                     {
                        updateValue(_loc4_.length - value);
                     }
                  }
               }
            }
         }
      }
   }
}

