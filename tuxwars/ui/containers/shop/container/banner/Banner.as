package tuxwars.ui.containers.shop.container.banner
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.BigShopItem;
   import tuxwars.ui.containers.shop.IShopTutorial;
   import tuxwars.ui.containers.shop.container.tags.ContainerTags;
   
   public class Banner extends ContainerTags implements IShopTutorial
   {
      
      private static const DEFAULT_IMAGE_URL:String = Config.getDataDir() + "flash/ui/png/daily_news/default.png";
      
      public static const TYPE_BANNER:String = "Banner";
      
      public static const TYPE_BANNER_BIG:String = "BannerBig";
       
      
      private var _imageContainer:MovieClip;
      
      public function Banner(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,data,game,parent);
         _imageContainer = design.Container_Banner;
      }
      
      override public function dispose() : void
      {
         _imageContainer = null;
         super.dispose();
      }
      
      override public function shown() : void
      {
         if(bigShopItem && _imageContainer)
         {
            bigShopItem.load(_imageContainer);
         }
      }
      
      public function get bigShopItem() : BigShopItem
      {
         return singleData as BigShopItem;
      }
      
      public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
      }
   }
}
