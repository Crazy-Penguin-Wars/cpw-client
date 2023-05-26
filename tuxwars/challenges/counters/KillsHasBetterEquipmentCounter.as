package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsHasBetterEquipmentCounter extends KillsCounter
   {
       
      
      public function KillsHasBetterEquipmentCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:PlayerGameObject = msg.player;
         var _loc7_:* = _loc5_;
         if(playerId != _loc7_._id)
         {
            _loc2_ = _loc5_.tag.findLatestPlayerTagger();
            if(_loc2_)
            {
               if(_loc2_.gameObject && _loc8_._id == playerId)
               {
                  _loc4_ = _loc2_.gameObject as PlayerGameObject;
                  _loc3_ = _loc4_.wornItemsContainer.calculateEquipmentValue();
                  _loc6_ = _loc5_.wornItemsContainer.calculateEquipmentValue();
                  if(_loc3_ + params.equipmentValueTreshold <= _loc6_)
                  {
                     updateValue(1);
                  }
                  else
                  {
                     LogUtils.log("Players EQV: " + _loc3_ + " + treshold: " + params.equipmentValueTreshold + " is >= than the deadPlayers EQV: " + _loc6_,this,0,"Challenges",false,false,false);
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
