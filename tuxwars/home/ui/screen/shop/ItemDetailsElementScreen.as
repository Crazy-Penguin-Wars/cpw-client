package tuxwars.home.ui.screen.shop
{
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.utils.TuxUiUtils;
   
   public class ItemDetailsElementScreen extends TuxUIElementScreen
   {
      
      private static const TOOLTIP:String = "Tooltip";
      
      private static const NAME:String = "Text_Name";
      
      private static const DESCRIPTION:String = "Text_Description";
      
      private static const ICON_CONTAINER:String = "Container_Item";
       
      
      private var currentItem:ShopItem;
      
      private var nameTextField:UIAutoTextField;
      
      private var _descriptionTextField:UIAutoTextField;
      
      private var iconContainer:MovieClip;
      
      private var currentIcon:MovieClip;
      
      public function ItemDetailsElementScreen(design:DisplayObject, game:TuxWarsGame)
      {
         var _loc3_:MovieClip = (design as MovieClip).getChildByName("Tooltip") as MovieClip;
         super(_loc3_,game);
         var tf:TextField = _loc3_.getChildByName("Text_Name") as TextField;
         nameTextField = TuxUiUtils.createAutoTextField(tf,"");
         tf = _loc3_.getChildByName("Text_Description") as TextField;
         _descriptionTextField = TuxUiUtils.createAutoTextField(tf,"");
         iconContainer = _loc3_.getChildByName("Container_Item") as MovieClip;
         setVisible(false);
      }
      
      public static function containsDesignNeeded(design:DisplayObject) : Boolean
      {
         if(design && (design as MovieClip).getChildByName("Tooltip") as MovieClip)
         {
            return true;
         }
         return false;
      }
      
      public function setItem(shopItem:ShopItem) : void
      {
         if(shopItem != null)
         {
            currentItem = shopItem;
            setIcon(currentItem.icon);
            nameTextField.setText(shopItem.name + " (x" + shopItem.amountPurchased + ")");
            _descriptionTextField.setText(shopItem.description);
            setVisible(true);
         }
         else
         {
            setVisible(false);
         }
      }
      
      private function setIcon(icon:MovieClip) : void
      {
         if(iconContainer != null)
         {
            if(currentIcon != null && iconContainer.contains(currentIcon))
            {
               iconContainer.removeChild(currentIcon);
            }
            if(icon != null)
            {
               DCUtils.setBitmapSmoothing(true,icon);
               iconContainer.addChild(icon);
            }
            currentIcon = icon;
         }
      }
      
      protected function get descriptionTextField() : UIAutoTextField
      {
         return _descriptionTextField;
      }
   }
}
