package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class DistanceLessPlayerAndObjectInExplosionCounter extends CounterLessThan
   {
       
      
      public function DistanceLessPlayerAndObjectInExplosionCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override protected function updateValue(amount:int, sendInBattleUpdate:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(amount < value - 1)
         {
            _loc3_ = completed;
            value = amount;
            LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
            var _loc4_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.sendCounterUpdate(new CounterUpdate(playerId,this,amount),sendInBattleUpdate);
            if(Config.debugMode && completed)
            {
               LogUtils.log(toString() + " Completed!",this,1,"Challenges",false,false,false);
            }
            if(_loc3_ != completed)
            {
               challenge.notifyCounterStateChanged();
            }
         }
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
               var _loc7_:* = target;
               if(_loc7_._id != playerId)
               {
                  if(ChallengeParamReference.getAffectsObject(target,params))
                  {
                     _loc4_ = target.bodyLocation;
                     _loc5_ = msg.firingPlayer.bodyLocation;
                     _loc2_ = _loc5_.sub(_loc4_);
                     if(_loc2_.length < value)
                     {
                        updateValue(_loc2_.length);
                     }
                  }
               }
            }
            var _loc10_:* = msg.firingPlayer;
            LogUtils.log(toString() + " player not in explosion " + _loc10_._id,this,0,"Challenges",false,false,false);
         }
      }
   }
}
