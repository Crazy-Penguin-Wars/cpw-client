package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class ScoreHighestCounter extends Counter
   {
       
      
      public function ScoreHighestCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleEndGameConfirm(msg:ChallengeEndGameConfirm) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = msg.getPlayerWithHighestScore();
         if(_loc5_._id == playerId)
         {
            updateValue(1);
         }
         else
         {
            _loc3_ = msg.getPlayerWithHighestScore().getScore();
            for each(var player in msg.players)
            {
               var _loc6_:* = player;
               if(_loc6_._id == playerId)
               {
                  _loc4_ = player.getScore();
                  if(_loc4_ == _loc3_)
                  {
                     updateValue(1);
                  }
                  else if(_loc4_ > _loc3_)
                  {
                     updateValue(1);
                     LogUtils.log(toString() + " player had a higher score than the highest score, sort not work!!!",this,3,"Challenges",false,false,false);
                  }
                  else
                  {
                     LogUtils.log(toString() + " player did not have the highest score",this,0,"Challenges",false,false,false);
                  }
                  return;
               }
            }
         }
      }
   }
}
