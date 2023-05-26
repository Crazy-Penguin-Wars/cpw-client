package tuxwars.challenges.counters
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class CounterLessThan extends Counter
   {
       
      
      public function CounterLessThan(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
         reset();
      }
      
      override public function calculateCompletionPercentage() : int
      {
         var _loc1_:int = value;
         var _loc2_:int = targetValue;
         if(_loc1_ <= _loc2_)
         {
            return 100;
         }
         return 0;
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         value = targetValue + 1;
         if(_loc1_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function getProgressString() : String
      {
         var result:String = ProjectManager.getText(completed ? "COMPLETE" : "INCOMPLETE");
         return ProjectManager.getText(id,[result]) + "\n";
      }
      
      override public function get completed() : Boolean
      {
         return value <= targetValue;
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return false;
      }
   }
}
