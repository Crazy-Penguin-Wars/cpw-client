package tuxwars.home.ui.screen.crafting.itemslot
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.Item;
   import tuxwars.items.data.RecipeData;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.utils.TuxUiUtils;
   
   public class IngredientResultSlot extends IngredientSlot
   {
      
      protected static const BUTTON_BUILD:String = "Button_Build";
       
      
      private var button:UIButton;
      
      public function IngredientResultSlot(design:MovieClip, recipe:RecipeData, item:Item, parent:TuxUIScreen)
      {
         super(design,recipe,item,parent);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         button.dispose();
         button = null;
      }
      
      override protected function createButton() : void
      {
         button = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Build",craft,"Craft");
         button.setShowTransitions(false);
         button.setVisible(true);
         button.setShowTransitions(true);
         updateButton();
      }
      
      private function updateButton() : void
      {
         for each(var s in _recipe.ingredients)
         {
            if(!_player.inventory.hasItem(s))
            {
               button.setEnabled(false);
               return;
            }
         }
         button.setEnabled(true);
      }
      
      override protected function inventoryUpdated(event:InventoryUpdatedMessage) : void
      {
         if(event.player.id == _player.id)
         {
            super.inventoryUpdated(event);
            updateButton();
         }
      }
      
      public function craft(event:MouseEvent) : void
      {
         MessageCenter.sendMessage("CraftItem",_recipe);
         button.setEnabled(false);
      }
   }
}
