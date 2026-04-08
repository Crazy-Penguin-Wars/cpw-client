package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   
   public class UnlockButtonContainer extends ButtonContainer
   {
      public function UnlockButtonContainer(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1,param2);
         buttonText = ProjectManager.getText("Unlock");
      }
      
      override public function shown() : void
      {
         super.shown();
         button.setVisible(this.unlockPrice > 0);
         setEnabledByPrice(true);
      }
      
      override public function setVisible(param1:Boolean) : void
      {
         super.setVisible(param1);
         button.setVisible(param1 && this.unlockPrice > 0);
      }
      
      protected function get unlockPrice() : int
      {
         return shopItem.unlockPrice;
      }
      
      override public function canAffordItem() : Boolean
      {
         return this.unlockPrice <= slotElement.game.player.premiumMoney;
      }
      
      override protected function buttonPressed(param1:MouseEvent) : void
      {
         var _loc2_:SoundReference = null;
         var _loc3_:SoundReference = null;
         if(shopItem.unlockPrice <= slotElement.game.player.premiumMoney)
         {
            button.setEnabled(false);
            _loc2_ = Sounds.getSoundReference("Buy");
            if(_loc2_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
            }
            MessageCenter.sendMessage("UnlockItem",shopItem);
         }
         else
         {
            _loc3_ = Sounds.getSoundReference("Nomoney");
            if(_loc2_)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
            }
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(slotElement.game,"Cash"),slotElement.game.currentState);
         }
      }
      
      override protected function mouseOverExtraFunction() : void
      {
         buttonText = this.unlockPrice.toString();
         MessageCenter.sendMessage("UnlockIcon",shopItem.id);
      }
      
      override protected function mouseOutExtraFunction() : void
      {
         buttonText = ProjectManager.getText("Unlock");
         MessageCenter.sendMessage("LockIcon",shopItem.id);
      }
   }
}

