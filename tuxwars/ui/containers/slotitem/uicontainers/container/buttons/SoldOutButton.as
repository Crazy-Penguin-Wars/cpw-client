package tuxwars.ui.containers.slotitem.uicontainers.container.buttons
{
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class SoldOutButton extends UIButton
   {
      private var _slotElement:SlotElement;
      
      public function SoldOutButton(param1:MovieClip, param2:SlotElement)
      {
         this._slotElement = param2;
         super(param1);
      }
      
      override public function setEnabled(param1:Boolean) : void
      {
         super.setEnabled(!this._slotElement.shopItem.isSoldOut && param1);
      }
   }
}

