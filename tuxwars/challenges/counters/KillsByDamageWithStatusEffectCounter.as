package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsByDamageWithStatusEffectCounter extends KillsCounter
   {
       
      
      public function KillsByDamageWithStatusEffectCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         var lastHpStatModifier:* = null;
         var cleanedIds:* = null;
         var _loc5_:PlayerGameObject = msg.player;
         var _loc4_:Tagger = _loc5_.tag.findLatestPlayerTagger();
         var _loc8_:* = _loc5_;
         if(playerId != _loc8_._id)
         {
            if(_loc4_)
            {
               if(_loc4_.gameObject && _loc9_._id == playerId)
               {
                  if(params)
                  {
                     lastHpStatModifier = _loc5_.stats.getStat("HP").getLastModifier(Damage) as Damage;
                     cleanedIds = DeathsByDamageIdCounter.cleanID(lastHpStatModifier);
                     if(cleanedIds != null)
                     {
                        for each(var id in cleanedIds)
                        {
                           if(params.damageIDs.indexOf(id) != -1)
                           {
                              for each(var followerId in _loc5_.followerIdsAtDeath)
                              {
                                 if(params.statusIDs.indexOf(followerId) != -1)
                                 {
                                    super.handlePlayerDied(msg);
                                    return;
                                 }
                              }
                           }
                        }
                        var _loc14_:* = _loc5_;
                        LogUtils.log(toString() + " Player: " + _loc14_._id + " params: " + params.toString() + " compared to: (" + _loc5_.followerIdsAtDeath.toString() + ") and (" + cleanedIds.toString() + ")",this,0,"Challenges",false,false,false);
                     }
                     else
                     {
                        LogUtils.log(toString() + " No damageIds",this,0,"Challenges",false,false,false);
                     }
                  }
                  else
                  {
                     LogUtils.log(toString() + " Params not difined correctly",this,0,"Challenges",false,false,false);
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
         else
         {
            LogUtils.log(toString() + " player is the deadPlayer",this,0,"Challenges",false,false,false);
         }
      }
   }
}
