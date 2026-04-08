package tuxwars.ui.containers.shop.container.item
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.*;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.containers.shop.container.tags.ContainerTags;
   import tuxwars.ui.containers.slotitem.*;
   
   public class ItemButton extends ContainerTags implements IShopTutorial
   {
      public static const TYPE_ITEM:String = "Item";
      
      protected var _slotElement:SlotElement;
      
      public function ItemButton(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function shown() : void
      {
         super.shown();
         if(singleData)
         {
            this._slotElement = new SlotElement(this._design,game,singleData,parent as TuxUIScreen);
         }
      }
      
      override public function dispose() : void
      {
         if(this._slotElement)
         {
            this._slotElement.dispose();
            this._slotElement = null;
         }
         super.dispose();
      }
      
      public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         if(this._slotElement is IShopTutorial)
         {
            this._slotElement.activateTutorial(param1,param2,param3);
         }
      }
   }
}

