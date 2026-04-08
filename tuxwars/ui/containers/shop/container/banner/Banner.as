package tuxwars.ui.containers.shop.container.banner
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.*;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.containers.shop.container.tags.ContainerTags;
   
   public class Banner extends ContainerTags implements IShopTutorial
   {
      public static const TYPE_BANNER:String = "Banner";
      
      public static const TYPE_BANNER_BIG:String = "BannerBig";
      
      private static const DEFAULT_IMAGE_URL:String = Config.getDataDir() + "flash/ui/png/daily_news/default.png";
      
      private var _imageContainer:MovieClip;
      
      public function Banner(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param2,param3,param4);
         this._imageContainer = param1.Container_Banner;
      }
      
      override public function dispose() : void
      {
         this._imageContainer = null;
         super.dispose();
      }
      
      override public function shown() : void
      {
         if(Boolean(this.bigShopItem) && Boolean(this._imageContainer))
         {
            this.bigShopItem.load(this._imageContainer);
         }
      }
      
      public function get bigShopItem() : BigShopItem
      {
         return singleData as BigShopItem;
      }
      
      public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
      }
   }
}

