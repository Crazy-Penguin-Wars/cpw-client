package tuxwars.ui.containers.shop
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.ui.containers.shop.container.banner.BannerMessageButton;
   import tuxwars.ui.containers.shop.container.slot.SlotsBig;
   
   public class ContentSizeTwelve extends Content implements IShopTutorial
   {
      
      private static const BANNER:String = "Banner";
      
      private static const SLOTS:String = "Slots";
       
      
      public function ContentSizeTwelve(design:MovieClip, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         super(design,data,game,parent);
         containers.add("Banner",new BannerMessageButton(design.Banner,data,game,parent));
         containers.add("Slots",new SlotsBig(design.Slots,data,game,3,parent));
         containers.show(show,false);
      }
      
      private function get show() : String
      {
         if((data as Array).length <= 1)
         {
            return "Banner";
         }
         return "Slots";
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         if(containers != null)
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
