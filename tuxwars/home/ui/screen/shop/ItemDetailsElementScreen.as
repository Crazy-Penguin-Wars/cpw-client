package tuxwars.home.ui.screen.shop
{
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.utils.*;
   
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
      
      public function ItemDetailsElementScreen(param1:DisplayObject, param2:TuxWarsGame)
      {
         var _loc3_:MovieClip = (param1 as MovieClip).getChildByName("Tooltip") as MovieClip;
         super(_loc3_,param2);
         var _loc4_:TextField = _loc3_.getChildByName("Text_Name") as TextField;
         this.nameTextField = TuxUiUtils.createAutoTextField(_loc4_,"");
         _loc4_ = _loc3_.getChildByName("Text_Description") as TextField;
         this._descriptionTextField = TuxUiUtils.createAutoTextField(_loc4_,"");
         this.iconContainer = _loc3_.getChildByName("Container_Item") as MovieClip;
         setVisible(false);
      }
      
      public static function containsDesignNeeded(param1:DisplayObject) : Boolean
      {
         if(Boolean(param1) && Boolean((param1 as MovieClip).getChildByName("Tooltip") as MovieClip))
         {
            return true;
         }
         return false;
      }
      
      public function setItem(param1:ShopItem) : void
      {
         if(param1 != null)
         {
            this.currentItem = param1;
            this.setIcon(this.currentItem.icon);
            this.nameTextField.setText(param1.name + " (x" + param1.amountPurchased + ")");
            this._descriptionTextField.setText(param1.description);
            setVisible(true);
         }
         else
         {
            setVisible(false);
         }
      }
      
      private function setIcon(param1:MovieClip) : void
      {
         if(this.iconContainer != null)
         {
            if(this.currentIcon != null && Boolean(this.iconContainer.contains(this.currentIcon)))
            {
               this.iconContainer.removeChild(this.currentIcon);
            }
            if(param1 != null)
            {
               DCUtils.setBitmapSmoothing(true,param1);
               this.iconContainer.addChild(param1);
            }
            this.currentIcon = param1;
         }
      }
      
      protected function get descriptionTextField() : UIAutoTextField
      {
         return this._descriptionTextField;
      }
   }
}

