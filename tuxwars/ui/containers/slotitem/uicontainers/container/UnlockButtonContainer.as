package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   
   public class UnlockButtonContainer extends ButtonContainer
   {
       
      
      public function UnlockButtonContainer(design:MovieClip, parent:UIComponent = null)
      {
         super(design,parent);
         buttonText = ProjectManager.getText("Unlock");
      }
      
      override public function shown() : void
      {
         super.shown();
         button.setVisible(unlockPrice > 0);
         setEnabledByPrice(true);
      }
      
      override public function setVisible(value:Boolean) : void
      {
         super.setVisible(value);
         button.setVisible(value && unlockPrice > 0);
      }
      
      protected function get unlockPrice() : int
      {
         return shopItem.unlockPrice;
      }
      
      override public function canAffordItem() : Boolean
      {
         return unlockPrice <= slotElement.game.player.premiumMoney;
      }
      
      override protected function buttonPressed(event:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
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
            var _loc4_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(slotElement.game,"Cash"),slotElement.game.currentState);
         }
      }
      
      override protected function mouseOverExtraFunction() : void
      {
         buttonText = unlockPrice.toString();
         MessageCenter.sendMessage("UnlockIcon",shopItem.id);
      }
      
      override protected function mouseOutExtraFunction() : void
      {
         buttonText = ProjectManager.getText("Unlock");
         MessageCenter.sendMessage("LockIcon",shopItem.id);
      }
   }
}
