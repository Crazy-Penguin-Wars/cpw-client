package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class DynamicCounter extends Counter
   {
      protected var targetId:String;
      
      public function DynamicCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
         var _loc6_:int = param2.lastIndexOf("_") + 1;
         this.targetId = param2.substring(_loc6_);
      }
      
      override public function toString() : String
      {
         return super.toString() + ", targetId: " + this.targetId;
      }
   }
}

