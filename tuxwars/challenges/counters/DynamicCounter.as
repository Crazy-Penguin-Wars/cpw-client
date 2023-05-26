package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class DynamicCounter extends Counter
   {
       
      
      protected var targetId:String;
      
      public function DynamicCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
         var _loc6_:int = id.lastIndexOf("_") + 1;
         targetId = id.substring(_loc6_);
      }
      
      override public function toString() : String
      {
         return super.toString() + ", targetId: " + targetId;
      }
   }
}
