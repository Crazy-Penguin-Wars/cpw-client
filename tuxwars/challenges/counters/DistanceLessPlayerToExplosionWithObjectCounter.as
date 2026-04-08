package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class DistanceLessPlayerToExplosionWithObjectCounter extends CounterLessThan
   {
      public function DistanceLessPlayerToExplosionWithObjectCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function updateValue(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(param1 != 0)
         {
            _loc3_ = completed;
            value = param1;
            LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.sendCounterUpdate(new CounterUpdate(playerId,this,param1),param2);
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
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:Vec2 = null;
         var _loc3_:Vec2 = null;
         var _loc4_:Vec2 = null;
         var _loc5_:* = param1.firingPlayer;
         if(playerId == _loc5_._id)
         {
            for each(_loc6_ in param1.affectedGameObjects)
            {
               _loc7_ = _loc6_;
               if(_loc7_._id != playerId)
               {
                  if(ChallengeParamReference.getAffectsObject(_loc6_,params))
                  {
                     _loc2_ = param1.emission.location;
                     _loc3_ = param1.firingPlayer.bodyLocation;
                     _loc4_ = _loc3_.sub(_loc2_);
                     if(_loc4_.length < value)
                     {
                        this.updateValue(_loc4_.length);
                     }
                  }
               }
            }
         }
      }
   }
}

