package tuxwars.utils
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.Item;
   
   public class SyncChecker
   {
       
      
      public function SyncChecker()
      {
         super();
         throw new Error("SyncChecker is a static class!");
      }
      
      public static function check(serviceId:String, data:Object, game:TuxWarsGame) : void
      {
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var msg:String = "";
         if(data.level != game.player.level)
         {
            msg += "Player level mismatch! Client: " + game.player.level + " Server: " + data.level + "\n";
         }
         if(data.score != game.player.expValue)
         {
            msg += "Player exp mismatch! Client: " + game.player.expValue + " Server: " + data.score + "\n";
         }
         if(data.coins != game.player.ingameMoney)
         {
            msg += "Player coins mismatch! Client: " + game.player.ingameMoney + " Server: " + data.coins + "\n";
         }
         if(data.cash != game.player.premiumMoney)
         {
            msg += "Player cash mismatch! Client: " + game.player.premiumMoney + " Server: " + data.cash + "\n";
         }
         if(data.wornItems && data.wornItems.worn_item)
         {
            _loc6_ = data.wornItems.worn_item is Array ? data.wornItems.worn_item : [data.wornItems.worn_item];
            for each(var wornItem in _loc6_)
            {
               if(!game.player.wornItemsContainer.isWearingItem(wornItem.item_id))
               {
                  msg += "Player worm item mismatch! Server: " + wornItem.item_id + "\n";
               }
            }
         }
         if(data.allItems && data.allItems.item)
         {
            _loc8_ = data.allItems.item is Array ? data.allItems.item : [data.allItems.item];
            for each(var itemData in _loc8_)
            {
               _loc7_ = game.player.inventory.getItem(itemData.item_id,true);
               if(!_loc7_)
               {
                  msg += "Player doesn\'t have item: " + itemData.item_id + "\n";
               }
               else if(_loc7_.amount != itemData.amount)
               {
                  msg += "Player doesn\'t have same amount of: " + itemData.item_id + " Client: " + _loc7_.amount + " Server: " + itemData.amount + "\n";
               }
            }
         }
         if(msg != "")
         {
            msg += " ServiceId = " + serviceId;
            LogUtils.log(msg,"SyncChecker",3,"ErrorLogging",true,true,true);
         }
      }
   }
}
