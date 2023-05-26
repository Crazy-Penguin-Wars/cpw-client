package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.net.CRMService;
   import tuxwars.net.messages.ShopItemMessage;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   
   public class BuyButtonContainer extends ButtonContainer
   {
       
      
      public function BuyButtonContainer(design:MovieClip, parent:UIComponent = null)
      {
         super(design,parent);
         buttonText = price.toString();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         super.dispose();
      }
      
      override public function shown() : void
      {
         button.setVisible(price > 0);
         setEnabledByPrice(true);
      }
      
      override public function setVisible(value:Boolean) : void
      {
         button.setVisible(value && price > 0);
         super.setVisible(value && price > 0);
      }
      
      protected function get price() : int
      {
         if(shopItem.priceObject)
         {
            if(shopItem.canBuyMoreThanOnce || !slotElement.game.player.inventory.hasItem(shopItem.id))
            {
               return shopItem.priceObject.priceValue;
            }
            return 0;
         }
         return 0;
      }
      
      override protected function buttonPressed(event:MouseEvent) : void
      {
         var sound:* = null;
         var parentName:* = null;
         var sound2:* = null;
         var _loc4_:* = null;
         if(canAffordItem())
         {
            sound = Sounds.getSoundReference("Buy");
            if(sound)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
            }
            MessageCenter.sendEvent(new ShopItemMessage(shopItem,slotElement.parent));
            parentName = CRMService.classChecker((parent as SlotElement).parent);
            if(parentName != "NotSpecified")
            {
               CRMService.sendEvent("Action","Button_Pressed","Clicked",parentName,shopItem.id);
            }
            button.setVisible(price > 0);
            disableButtonUntillServerResponse();
         }
         else
         {
            sound2 = Sounds.getSoundReference("Nomoney");
            if(sound2)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",sound2.getMusicID(),sound2.getStart(),sound2.getType(),"PlaySound"));
            }
            _loc4_ = shopItem.priceObject.isPremium ? "Cash" : "Coins";
            var _loc6_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(slotElement.game,_loc4_),slotElement.game.currentState);
         }
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         if(button.getVisible())
         {
            button.setEnabled(false);
            MessageCenter.addListener("ItemBought",enableButton);
         }
      }
      
      private function enableButton(msg:Message) : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         button.setEnabled(canAffordItem());
      }
   }
}
