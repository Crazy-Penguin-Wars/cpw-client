package tuxwars.ui.containers.shop
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.*;
   import tuxwars.ui.containers.shop.container.banner.*;
   import tuxwars.ui.containers.shop.container.item.*;
   import tuxwars.ui.containers.shop.container.slot.*;
   
   public class ContentSizeFour extends Content implements IShopTutorial
   {
      private static const BANNER:String = "Banner";
      
      private static const HUGE_SLOT:String = "Huge_Slot";
      
      private static const SLOTS_PACK:String = "Slots_Pack";
      
      public function ContentSizeFour(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         super(param1,param2,param3,param4);
         containers.add("Banner",new BannerMessage(param1.Banner,param2,param3,param4));
         containers.add("Huge_Slot",new ItemBigButton(param1.Huge_Slot,param2,param3,param4));
         containers.add("Slots_Pack",new SlotFourSmall(param1.Slots_Pack,param2,param3,param4));
         if(this.show != null)
         {
            containers.show(this.show,false);
         }
         else
         {
            containers.setAllVisible(false);
         }
      }
      
      private function get show() : String
      {
         var _loc1_:String = null;
         if(data == null)
         {
            return null;
         }
         if((data as Array).length <= 1 && data[0] is BigShopItem)
         {
            _loc1_ = (data[0] as BigShopItem).bigType;
            if(_loc1_ == "Item")
            {
               return "Huge_Slot";
            }
            return "Banner";
         }
         return "Slots_Pack";
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:* = undefined;
         if(Boolean(containers) && Boolean(containers.getContainers()))
         {
            for each(_loc4_ in containers.getContainers())
            {
               if(_loc4_ is IShopTutorial)
               {
                  (_loc4_ as IShopTutorial).activateTutorial(param1,param2,param3);
               }
            }
         }
      }
   }
}

