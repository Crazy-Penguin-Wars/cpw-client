package tuxwars.home.ui.screen.crafting.itemslot
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.Item;
   import tuxwars.items.data.RecipeData;
   import tuxwars.net.messages.InventoryUpdatedMessage;
   import tuxwars.utils.*;
   
   public class IngredientResultSlot extends IngredientSlot
   {
      protected static const BUTTON_BUILD:String = "Button_Build";
      
      private var button:UIButton;
      
      public function IngredientResultSlot(param1:MovieClip, param2:RecipeData, param3:Item, param4:TuxUIScreen)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.button.dispose();
         this.button = null;
      }
      
      override protected function createButton() : void
      {
         this.button = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Build",this.craft,"Craft");
         this.button.setShowTransitions(false);
         this.button.setVisible(true);
         this.button.setShowTransitions(true);
         this.updateButton();
      }
      
      private function updateButton() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in _recipe.ingredients)
         {
            if(!_player.inventory.hasItem(_loc1_))
            {
               this.button.setEnabled(false);
               return;
            }
         }
         this.button.setEnabled(true);
      }
      
      override protected function inventoryUpdated(param1:InventoryUpdatedMessage) : void
      {
         if(param1.player.id == _player.id)
         {
            super.inventoryUpdated(param1);
            this.updateButton();
         }
      }
      
      public function craft(param1:MouseEvent) : void
      {
         MessageCenter.sendMessage("CraftItem",_recipe);
         this.button.setEnabled(false);
      }
   }
}

