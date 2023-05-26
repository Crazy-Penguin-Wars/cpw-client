package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsByDamageIdAndTaggedCounter extends KillsCounter
   {
       
      
      public function KillsByDamageIdAndTaggedCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         var lastHpStatModifier:* = null;
         var cleanedIds:* = null;
         var _loc5_:PlayerGameObject = msg.player;
         var _loc4_:Tagger = _loc5_.tag.findLatestPlayerTagger();
         var _loc7_:* = _loc5_;
         if(playerId != _loc7_._id)
         {
            if(_loc4_ && _loc8_._id == _loc9_._id)
            {
               if(_loc5_.tag.hasPlayerIDInTag(playerId,_loc4_))
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
                              super.handlePlayerDied(msg);
                              return;
                           }
                        }
                        var _loc12_:* = _loc5_;
                        LogUtils.log(toString() + " Player: " + _loc12_._id + " did not die from " + params.damageIDs.toString() + " damage. (DieFrom: " + cleanedIds.toString() + ")",this,0,"Challenges",false,false,false);
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
                  LogUtils.log(toString() + " deadPlayer does not have the players tag as the second one",this,0,"Challenges",false,false,false);
               }
            }
            else
            {
               LogUtils.log(toString() + " deadPlayer had not tagged himself as the last thing that killed him",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}
