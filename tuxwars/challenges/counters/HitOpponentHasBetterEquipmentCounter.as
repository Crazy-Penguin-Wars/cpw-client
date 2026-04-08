package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitOpponentHasBetterEquipmentCounter extends HitOpponentCounter
   {
      public function HitOpponentHasBetterEquipmentCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function filterPlayers(param1:Vector.<PlayerGameObject>, param2:ChallengeAmmoHitMessage) : Vector.<PlayerGameObject>
      {
         var _loc6_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:int = param2.firingPlayer.wornItemsContainer.calculateEquipmentValue();
         var _loc5_:Vector.<PlayerGameObject> = new Vector.<PlayerGameObject>();
         for each(_loc6_ in param1)
         {
            _loc3_ = int(_loc6_.wornItemsContainer.calculateEquipmentValue());
            if(_loc4_ + params.equipmentValueTreshold <= _loc3_)
            {
               _loc5_.push(_loc6_);
            }
            else
            {
               LogUtils.log("Players EQV: " + _loc4_ + " + treshold: " + params.equipmentValueTreshold + " is >= than the deadPlayers EQV: " + _loc3_,this,0,"Challenges",false,false,false);
            }
         }
         return _loc5_;
      }
   }
}

