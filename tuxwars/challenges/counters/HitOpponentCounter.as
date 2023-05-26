package tuxwars.challenges.counters
{
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitOpponentCounter extends Counter
   {
       
      
      private const currentTargets:Object = {};
      
      private var lastValue:int;
      
      public function HitOpponentCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Boolean = false;
         var _loc4_:* = msg.firingPlayer;
         if(playerId == _loc4_._id)
         {
            _loc3_ = filterPlayers(msg.affectedPlayers,msg);
            updateExisitingPlayers(_loc3_);
            addNewPlayers(_loc3_);
            if(value != lastValue)
            {
               _loc2_ = completed;
               LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
               var _loc5_:ChallengeManager = ChallengeManager;
               if(!tuxwars.challenges.ChallengeManager._instance)
               {
                  tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
               }
               tuxwars.challenges.ChallengeManager._instance.sendCounterUpdate(new CounterUpdate(playerId,this,value),true);
               lastValue = value;
               if(_loc2_ != completed)
               {
                  challenge.notifyCounterStateChanged();
               }
            }
         }
      }
      
      override public function get value() : int
      {
         return getHighestHitCount();
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         LogUtils.addDebugLine("Challenges","Reset counter: " + id);
         DCUtils.deleteProperties(currentTargets);
         if(_loc1_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      protected function filterPlayers(players:Vector.<PlayerGameObject>, msg:ChallengeAmmoHitMessage) : Vector.<PlayerGameObject>
      {
         return players;
      }
      
      private function addNewPlayers(players:Vector.<PlayerGameObject>) : void
      {
         for each(var player in players)
         {
            var _loc3_:* = player;
            if(!currentTargets.hasOwnProperty(_loc3_._id))
            {
               var _loc4_:* = player;
               currentTargets[_loc4_._id] = 1;
               var _loc5_:* = player;
               LogUtils.addDebugLine("Challenges",toString() + ": Added player id: " + _loc5_._id,this);
            }
         }
      }
      
      private function updateExisitingPlayers(players:Vector.<PlayerGameObject>) : void
      {
         var _loc3_:* = null;
         for(var id in currentTargets)
         {
            _loc3_ = DCUtils.find(players,"id",id);
            if(_loc3_)
            {
               var _loc4_:* = id;
               var _loc5_:* = currentTargets[_loc4_] + 1;
               currentTargets[_loc4_] = _loc5_;
               var _loc6_:* = _loc3_;
               LogUtils.addDebugLine("Challenges",toString() + ": Increasing value for player id: " + _loc6_._id + " value: " + currentTargets[id],this);
            }
            else
            {
               delete currentTargets[id];
               LogUtils.addDebugLine("Challenges",toString() + ": Removed player id: " + id,this);
            }
         }
      }
      
      private function getHighestHitCount() : int
      {
         var highest:* = 0;
         for each(var value in currentTargets)
         {
            if(value > highest)
            {
               highest = value;
            }
         }
         return highest;
      }
   }
}
