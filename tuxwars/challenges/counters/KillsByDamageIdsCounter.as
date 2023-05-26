package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsByDamageIdsCounter extends KillsCounter
   {
       
      
      public function KillsByDamageIdsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc5_:PlayerGameObject = msg.player;
         var _loc4_:Tagger = _loc5_.tag.findLatestPlayerTagger();
         var _loc7_:* = _loc5_;
         if(playerId != _loc7_._id)
         {
            if(_loc4_)
            {
               if(_loc4_.gameObject && _loc8_._id == playerId)
               {
                  if(params)
                  {
                     _loc3_ = _loc5_.stats.getStat("HP").getLastModifier(Damage) as Damage;
                     _loc6_ = DeathsByDamageIdCounter.cleanID(_loc3_);
                     if(_loc6_ != null)
                     {
                        for each(var id in _loc6_)
                        {
                           if(params.damageIDs.indexOf(id) != -1)
                           {
                              super.handlePlayerDied(msg);
                              return;
                           }
                        }
                        var _loc11_:* = _loc5_;
                        LogUtils.log(toString() + " Player: " + _loc11_._id + " did not die from " + params.damageIDs.toString() + " damage. (DieFrom: " + _loc6_.toString() + ")",this,0,"Challenges",false,false,false);
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
         }
      }
   }
}
