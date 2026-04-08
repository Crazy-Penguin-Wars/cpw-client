package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.*;
   import tuxwars.net.*;
   import tuxwars.net.messages.*;
   import tuxwars.ui.containers.slotitem.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   
   public class BuyButtonContainer extends ButtonContainer
   {
      public function BuyButtonContainer(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1,param2);
         buttonText = this.price.toString();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("ItemBought",this.enableButton);
         super.dispose();
      }
      
      override public function shown() : void
      {
         button.setVisible(this.price > 0);
         setEnabledByPrice(true);
      }
      
      override public function setVisible(param1:Boolean) : void
      {
         button.setVisible(param1 && this.price > 0);
         super.setVisible(param1 && this.price > 0);
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
      
      override protected function buttonPressed(param1:MouseEvent) : void
      {
         var _loc2_:SoundReference = null;
         var _loc3_:String = null;
         var _loc4_:SoundReference = null;
         var _loc5_:String = null;
         if(canAffordItem())
         {
            _loc2_ = Sounds.getSoundReference("Buy");
            if(_loc2_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
            }
            MessageCenter.sendEvent(new ShopItemMessage(shopItem,slotElement.parent));
            _loc3_ = CRMService.classChecker((parent as SlotElement).parent);
            if(_loc3_ != "NotSpecified")
            {
               CRMService.sendEvent("Action","Button_Pressed","Clicked",_loc3_,shopItem.id);
            }
            button.setVisible(this.price > 0);
            this.disableButtonUntillServerResponse();
         }
         else
         {
            _loc4_ = Sounds.getSoundReference("Nomoney");
            if(_loc4_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType(),"PlaySound"));
            }
            _loc5_ = shopItem.priceObject.isPremium ? "Cash" : "Coins";
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(slotElement.game,_loc5_),slotElement.game.currentState);
         }
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         if(button.getVisible())
         {
            button.setEnabled(false);
            MessageCenter.addListener("ItemBought",this.enableButton);
         }
      }
      
      private function enableButton(param1:Message) : void
      {
         MessageCenter.removeListener("ItemBought",this.enableButton);
         button.setVisible(false);
      }
   }
}

