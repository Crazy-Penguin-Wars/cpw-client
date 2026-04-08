package tuxwars.challenges.counters
{
   import com.dchoc.projectdata.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class CounterLessThan extends Counter
   {
      public function CounterLessThan(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
         this.reset();
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
         var _loc1_:Boolean = false;
         _loc1_ = this.completed;
         value = targetValue + 1;
         if(_loc1_ != this.completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function getProgressString() : String
      {
         var _loc1_:String = ProjectManager.getText(this.completed ? "COMPLETE" : "INCOMPLETE");
         return ProjectManager.getText(id,[_loc1_]) + "\n";
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

