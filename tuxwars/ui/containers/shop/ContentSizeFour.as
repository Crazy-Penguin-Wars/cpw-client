package tuxwars.ui.containers.shop
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.BigShopItem;
   import tuxwars.ui.containers.shop.container.banner.BannerMessage;
   import tuxwars.ui.containers.shop.container.item.ItemBigButton;
   import tuxwars.ui.containers.shop.container.slot.SlotFourSmall;
   
   public class ContentSizeFour extends Content implements IShopTutorial
   {
      
      private static const BANNER:String = "Banner";
      
      private static const HUGE_SLOT:String = "Huge_Slot";
      
      private static const SLOTS_PACK:String = "Slots_Pack";
       
      
      public function ContentSizeFour(design:MovieClip, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         super(design,data,game,parent);
         containers.add("Banner",new BannerMessage(design.Banner,data,game,parent));
         containers.add("Huge_Slot",new ItemBigButton(design.Huge_Slot,data,game,parent));
         containers.add("Slots_Pack",new SlotFourSmall(design.Slots_Pack,data,game,parent));
         if(show != null)
         {
            containers.show(show,false);
         }
         else
         {
            containers.setAllVisible(false);
         }
      }
      
      private function get show() : String
      {
         var _loc1_:* = null;
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
      
      public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         if(containers && containers.getContainers())
         {
            for each(var ist in containers.getContainers())
            {
               if(ist is IShopTutorial)
               {
                  (ist as IShopTutorial).activateTutorial(itemID,arrow,addTutorialArrow);
               }
            }
         }
      }
   }
}
