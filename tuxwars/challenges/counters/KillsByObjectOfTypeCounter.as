package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsByObjectOfTypeCounter extends KillsCounter
   {
      public function KillsByObjectOfTypeCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handlePlayerDied(param1:ChallengePlayerDiedMessage) : void
      {
         var _loc6_:* = undefined;
         var _loc2_:Damage = null;
         var _loc3_:PlayerGameObject = param1.player;
         var _loc4_:Tagger = _loc3_.tag.findLatestPlayerTagger();
         var _loc5_:* = _loc3_;
         if(playerId != _loc5_._id)
         {
            if(_loc4_)
            {
               if(Boolean(_loc4_.gameObject) && _loc7_._id == playerId)
               {
                  _loc2_ = _loc3_.stats.getStat("HP").getLastModifier(Damage) as Damage;
                  if(_loc2_)
                  {
                     if(_loc2_.damageSourceClasses != null && _loc2_.damageSourceClasses.length > 0)
                     {
                        for each(_loc6_ in _loc2_.damageSourceClasses)
                        {
                           if(ChallengeParamReference.getAffectsObject(_loc6_,params))
                           {
                              super.handlePlayerDied(param1);
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

