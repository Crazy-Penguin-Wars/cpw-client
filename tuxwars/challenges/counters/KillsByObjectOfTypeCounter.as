package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsByObjectOfTypeCounter extends KillsCounter
   {
       
      
      public function KillsByObjectOfTypeCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         var _loc5_:* = null;
         var _loc4_:PlayerGameObject = msg.player;
         var _loc2_:Tagger = _loc4_.tag.findLatestPlayerTagger();
         var _loc6_:* = _loc4_;
         if(playerId != _loc6_._id)
         {
            if(_loc2_)
            {
               if(_loc2_.gameObject && _loc7_._id == playerId)
               {
                  _loc5_ = _loc4_.stats.getStat("HP").getLastModifier(Damage) as Damage;
                  if(_loc5_)
                  {
                     if(_loc5_.damageSourceClasses != null && _loc5_.damageSourceClasses.length > 0)
                     {
                        for each(var klass in _loc5_.damageSourceClasses)
                        {
                           if(ChallengeParamReference.getAffectsObject(klass,params))
                           {
                              super.handlePlayerDied(msg);
                              return;
                           }
                        }
                     }
                     else
                     {
                        LogUtils.log("Last damage has no sources",this,0,"Challenges",false,false,false);
                     }
                  }
                  else
                  {
                     LogUtils.log("No last damage found!",this,0,"Challenges",false,false,false);
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
