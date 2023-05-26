package tuxwars.home.ui.screen.shop
{
   import com.dchoc.projectdata.Row;
   import tuxwars.items.BigShopItem;
   import tuxwars.items.ShopItem;
   
   public interface IShopLogic
   {
       
      
      function getCurrentTab() : Row;
      
      function getCurrentTabBigItems() : Vector.<BigShopItem>;
      
      function get tabSlotSize() : int;
      
      function getItems(param1:String, param2:Array = null, param3:Boolean = true) : Vector.<ShopItem>;
   }
}
