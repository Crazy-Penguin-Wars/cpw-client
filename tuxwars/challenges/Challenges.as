package tuxwars.challenges
{
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.data.challenges.ChallengesData;
   
   public class Challenges
   {
       
      
      private const _activeChallenges:Vector.<Challenge> = new Vector.<Challenge>();
      
      private var playerId:String;
      
      private var _data:Object;
      
      private var localPlayer:Boolean;
      
      public function Challenges(data:Object, playerId:String, localPlayer:Boolean)
      {
         super();
         this.playerId = playerId;
         this.localPlayer = localPlayer;
         _data = data;
         parseData(data);
      }
      
      public function dispose() : void
      {
         for each(var challenge in _activeChallenges)
         {
            challenge.dispose();
         }
         _activeChallenges.splice(0,_activeChallenges.length);
      }
      
      public function pause() : void
      {
         for each(var challenge in _activeChallenges)
         {
            challenge.pause();
         }
      }
      
      public function resume() : void
      {
         for each(var challenge in _activeChallenges)
         {
            challenge.resume();
         }
      }
      
      public function reset() : void
      {
         for each(var challenge in _activeChallenges)
         {
            if(challenge.isScopeBattle)
            {
               challenge.reset();
            }
         }
      }
      
      public function update(data:Object) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         LogUtils.log("Updating challenges.","Challenges",1,"Challenges",true,false,true);
         _data = data;
         if(_data.challenge)
         {
            _loc4_ = _data.challenge is Array ? _data.challenge : [_data.challenge];
            for each(var challengeData in _loc4_)
            {
               _loc2_ = findChallenge(challengeData.challenge_id);
               if(_loc2_)
               {
                  LogUtils.log("Updating challenge " + challengeData.challenge_id,"Challenges",1,"Challenges",true,false,true);
                  _loc2_.update(challengeData);
               }
               else
               {
                  LogUtils.log("Creating new challenge " + challengeData.challenge_id,"Challenges",1,"Challenges",true,false,true);
                  createChallenges([challengeData]);
               }
            }
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get activeChallenges() : Vector.<Challenge>
      {
         return _activeChallenges;
      }
      
      public function removeChallenge(challenge:Challenge) : void
      {
         var _loc2_:int = _activeChallenges.indexOf(challenge);
         if(_loc2_ != -1)
         {
            LogUtils.log("Removed challenge " + challenge.id,"Challenges",1,"Challenges",true,false,true);
            _activeChallenges.splice(_loc2_,1);
         }
      }
      
      public function findChallenge(id:String) : Challenge
      {
         return DCUtils.find(_activeChallenges,"id",id);
      }
      
      public function turnStarted() : void
      {
         for each(var challenge in _activeChallenges)
         {
            if(!challenge.completed)
            {
               challenge.turnStarted();
            }
         }
      }
      
      public function turnEnded(msg:PlayerTurnEndedMessage) : void
      {
         for each(var challenge in _activeChallenges)
         {
            if(!challenge.completed)
            {
               challenge.turnEnded(msg);
            }
         }
      }
      
      public function matchStarted() : void
      {
         for each(var challenge in _activeChallenges)
         {
            if(!challenge.completed)
            {
               challenge.matchStarted();
            }
         }
      }
      
      public function matchEnded(msg:MatchEndedMessage) : void
      {
         for each(var challenge in _activeChallenges)
         {
            if(!challenge.completed)
            {
               challenge.matchEnded(msg);
            }
         }
      }
      
      private function parseData(data:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(data)
         {
            if(data.challenge)
            {
               createChallenges(data.challenge is Array ? data.challenge : [data.challenge]);
            }
            else if(data is Array)
            {
               (data as Array).sort(sortData);
               for each(var id in data)
               {
                  _loc4_ = ChallengesData.getChallengeData(id);
                  _loc3_ = new Challenge(_loc4_,playerId);
                  _loc3_.activate();
                  _activeChallenges.push(_loc3_);
               }
               listActiveChallenges();
            }
         }
      }
      
      private function sortData(a:String, b:String) : int
      {
         return a.localeCompare(b);
      }
      
      private function sortDataObject(a:Object, b:Object) : int
      {
         return a.challenge_id.localeCompare(b.challenge_id);
      }
      
      private function listActiveChallenges() : void
      {
         LogUtils.log("Sorted Active Challenges",this,0,"Challenges",false);
         for each(var c in _activeChallenges)
         {
            LogUtils.log("playerID: " + c.playerId + " " + c.toString(),this,0,"Challenges",false);
         }
      }
      
      private function createChallenges(list:Array) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         list.sort(sortDataObject);
         for each(var obj in list)
         {
            _loc3_ = ChallengesData.getChallengeData(obj.challenge_id);
            _loc2_ = new Challenge(_loc3_,playerId);
            _loc2_.activate(obj);
            _activeChallenges.push(_loc2_);
         }
         listActiveChallenges();
      }
      
      private function sortByName(a:Challenge, b:Challenge) : int
      {
         var playerIDDifference:int = a.playerId.localeCompare(b.playerId);
         if(playerIDDifference != 0)
         {
            return playerIDDifference;
         }
         return a.id.localeCompare(b.id);
      }
   }
}
