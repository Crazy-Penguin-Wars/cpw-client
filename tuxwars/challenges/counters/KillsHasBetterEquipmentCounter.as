package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsHasBetterEquipmentCounter extends KillsCounter
   {
      public function KillsHasBetterEquipmentCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handlePlayerDied(param1:ChallengePlayerDiedMessage) : void
      {
         var _loc2_:Tagger = null;
         var _loc3_:PlayerGameObject = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:PlayerGameObject;
         var _loc7_:* = _loc6_ = param1.player;
         if(playerId != _loc7_._id)
         {
            _loc2_ = _loc6_.tag.findLatestPlayerTagger();
            if(_loc2_)
            {
               if(Boolean(_loc2_.gameObject) && _loc8_._id == playerId)
               {
                  _loc3_ = _loc2_.gameObject as PlayerGameObject;
                  _loc4_ = _loc3_.wornItemsContainer.calculateEquipmentValue();
                  _loc5_ = _loc6_.wornItemsContainer.calculateEquipmentValue();
                  if(_loc4_ + params.equipmentValueTreshold <= _loc5_)
                  {
                     updateValue(1);
                  }
                  else
                  {
                     LogUtils.log("Players EQV: " + _loc4_ + " + treshold: " + params.equipmentValueTreshold + " is >= than the deadPlayers EQV: " + _loc5_,this,0,"Challenges",false,false,false);
                  }
               }
               else
               {
                  LogUtils.log(toString() + " player was not the last to tag",this,0,"Challenges",false,false,false);
               }
            }
            else
            {
               LogUtils.log(toString() + " no last tagger",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}

