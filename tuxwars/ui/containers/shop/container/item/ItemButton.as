package tuxwars.ui.containers.shop.container.item
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.ui.containers.shop.IShopTutorial;
   import tuxwars.ui.containers.shop.container.tags.ContainerTags;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class ItemButton extends ContainerTags implements IShopTutorial
   {
      
      public static const TYPE_ITEM:String = "Item";
       
      
      protected var _slotElement:SlotElement;
      
      public function ItemButton(design:MovieClip, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         super(design,data,game,parent);
      }
      
      override public function shown() : void
      {
         super.shown();
         if(singleData)
         {
            _slotElement = new SlotElement(this._design,game,singleData,parent as TuxUIScreen);
         }
      }
      
      override public function dispose() : void
      {
         if(_slotElement)
         {
            _slotElement.dispose();
            _slotElement = null;
         }
         super.dispose();
      }
      
      public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         if(_slotElement is IShopTutorial)
         {
            _slotElement.activateTutorial(itemID,arrow,addTutorialArrow);
         }
      }
   }
}
