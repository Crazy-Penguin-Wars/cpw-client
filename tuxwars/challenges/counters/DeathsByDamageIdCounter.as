package tuxwars.challenges.counters
{
   import com.adobe.utils.StringUtil;
   import com.dchoc.gameobjects.stats.modifier.StatModifier;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.Damage;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class DeathsByDamageIdCounter extends Counter
   {
       
      
      public function DeathsByDamageIdCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      public static function cleanID(statModifier:StatModifier) : Array
      {
         var b:* = null;
         var i:int = 0;
         var index:int = 0;
         if(statModifier)
         {
            b = statModifier.getId().split(",");
            for(i = 0; i < b.length; )
            {
               index = int(b[i].indexOf("("));
               if(index > -1)
               {
                  b[i] = StringUtil.trim(b[i].substring(0,index));
               }
               i++;
            }
            return b;
         }
         return null;
      }
      
      override public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         var lastHpStatModifier:* = null;
         var cleanedIds:* = null;
         var _loc6_:* = msg.player;
         if(_loc6_._id == playerId)
         {
            if(params)
            {
               if(msg.player.tag != null && msg.player.tag.findLatestPlayerTagger() != null && _loc7_._id != playerId)
               {
                  lastHpStatModifier = msg.player.stats.getStat("HP").getLastModifier(Damage) as Damage;
                  cleanedIds = cleanID(lastHpStatModifier);
                  if(cleanedIds != null)
                  {
                     for each(var id in cleanedIds)
                     {
                        for each(var paramsDefinedId in params.damageIDs)
                        {
                           if(id == paramsDefinedId)
                           {
                              updateValue(1);
                              return;
                           }
                        }
                     }
                     var _loc12_:* = msg.player;
                     LogUtils.log(toString() + " Player: " + _loc12_._id + " did not die from " + params.toString() + " damage. (DieFrom:" + cleanedIds.toString() + ")",this,0,"Challenges",false,false,false);
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
