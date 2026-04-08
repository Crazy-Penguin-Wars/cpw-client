package tuxwars.ui.popups.screen.crm
{
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.ui.popups.logic.crm.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.*;
   
   public class CRMMessagePopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      private static const BUTTON_CASH:String = "Button_Buy_Cash";
      
      private static const BUTTON_COINS:String = "Button_Buy_Coins";
      
      private var loader:URLResourceLoader;
      
      private var _cashButton:UIButton;
      
      private var _coinsButton:UIButton;
      
      public function CRMMessagePopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_crm_sales");
      }
      
      override public function init(param1:*) : void
      {
         assert("CRM params is null",true,param1 is CRMPopUpData);
         super.init(param1);
         headerField.setText(this.crmMessagePopUpLogic.headerText);
         messageField.setText(this.crmMessagePopUpLogic.messageText);
         if(this.crmMessagePopUpLogic.picture)
         {
            this.loader = ResourceLoaderURL.getInstance().load(this);
         }
         if(this._design["Button_Buy_Cash"])
         {
            this._cashButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Buy_Cash",this.cashPressed);
            this._cashButton.setVisible(false);
         }
         if(this._design["Button_Buy_Coins"])
         {
            this._coinsButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Buy_Coins",this.coinsPressed);
            this._coinsButton.setVisible(false);
         }
         if(okButton)
         {
            okButton.setVisible(false);
            if(Boolean(this.popupData) && Boolean(this.popupData.actionLabel))
            {
               okButton.setText(this.popupData.actionLabel);
            }
         }
         this.enableCorrectButton();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("UpdateTournamentScreen",this.enableTournamentButton);
         if(this.loader)
         {
            this.loader.dispose();
            this.loader = null;
         }
         this._cashButton = null;
         this._coinsButton = null;
         super.dispose();
      }
      
      private function enableCorrectButton() : void
      {
         var _loc1_:ItemData = null;
         switch(this.popupData.actionCode)
         {
            case "directbuy":
               _loc1_ = ItemManager.getItemData(this.popupData.actionParameters.id);
               if(_loc1_)
               {
                  if(_loc1_.priceInfoReference.priceObject.isPremium)
                  {
                     this._cashButton.setVisible(true);
                     this._cashButton.setText("" + _loc1_.priceInfoReference.priceObject.priceValue);
                  }
                  else
                  {
                     this._coinsButton.setVisible(true);
                     this._coinsButton.setText("" + _loc1_.priceInfoReference.priceObject.priceValue);
                  }
               }
               else
               {
                  LogUtils.log("No item found for id: " + this.popupData.actionParameters.id,this,2,"CRMPopup",false,false,false);
                  okButton.setVisible(true);
               }
               break;
            case "gototournament":
               okButton.setVisible(true);
               okButton.setEnabled(_game.player.isTournamentAvailable());
               MessageCenter.addListener("UpdateTournamentScreen",this.enableTournamentButton);
               break;
            case "gotobuycoins":
            case "gotobuycash":
            case "gotocustomization":
            case "gotostore":
            case "gotourl":
            case "gotovipmenu":
            case "ok":
            default:
               okButton.setVisible(true);
         }
      }
      
      private function enableTournamentButton(param1:Message) : void
      {
         MessageCenter.removeListener("UpdateTournamentScreen",this.enableTournamentButton);
         okButton.setEnabled(_game.player.isTournamentAvailable());
      }
      
      override protected function closePressed(param1:MouseEvent) : void
      {
         super.closePressed(param1);
      }
      
      override protected function okPressed(param1:MouseEvent) : void
      {
         this.crmMessagePopUpLogic.runAction();
      }
      
      protected function cashPressed(param1:MouseEvent) : void
      {
         this.crmMessagePopUpLogic.runAction();
      }
      
      protected function coinsPressed(param1:MouseEvent) : void
      {
         this.crmMessagePopUpLogic.runAction();
      }
      
      public function getResourceUrl() : String
      {
         return this.crmMessagePopUpLogic.picture;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function get crmMessagePopUpLogic() : CRMMessagePopUpLogic
      {
         return logic as CRMMessagePopUpLogic;
      }
      
      private function get popupData() : CRMPopUpData
      {
         return params as CRMPopUpData;
      }
      
      public function get cashButton() : UIButton
      {
         return this._cashButton;
      }
      
      public function get coinsButton() : UIButton
      {
         return this._coinsButton;
      }
   }
}

