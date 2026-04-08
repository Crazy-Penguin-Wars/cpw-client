package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.effects.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.data.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.net.*;
   import tuxwars.net.messages.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.nomoney.*;
   import tuxwars.utils.*;
   
   public class MegaPackSlot
   {
      private var design:MovieClip;
      
      private var button:UIButton;
      
      private var itemData:ItemData;
      
      private var parent:DailyNewsScreen;
      
      public function MegaPackSlot(param1:MovieClip, param2:ItemData, param3:DailyNewsScreen)
      {
         super();
         this.design = param1;
         this.itemData = param2;
         this.parent = param3;
         TuxUiUtils.createAutoTextFieldWithText(param1.Text,param2.name);
         TuxUiUtils.createAutoTextField(param1.Text_Message,"DAILY_NEWS_NO_NEWS_SALE_SLOT_TEXT");
         param1.Container_Icon.addChild(param2.icon);
         this.setPrice(param2);
      }
      
      public function dispose() : void
      {
         MessageCenter.removeListener("ItemBought",this.enableButton);
         if(this.button)
         {
            this.button.dispose();
         }
         this.button = null;
         this.itemData = null;
         this.parent = null;
         this.design = null;
      }
      
      private function setPrice(param1:ItemData) : void
      {
         if(param1.priceInfoReference.priceObject.isPremium)
         {
            this.design.Container_Price.Price_Cash.visible = false;
            this.button = TuxUiUtils.createButton(UIButton,this.design.Container_Price.Price_Coins,"Button_Buy",this.buyCallback);
            this.button.setText(param1.priceInfoReference.priceObject.priceValue.toString());
         }
         else
         {
            this.design.Container_Price.Price_Coins.visible = false;
            this.button = TuxUiUtils.createButton(UIButton,this.design.Container_Price.Price_Cash,"Button_Buy",this.buyCallback);
            this.button.setText(param1.priceInfoReference.priceObject.priceValue.toString());
         }
      }
      
      private function buyCallback(param1:MouseEvent) : void
      {
         var _loc2_:SoundReference = null;
         var _loc3_:ShopItem = null;
         var _loc4_:SoundReference = null;
         if(this.button && this.parent && Boolean(this.design))
         {
            if(this.itemData.priceInfoReference.priceObject.priceValue <= this.parent.tuxGame.player.premiumMoney)
            {
               _loc2_ = Sounds.getSoundReference("Buy");
               if(_loc2_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
               }
               this.disableButtonUntillServerResponse();
               _loc3_ = ShopItemManager.getShopItem(this.itemData);
               CRMService.sendEvent("Action","Button_Pressed","Clicked",CRMService.classChecker(this.parent),_loc3_.id);
               MessageCenter.sendEvent(new ShopItemMessage(_loc3_,this.parent));
               BuyingAnimation.startAnimation(this.design.Container_Icon,_loc3_.amountPurchased,_loc3_.icon);
            }
            else
            {
               _loc4_ = Sounds.getSoundReference("Nomoney");
               if(_loc4_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType(),"PlaySound"));
               }
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.triggerPopup(new NoMoneyPopUpSubState(this.parent.tuxGame,"Cash"),this.parent.tuxGame.currentState);
            }
         }
         else
         {
            LogUtils.log("Most likely already disposed",this,2,"Warning",true,false,false);
         }
      }
      
      private function disableButtonUntillServerResponse() : void
      {
         if(this.button)
         {
            this.button.setEnabled(false);
         }
         MessageCenter.addListener("ItemBought",this.enableButton);
      }
      
      private function enableButton(param1:Message) : void
      {
         MessageCenter.removeListener("ItemBought",this.enableButton);
         if(this.button)
         {
            this.button.setEnabled(true);
         }
      }
   }
}

