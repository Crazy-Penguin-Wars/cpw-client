package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class KillsByDamageIdsCounter extends KillsCounter
   {
      public function KillsByDamageIdsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handlePlayerDied(param1:ChallengePlayerDiedMessage) : void
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc2_:Damage = null;
         var _loc3_:Array = null;
         var _loc4_:PlayerGameObject = param1.player;
         var _loc5_:Tagger = _loc4_.tag.findLatestPlayerTagger();
         var _loc6_:* = _loc4_;
         if(playerId != _loc6_._id)
         {
            if(_loc5_)
            {
               if(Boolean(_loc5_.gameObject) && _loc8_._id == playerId)
               {
                  if(params)
                  {
                     _loc2_ = _loc4_.stats.getStat("HP").getLastModifier(Damage) as Damage;
                     _loc3_ = DeathsByDamageIdCounter.cleanID(_loc2_);
                     if(_loc3_ != null)
                     {
                        for each(_loc7_ in _loc3_)
                        {
                           if(params.damageIDs.indexOf(_loc7_) != -1)
                           {
                              super.handlePlayerDied(param1);
                              return;
                           }
                        }
                        _loc8_ = _loc4_;
                        LogUtils.log(toString() + " Player: " + _loc8_._id + " did not die from " + params.damageIDs.toString() + " damage. (DieFrom: " + _loc3_.toString() + ")",this,0,"Challenges",false,false,false);
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

