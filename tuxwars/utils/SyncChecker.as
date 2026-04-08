package tuxwars.utils
{
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.Item;
   
   public class SyncChecker
   {
      public function SyncChecker()
      {
         super();
         throw new Error("SyncChecker is a static class!");
      }
      
      public static function check(param1:String, param2:Object, param3:TuxWarsGame) : void
      {
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Item = null;
         var _loc7_:String = "";
         if(param2.level != param3.player.level)
         {
            _loc7_ += "Player level mismatch! Client: " + param3.player.level + " Server: " + param2.level + "\n";
         }
         if(param2.score != param3.player.expValue)
         {
            _loc7_ += "Player exp mismatch! Client: " + param3.player.expValue + " Server: " + param2.score + "\n";
         }
         if(param2.coins != param3.player.ingameMoney)
         {
            _loc7_ += "Player coins mismatch! Client: " + param3.player.ingameMoney + " Server: " + param2.coins + "\n";
         }
         if(param2.cash != param3.player.premiumMoney)
         {
            _loc7_ += "Player cash mismatch! Client: " + param3.player.premiumMoney + " Server: " + param2.cash + "\n";
         }
         if(Boolean(param2.wornItems) && Boolean(param2.wornItems.worn_item))
         {
            _loc4_ = param2.wornItems.worn_item is Array ? param2.wornItems.worn_item : [param2.wornItems.worn_item];
            for each(_loc8_ in _loc4_)
            {
               if(!param3.player.wornItemsContainer.isWearingItem(_loc8_.item_id))
               {
                  _loc7_ += "Player worm item mismatch! Server: " + _loc8_.item_id + "\n";
               }
            }
         }
         if(Boolean(param2.allItems) && Boolean(param2.allItems.item))
         {
            _loc5_ = param2.allItems.item is Array ? param2.allItems.item : [param2.allItems.item];
            for each(_loc9_ in _loc5_)
            {
               _loc6_ = param3.player.inventory.getItem(_loc9_.item_id,true);
               if(!_loc6_)
               {
                  _loc7_ += "Player doesn\'t have item: " + _loc9_.item_id + "\n";
               }
               else if(_loc6_.amount != _loc9_.amount)
               {
                  _loc7_ += "Player doesn\'t have same amount of: " + _loc9_.item_id + " Client: " + _loc6_.amount + " Server: " + _loc9_.amount + "\n";
               }
            }
         }
         if(_loc7_ != "")
         {
            _loc7_ += " ServiceId = " + param1;
            LogUtils.log(_loc7_,"SyncChecker",3,"ErrorLogging",true,true,true);
         }
      }
   }
}

