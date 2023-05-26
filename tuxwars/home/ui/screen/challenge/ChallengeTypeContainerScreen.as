package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.data.challenges.ChallengesData;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.components.ObjectContainer;
   
   public class ChallengeTypeContainerScreen extends TuxUIElementScreen
   {
       
      
      private var _objectContainer:ObjectContainer;
      
      private var _challengeType:String;
      
      private var _activeChallenge:Challenge;
      
      private var _activeChallengeIndex:int;
      
      private var _sortedChallenges:Vector.<ChallengeData>;
      
      public function ChallengeTypeContainerScreen(design:MovieClip, game:TuxWarsGame, challengeType:String)
      {
         super(design,game);
         _challengeType = challengeType;
         _objectContainer = new ObjectContainer(design,game,getContainerButtonObject,"transition_challenges_down","transition_challenges_up",false);
      }
      
      public function init(activeChallenge:Challenge) : void
      {
         if(activeChallenge)
         {
            if(activeChallenge.type)
            {
               if(activeChallenge.type == _challengeType)
               {
                  _activeChallenge = activeChallenge;
                  _sortedChallenges = getSortedChallenges();
                  _activeChallengeIndex = _sortedChallenges.indexOf(ChallengesData.getChallengeData(_activeChallenge.id));
                  _objectContainer.init(_sortedChallenges,true,_activeChallengeIndex);
               }
               else
               {
                  LogUtils.log("Active challenge is not of type: " + _challengeType,this,2,"Challenges");
               }
            }
            else
            {
               LogUtils.log("Active challenge has no type",this,2,"Challenges");
            }
         }
         else
         {
            _sortedChallenges = getSortedChallenges();
            _objectContainer.init(_sortedChallenges);
         }
      }
      
      public function getContainerButtonObject(slotIndex:int, object:*, design:MovieClip) : *
      {
         var index:int = _sortedChallenges.indexOf(object as ChallengeData);
         var completed:Boolean = index < _activeChallengeIndex;
         return new ChallengeButtonContainers(slotIndex,object as ChallengeData,design,_activeChallenge,completed);
      }
      
      override public function dispose() : void
      {
         _objectContainer.dispose();
         _objectContainer = null;
         super.dispose();
      }
      
      private function getSortedChallenges() : Vector.<ChallengeData>
      {
         var _loc2_:Vector.<ChallengeData> = new Vector.<ChallengeData>();
         var _loc4_:ChallengeData = ChallengesData.findFirstChallengeOfType(_challengeType);
         if(!_loc4_)
         {
            LogUtils.log("Couldn\'t find first challenge for " + _challengeType,this,3,"Challenges",false,false,true);
            return _loc2_;
         }
         _loc2_.push(_loc4_);
         var nextChallenge:* = _loc4_;
         while(nextChallenge && nextChallenge.nextChallengeIds.length > 0)
         {
            for each(var id in nextChallenge.nextChallengeIds)
            {
               nextChallenge = ChallengesData.getChallengeData(id);
               if(nextChallenge.type == _loc4_.type)
               {
                  _loc2_.push(nextChallenge);
                  break;
               }
            }
         }
         return _loc2_;
      }
      
      public function get challengeType() : String
      {
         return _challengeType;
      }
   }
}
