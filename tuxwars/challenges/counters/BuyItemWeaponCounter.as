package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.events.ChallengeItemBoughtMessage;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   
   public class BuyItemWeaponCounter extends Counter
   {
      public function BuyItemWeaponCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:*)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleItemBought(param1:ChallengeItemBoughtMessage) : void
      {
         var _loc2_:ItemData = null;
         if(playerId == param1.playerId)
         {
            _loc2_ = ItemManager.getItemData(param1.itemId);
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
               LogUtils.log(toString() + " item " + param1.itemId + " does not exist",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}

