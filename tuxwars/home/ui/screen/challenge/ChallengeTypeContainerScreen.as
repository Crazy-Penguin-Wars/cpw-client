package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   import tuxwars.data.challenges.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.components.*;
   
   public class ChallengeTypeContainerScreen extends TuxUIElementScreen
   {
      private var _objectContainer:ObjectContainer;
      
      private var _challengeType:String;
      
      private var _activeChallenge:Challenge;
      
      private var _activeChallengeIndex:int;
      
      private var _sortedChallenges:Vector.<ChallengeData>;
      
      public function ChallengeTypeContainerScreen(param1:MovieClip, param2:TuxWarsGame, param3:String)
      {
         super(param1,param2);
         this._challengeType = param3;
         this._objectContainer = new ObjectContainer(param1,param2,this.getContainerButtonObject,"transition_challenges_down","transition_challenges_up",false);
      }
      
      public function init(param1:Challenge) : void
      {
         if(param1)
         {
            if(param1.type)
            {
               if(param1.type == this._challengeType)
               {
                  this._activeChallenge = param1;
                  this._sortedChallenges = this.getSortedChallenges();
                  this._activeChallengeIndex = this._sortedChallenges.indexOf(ChallengesData.getChallengeData(this._activeChallenge.id));
                  this._objectContainer.init(this._sortedChallenges,true,this._activeChallengeIndex);
               }
               else
               {
                  LogUtils.log("Active challenge is not of type: " + this._challengeType,this,2,"Challenges");
               }
            }
            else
            {
               LogUtils.log("Active challenge has no type",this,2,"Challenges");
            }
         }
         else
         {
            this._sortedChallenges = this.getSortedChallenges();
            this._objectContainer.init(this._sortedChallenges);
         }
      }
      
      public function getContainerButtonObject(param1:int, param2:*, param3:MovieClip) : *
      {
         var _loc4_:int = int(this._sortedChallenges.indexOf(param2 as ChallengeData));
         var _loc5_:* = _loc4_ < this._activeChallengeIndex;
         return new ChallengeButtonContainers(param1,param2 as ChallengeData,param3,this._activeChallenge,_loc5_);
      }
      
      override public function dispose() : void
      {
         this._objectContainer.dispose();
         this._objectContainer = null;
         super.dispose();
      }
      
      private function getSortedChallenges() : Vector.<ChallengeData>
      {
         var _loc4_:* = undefined;
         var _loc1_:Vector.<ChallengeData> = new Vector.<ChallengeData>();
         var _loc2_:ChallengeData = ChallengesData.findFirstChallengeOfType(this._challengeType);
         if(!_loc2_)
         {
            LogUtils.log("Couldn\'t find first challenge for " + this._challengeType,this,3,"Challenges",false,false,true);
            return _loc1_;
         }
         _loc1_.push(_loc2_);
         var _loc3_:* = _loc2_;
         while(_loc3_ && _loc3_.nextChallengeIds.length > 0)
         {
            for each(_loc4_ in _loc3_.nextChallengeIds)
            {
               _loc3_ = ChallengesData.getChallengeData(_loc4_);
               if(_loc3_.type == _loc2_.type)
               {
                  _loc1_.push(_loc3_);
                  break;
               }
            }
         }
         return _loc1_;
      }
      
      public function get challengeType() : String
      {
         return this._challengeType;
      }
   }
}

