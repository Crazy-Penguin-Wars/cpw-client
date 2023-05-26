package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitOpponentHasBetterEquipmentCounter extends HitOpponentCounter
   {
       
      
      public function HitOpponentHasBetterEquipmentCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override protected function filterPlayers(players:Vector.<PlayerGameObject>, msg:ChallengeAmmoHitMessage) : Vector.<PlayerGameObject>
      {
         var opponentEquipmentValue:int = 0;
         var _loc6_:int = msg.firingPlayer.wornItemsContainer.calculateEquipmentValue();
         var newPlayers:Vector.<PlayerGameObject> = new Vector.<PlayerGameObject>();
         for each(var opponent in players)
         {
            opponentEquipmentValue = opponent.wornItemsContainer.calculateEquipmentValue();
            if(_loc6_ + params.equipmentValueTreshold <= opponentEquipmentValue)
            {
               newPlayers.push(opponent);
            }
            else
            {
               LogUtils.log("Players EQV: " + _loc6_ + " + treshold: " + params.equipmentValueTreshold + " is >= than the deadPlayers EQV: " + opponentEquipmentValue,this,0,"Challenges",false,false,false);
            }
         }
         return newPlayers;
      }
   }
}
