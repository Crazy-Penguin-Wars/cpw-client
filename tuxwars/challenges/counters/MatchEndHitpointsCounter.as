package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class MatchEndHitpointsCounter extends Counter
   {
       
      
      public function MatchEndHitpointsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleEndGameConfirm(msg:ChallengeEndGameConfirm) : void
      {
         var hp:int = 0;
         for each(var player in msg.players)
         {
            var _loc4_:* = player;
            if(_loc4_._id == playerId)
            {
               hp = player.calculateHitPoints();
               if(hp >= targetValue)
               {
                  updateValue(hp);
               }
               else
               {
                  LogUtils.log(toString() + " players hiptoins less than target value",this,0,"Challenges",false,false,false);
               }
               return;
            }
         }
         LogUtils.log(toString() + " player not found",this,0,"Challenges",false,false,false);
      }
   }
}
