package tuxwars.ui.containers.slotitem.uicontainers.container.buttons
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.components.IconButton;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.utils.*;
   
   public class ShopItemButton extends IconButton
   {
      private var _newText:UIAutoTextField;
      
      private var _soldOutText:UIAutoTextField;
      
      private var _slotElement:SlotElement;
      
      public function ShopItemButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
         var _loc6_:TextField = param1.Text_New;
         var _loc7_:TextField = param1.Text_Sold_Out;
         if(_loc6_)
         {
            this._newText = TuxUiUtils.createAutoTextFieldWithText(_loc6_,"");
         }
         if(_loc7_)
         {
            this._soldOutText = TuxUiUtils.createAutoTextFieldWithText(_loc7_,"");
         }
      }
      
      public function setSlotElement(param1:SlotElement) : void
      {
         this._slotElement = param1;
         this.setItemText();
         setIcon(this._slotElement.shopItem.icon);
      }
      
      public function get slotElement() : SlotElement
      {
         return this._slotElement;
      }
      
      public function get shopItem() : ShopItem
      {
         return this._slotElement.shopItem;
      }
      
      override protected function updateTextField() : void
      {
         super.updateTextField();
         var _loc1_:TextField = this._design.Text_New;
         var _loc2_:TextField = this._design.Text_Sold_Out;
         if(_loc1_)
         {
            this._newText = TuxUiUtils.createAutoTextFieldWithText(_loc1_,"");
         }
         if(_loc2_)
         {
            this._soldOutText = TuxUiUtils.createAutoTextFieldWithText(_loc1_,"");
         }
         this.setItemText();
      }
      
      protected function setItemText() : void
      {
         if(Boolean(this._newText) && Boolean(this._slotElement))
         {
            if(Boolean(this._slotElement.shopItem) && Boolean(this._slotElement.shopItem.isNew))
            {
               this._newText.setText(ProjectManager.getText("TID_NEW"));
               this._newText.setVisible(true);
            }
            else if(Boolean(this._slotElement.shopItem) && Boolean(this._slotElement.shopItem.isSoldOut))
            {
               this._soldOutText.setText(ProjectManager.getText("SOLDOUT"));
               this._soldOutText.setVisible(true);
            }
            else
            {
               this._newText.setText("");
               this._newText.setVisible(false);
               this._soldOutText.setText("");
               this._soldOutText.setVisible(false);
            }
         }
      }
      
      override public function dispose() : void
      {
         this._slotElement = null;
         this._newText = null;
         this._soldOutText = null;
         super.dispose();
      }
   }
}

