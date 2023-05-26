package tuxwars.ui.containers.shop.container.item
{
   import com.dchoc.resources.URLResourceLoader;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.BigShopItem;
   
   public class ItemBigButton extends ItemButton
   {
      
      public static const LOADED_ICON:String = "LoadedIcon";
       
      
      private var parentMC:MovieClip;
      
      private var mc:MovieClip;
      
      private var _loader:URLResourceLoader;
      
      public function ItemBigButton(design:MovieClip, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         super(design,data,game,parent);
         if(bigShopItem && bigShopItem.getResourceUrl())
         {
            parentMC = new MovieClip();
            mc = new MovieClip();
            mc.name = "LoadedIcon";
            parentMC.addChild(mc);
            mc.addChild(design.Slot_Unusable.Container_Icon);
            _loader = new URLResourceLoader(mc,bigShopItem.getResourceUrl());
         }
      }
      
      override public function shown() : void
      {
         if(parentMC)
         {
            bigShopItem.iconOverride = parentMC;
         }
         super.shown();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function get bigShopItem() : BigShopItem
      {
         return singleData as BigShopItem;
      }
   }
}
