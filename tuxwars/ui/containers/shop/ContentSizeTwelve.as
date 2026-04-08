package tuxwars.ui.containers.shop
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.ui.containers.shop.container.banner.*;
   import tuxwars.ui.containers.shop.container.slot.*;
   
   public class ContentSizeTwelve extends Content implements IShopTutorial
   {
      private static const BANNER:String = "Banner";
      
      private static const SLOTS:String = "Slots";
      
      public function ContentSizeTwelve(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         super(param1,param2,param3,param4);
         containers.add("Banner",new BannerMessageButton(param1.Banner,param2,param3,param4));
         containers.add("Slots",new SlotsBig(param1.Slots,param2,param3,3,param4));
         containers.show(this.show,false);
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
      
      public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:* = undefined;
         if(containers != null)
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

