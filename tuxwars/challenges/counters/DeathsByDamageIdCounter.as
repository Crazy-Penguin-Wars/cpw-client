package tuxwars.challenges.counters
{
   import com.adobe.utils.*;
   import com.dchoc.gameobjects.stats.modifier.StatModifier;
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class DeathsByDamageIdCounter extends Counter
   {
      public function DeathsByDamageIdCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public static function cleanID(param1:StatModifier) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc2_ = param1.getId().split(",");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = int(_loc2_[_loc3_].indexOf("("));
               if(_loc4_ > -1)
               {
                  _loc2_[_loc3_] = StringUtil.trim(_loc2_[_loc3_].substring(0,_loc4_));
               }
               _loc3_++;
            }
            return _loc2_;
         }
         return null;
      }
      
      override public function handlePlayerDied(param1:ChallengePlayerDiedMessage) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:Damage = null;
         var _loc3_:Array = null;
         var _loc4_:* = param1.player;
         if(_loc4_._id == playerId)
         {
            if(params)
            {
               if(param1.player.tag != null && param1.player.tag.findLatestPlayerTagger() != null && _loc7_._id != playerId)
               {
                  _loc2_ = param1.player.stats.getStat("HP").getLastModifier(Damage) as Damage;
                  _loc3_ = cleanID(_loc2_);
                  if(_loc3_ != null)
                  {
                     for each(_loc5_ in _loc3_)
                     {
                        for each(_loc7_ in params.damageIDs)
                        {
                           if(_loc5_ == _loc7_)
                           {
                              updateValue(1);
                              return;
                           }
                        }
                     }
                     _loc6_ = param1.player;
                     LogUtils.log(toString() + " Player: " + _loc6_._id + " did not die from " + params.toString() + " damage. (DieFrom:" + _loc3_.toString() + ")",this,0,"Challenges",false,false,false);
                  }
                  else
                  {
                     LogUtils.log(toString() + " No damageIds",this,0,"Challenges",false,false,false);
                  }
               }
               else
               {
                  LogUtils.log(toString() + " Player not tagged by an other player.",this,0,"Challenges",false,false,false);
               }
            }
            else
            {
               LogUtils.log(toString() + " Params not difined correctly: " + params.toString(),this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}

