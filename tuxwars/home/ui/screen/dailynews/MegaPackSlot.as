package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.effects.BuyingAnimation;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.net.CRMService;
   import tuxwars.net.messages.ShopItemMessage;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.nomoney.NoMoneyPopUpSubState;
   import tuxwars.utils.TuxUiUtils;
   
   public class MegaPackSlot
   {
       
      
      private var design:MovieClip;
      
      private var button:UIButton;
      
      private var itemData:ItemData;
      
      private var parent:DailyNewsScreen;
      
      public function MegaPackSlot(design:MovieClip, itemData:ItemData, parent:DailyNewsScreen)
      {
         super();
         this.design = design;
         this.itemData = itemData;
         this.parent = parent;
         TuxUiUtils.createAutoTextFieldWithText(design.Text,itemData.name);
         TuxUiUtils.createAutoTextField(design.Text_Message,"DAILY_NEWS_NO_NEWS_SALE_SLOT_TEXT");
         design.Container_Icon.addChild(itemData.icon);
         setPrice(itemData);
      }
      
      public function dispose() : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         if(button)
         {
            button.dispose();
         }
         button = null;
         itemData = null;
         parent = null;
         design = null;
      }
      
      private function setPrice(itemData:ItemData) : void
      {
         if(itemData.priceInfoReference.priceObject.isPremium)
         {
            design.Container_Price.Price_Cash.visible = false;
            button = TuxUiUtils.createButton(UIButton,design.Container_Price.Price_Coins,"Button_Buy",buyCallback);
            button.setText(itemData.priceInfoReference.priceObject.priceValue.toString());
         }
         else
         {
            design.Container_Price.Price_Coins.visible = false;
            button = TuxUiUtils.createButton(UIButton,design.Container_Price.Price_Cash,"Button_Buy",buyCallback);
            button.setText(itemData.priceInfoReference.priceObject.priceValue.toString());
         }
      }
      
      private function buyCallback(event:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(button && parent && design)
         {
            if(itemData.priceInfoReference.priceObject.priceValue <= parent.tuxGame.player.premiumMoney)
            {
               _loc2_ = Sounds.getSoundReference("Buy");
               if(_loc2_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
               }
               disableButtonUntillServerResponse();
               _loc3_ = ShopItemManager.getShopItem(itemData);
               CRMService.sendEvent("Action","Button_Pressed","Clicked",CRMService.classChecker(parent),_loc3_.id);
               MessageCenter.sendEvent(new ShopItemMessage(_loc3_,parent));
               BuyingAnimation.startAnimation(design.Container_Icon,_loc3_.amountPurchased,_loc3_.icon);
            }
            else
            {
               _loc4_ = Sounds.getSoundReference("Nomoney");
               if(_loc4_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType(),"PlaySound"));
               }
               var _loc5_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NoMoneyPopUpSubState(parent.tuxGame,"Cash"),parent.tuxGame.currentState);
            }
         }
         else
         {
            LogUtils.log("Most likely already disposed",this,2,"Warning",true,false,false);
         }
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         if(button)
         {
            button.setEnabled(false);
         }
         MessageCenter.addListener("ItemBought",enableButton);
      }
      
      private function enableButton(msg:Message) : void
      {
         MessageCenter.removeListener("ItemBought",enableButton);
         if(button)
         {
            button.setEnabled(true);
         }
      }
   }
}
