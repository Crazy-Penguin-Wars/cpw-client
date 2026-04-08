package tuxwars.challenges
{
   import com.dchoc.utils.*;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.data.challenges.*;
   
   public class Challenges
   {
      private const _activeChallenges:Vector.<Challenge> = new Vector.<Challenge>();
      
      private var playerId:String;
      
      private var _data:Object;
      
      private var localPlayer:Boolean;
      
      public function Challenges(param1:Object, param2:String, param3:Boolean)
      {
         super();
         this.playerId = param2;
         this.localPlayer = param3;
         this._data = param1;
         this.parseData(param1);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._activeChallenges)
         {
            _loc1_.dispose();
         }
         this._activeChallenges.splice(0,this._activeChallenges.length);
      }
      
      public function pause() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._activeChallenges)
         {
            _loc1_.pause();
         }
      }
      
      public function resume() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._activeChallenges)
         {
            _loc1_.resume();
         }
      }
      
      public function reset() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._activeChallenges)
         {
            if(_loc1_.isScopeBattle)
            {
               _loc1_.reset();
            }
         }
      }
      
      public function update(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Array = null;
         var _loc3_:Challenge = null;
         LogUtils.log("Updating challenges.","Challenges",1,"Challenges",true,false,true);
         this._data = param1;
         if(this._data.challenge)
         {
            _loc2_ = this._data.challenge is Array ? this._data.challenge : [this._data.challenge];
            for each(_loc4_ in _loc2_)
            {
               _loc3_ = this.findChallenge(_loc4_.challenge_id);
               if(_loc3_)
               {
                  LogUtils.log("Updating challenge " + _loc4_.challenge_id,"Challenges",1,"Challenges",true,false,true);
                  _loc3_.update(_loc4_);
               }
               else
               {
                  LogUtils.log("Creating new challenge " + _loc4_.challenge_id,"Challenges",1,"Challenges",true,false,true);
                  this.createChallenges([_loc4_]);
               }
            }
         }
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function get activeChallenges() : Vector.<Challenge>
      {
         return this._activeChallenges;
      }
      
      public function removeChallenge(param1:Challenge) : void
      {
         var _loc2_:int = int(this._activeChallenges.indexOf(param1));
         if(_loc2_ != -1)
         {
            LogUtils.log("Removed challenge " + param1.id,"Challenges",1,"Challenges",true,false,true);
            this._activeChallenges.splice(_loc2_,1);
         }
      }
      
      public function findChallenge(param1:String) : Challenge
      {
         return DCUtils.find(this._activeChallenges,"id",param1);
      }
      
      public function turnStarted() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._activeChallenges)
         {
            if(!_loc1_.completed)
            {
               _loc1_.turnStarted();
            }
         }
      }
      
      public function turnEnded(param1:PlayerTurnEndedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._activeChallenges)
         {
            if(!_loc2_.completed)
            {
               _loc2_.turnEnded(param1);
            }
         }
      }
      
      public function matchStarted() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._activeChallenges)
         {
            if(!_loc1_.completed)
            {
               _loc1_.matchStarted();
            }
         }
      }
      
      public function matchEnded(param1:MatchEndedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._activeChallenges)
         {
            if(!_loc2_.completed)
            {
               _loc2_.matchEnded(param1);
            }
         }
      }
      
      private function parseData(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:ChallengeData = null;
         var _loc3_:Challenge = null;
         if(param1)
         {
            if(param1.challenge)
            {
               this.createChallenges(param1.challenge is Array ? param1.challenge : [param1.challenge]);
            }
            else if(param1 is Array)
            {
               (param1 as Array).sort(this.sortData);
               for each(_loc4_ in param1)
               {
                  _loc2_ = ChallengesData.getChallengeData(_loc4_);
                  _loc3_ = new Challenge(_loc2_,this.playerId);
                  _loc3_.activate();
                  this._activeChallenges.push(_loc3_);
               }
               this.listActiveChallenges();
            }
         }
      }
      
      private function sortData(param1:String, param2:String) : int
      {
         return param1.localeCompare(param2);
      }
      
      private function sortDataObject(param1:Object, param2:Object) : int
      {
         return param1.challenge_id.localeCompare(param2.challenge_id);
      }
      
      private function listActiveChallenges() : void
      {
         var _loc1_:* = undefined;
         LogUtils.log("Sorted Active Challenges",this,0,"Challenges",false);
         for each(_loc1_ in this._activeChallenges)
         {
            LogUtils.log("playerID: " + _loc1_.playerId + " " + _loc1_.toString(),this,0,"Challenges",false);
         }
      }
      
      private function createChallenges(param1:Array) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:ChallengeData = null;
         var _loc3_:Challenge = null;
         param1.sort(this.sortDataObject);
         for each(_loc4_ in param1)
         {
            _loc2_ = ChallengesData.getChallengeData(_loc4_.challenge_id);
            _loc3_ = new Challenge(_loc2_,this.playerId);
            _loc3_.activate(_loc4_);
            this._activeChallenges.push(_loc3_);
         }
         this.listActiveChallenges();
      }
      
      private function sortByName(param1:Challenge, param2:Challenge) : int
      {
         var _loc3_:int = int(param1.playerId.localeCompare(param2.playerId));
         if(_loc3_ != 0)
         {
            return _loc3_;
         }
         return param1.id.localeCompare(param2.id);
      }
   }
}

