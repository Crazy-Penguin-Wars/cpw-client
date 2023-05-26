package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.events.ChallengeItemBoughtMessage;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   
   public class BuyItemWeaponCounter extends Counter
   {
       
      
      public function BuyItemWeaponCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:*)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleItemBought(msg:ChallengeItemBoughtMessage) : void
      {
         var _loc2_:* = null;
         if(playerId == msg.playerId)
         {
            _loc2_ = ItemManager.getItemData(msg.itemId);
            if(_loc2_)
            {
               if(_loc2_.type == "Weapon")
               {
                  updateValue(1,false);
               }
               else
               {
                  LogUtils.log(toString() + " item wrong type " + _loc2_.type,this,0,"Challenges",false,false,false);
               }
            }
            else
            {
               LogUtils.log(toString() + " item " + msg.itemId + " does not exist",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}
