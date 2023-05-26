package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class UseDifferentWeaponCounter extends Counter
   {
       
      
      private const weaponsUsed:Vector.<String> = new Vector.<String>();
      
      private var invalidated:Boolean;
      
      public function UseDifferentWeaponCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         super.reset();
         invalidated = false;
         if(_loc1_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function get value() : int
      {
         return invalidated ? 0 : super.value;
      }
      
      override public function handleWeaponUsed(msg:ChallengeWeaponUsedMessage) : void
      {
         if(invalidated)
         {
            return;
         }
         var _loc2_:* = msg.weapon.player;
         if(_loc2_._id == playerId)
         {
            if(weaponsUsed.indexOf(msg.weapon.id) == -1)
            {
               weaponsUsed.push(msg.weapon.id);
               updateValue(1);
            }
            else
            {
               LogUtils.addDebugLine("Challenges",toString() + " Invalidated because of weaponID: " + msg.weapon.id + " is in used list: " + weaponsUsed.toString(),this);
               invalidated = true;
               challenge.notifyCounterStateChanged();
            }
         }
      }
   }
}
