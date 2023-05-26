package tuxwars.ui.containers.slotitem.uicontainers.container.buttons
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.components.IconButton;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.utils.TuxUiUtils;
   
   public class ShopItemButton extends IconButton
   {
       
      
      private var _newText:UIAutoTextField;
      
      private var _soldOutText:UIAutoTextField;
      
      private var _slotElement:SlotElement;
      
      public function ShopItemButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
         var _loc6_:TextField = design.Text_New;
         var _loc7_:TextField = design.Text_Sold_Out;
         if(_loc6_)
         {
            _newText = TuxUiUtils.createAutoTextFieldWithText(_loc6_,"");
         }
         if(_loc7_)
         {
            _soldOutText = TuxUiUtils.createAutoTextFieldWithText(_loc7_,"");
         }
      }
      
      public function setSlotElement(slotElement:SlotElement) : void
      {
         _slotElement = slotElement;
         setItemText();
         setIcon(_slotElement.shopItem.icon);
      }
      
      public function get slotElement() : SlotElement
      {
         return _slotElement;
      }
      
      public function get shopItem() : ShopItem
      {
         return _slotElement.shopItem;
      }
      
      override protected function updateTextField() : void
      {
         super.updateTextField();
         var _loc1_:TextField = this._design.Text_New;
         var _loc2_:TextField = this._design.Text_Sold_Out;
         if(_loc1_)
         {
            _newText = TuxUiUtils.createAutoTextFieldWithText(_loc1_,"");
         }
         if(_loc2_)
         {
            _soldOutText = TuxUiUtils.createAutoTextFieldWithText(_loc1_,"");
         }
         setItemText();
      }
      
      protected function setItemText() : void
      {
         if(_newText && _slotElement)
         {
            if(_slotElement.shopItem && _slotElement.shopItem.isNew)
            {
               _newText.setText(ProjectManager.getText("TID_NEW"));
               _newText.setVisible(true);
            }
            else if(_slotElement.shopItem && _slotElement.shopItem.isSoldOut)
            {
               _soldOutText.setText(ProjectManager.getText("SOLDOUT"));
               _soldOutText.setVisible(true);
            }
            else
            {
               _newText.setText("");
               _newText.setVisible(false);
               _soldOutText.setText("");
               _soldOutText.setVisible(false);
            }
         }
      }
      
      override public function dispose() : void
      {
         _slotElement = null;
         _newText = null;
         _soldOutText = null;
         super.dispose();
      }
   }
}
