package tuxwars.ui.containers.slotitem.uicontainers.container.buttons
{
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class SoldOutButton extends UIButton
   {
       
      
      private var _slotElement:SlotElement;
      
      public function SoldOutButton(design:MovieClip, slotElement:SlotElement)
      {
         _slotElement = slotElement;
         super(design);
      }
      
      override public function setEnabled(value:Boolean) : void
      {
         super.setEnabled(!_slotElement.shopItem.isSoldOut && value);
      }
   }
}
