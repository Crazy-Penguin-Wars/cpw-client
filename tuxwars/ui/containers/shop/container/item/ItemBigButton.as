package tuxwars.ui.containers.shop.container.item
{
   import com.dchoc.resources.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.*;
   
   public class ItemBigButton extends ItemButton
   {
      public static const LOADED_ICON:String = "LoadedIcon";
      
      private var parentMC:MovieClip;
      
      private var mc:MovieClip;
      
      private var _loader:URLResourceLoader;
      
      public function ItemBigButton(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         super(param1,param2,param3,param4);
         if(Boolean(this.bigShopItem) && Boolean(this.bigShopItem.getResourceUrl()))
         {
            this.parentMC = new MovieClip();
            this.mc = new MovieClip();
            this.mc.name = "LoadedIcon";
            this.parentMC.addChild(this.mc);
            this.mc.addChild(param1.Slot_Unusable.Container_Icon);
            this._loader = new URLResourceLoader(this.mc,this.bigShopItem.getResourceUrl());
         }
      }
      
      override public function shown() : void
      {
         if(this.parentMC)
         {
            this.bigShopItem.iconOverride = this.parentMC;
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

