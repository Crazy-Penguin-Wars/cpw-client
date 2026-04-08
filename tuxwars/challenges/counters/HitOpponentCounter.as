package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitOpponentCounter extends Counter
   {
      private const currentTargets:Object = {};
      
      private var lastValue:int;
      
      public function HitOpponentCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Boolean = false;
         var _loc4_:* = param1.firingPlayer;
         if(playerId == _loc4_._id)
         {
            _loc2_ = this.filterPlayers(param1.affectedPlayers,param1);
            this.updateExisitingPlayers(_loc2_);
            this.addNewPlayers(_loc2_);
            if(this.value != this.lastValue)
            {
               _loc3_ = completed;
               LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
               if(!ChallengeManager.instance)
               {
                  ChallengeManager.instance = new ChallengeManager();
               }
               ChallengeManager.instance.sendCounterUpdate(new CounterUpdate(playerId,this,this.value),true);
               this.lastValue = this.value;
               if(_loc3_ != completed)
               {
                  challenge.notifyCounterStateChanged();
               }
            }
         }
      }
      
      override public function get value() : int
      {
         return this.getHighestHitCount();
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         LogUtils.addDebugLine("Challenges","Reset counter: " + id);
         DCUtils.deleteProperties(this.currentTargets);
         if(_loc1_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      protected function filterPlayers(param1:Vector.<PlayerGameObject>, param2:ChallengeAmmoHitMessage) : Vector.<PlayerGameObject>
      {
         return param1;
      }
      
      private function addNewPlayers(param1:Vector.<PlayerGameObject>) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_;
            if(!this.currentTargets.hasOwnProperty(_loc3_._id))
            {
               _loc4_ = _loc2_;
               this.currentTargets[_loc4_._id] = 1;
               _loc5_ = _loc2_;
               LogUtils.addDebugLine("Challenges",toString() + ": Added player id: " + _loc5_._id,this);
            }
         }
      }
      
      private function updateExisitingPlayers(param1:Vector.<PlayerGameObject>) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:PlayerGameObject = null;
         for(_loc3_ in this.currentTargets)
         {
            _loc2_ = DCUtils.find(param1,"id",_loc3_);
            if(_loc2_)
            {
               _loc4_ = _loc3_;
               _loc5_ = this.currentTargets[_loc4_] + 1;
               this.currentTargets[_loc4_] = _loc5_;
               _loc6_ = _loc2_;
               LogUtils.addDebugLine("Challenges",toString() + ": Increasing value for player id: " + _loc6_._id + " value: " + this.currentTargets[_loc3_],this);
            }
            else
            {
               delete this.currentTargets[_loc3_];
               LogUtils.addDebugLine("Challenges",toString() + ": Removed player id: " + _loc3_,this);
            }
         }
      }
      
      private function getHighestHitCount() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:* = 0;
         for each(_loc2_ in this.currentTargets)
         {
            if(_loc2_ > _loc1_)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
   }
}

