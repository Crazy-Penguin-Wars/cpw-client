package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsCounter extends Counter
   {
       
      
      public function KillsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         var _loc3_:PlayerGameObject = msg.player;
         var _loc2_:Tagger = _loc3_.tag.findLatestPlayerTagger();
         var _loc4_:* = _loc3_;
         if(playerId != _loc4_._id)
         {
            if(_loc2_)
            {
               if(_loc2_.gameObject && _loc5_._id == playerId)
               {
                  updateValue(1);
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
