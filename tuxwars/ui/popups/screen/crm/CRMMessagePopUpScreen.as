package tuxwars.ui.popups.screen.crm
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import no.olog.utilfunctions.assert;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.ui.popups.logic.crm.CRMMessagePopUpLogic;
   import tuxwars.ui.popups.logic.crm.CRMPopUpData;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class CRMMessagePopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      
      private static const BUTTON_CASH:String = "Button_Buy_Cash";
      
      private static const BUTTON_COINS:String = "Button_Buy_Coins";
       
      
      private var loader:URLResourceLoader;
      
      private var _cashButton:UIButton;
      
      private var _coinsButton:UIButton;
      
      public function CRMMessagePopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_crm_sales");
      }
      
      override public function init(params:*) : void
      {
         assert("CRM params is null",true,params is CRMPopUpData);
         super.init(params);
         headerField.setText(crmMessagePopUpLogic.headerText);
         messageField.setText(crmMessagePopUpLogic.messageText);
         if(crmMessagePopUpLogic.picture)
         {
            loader = ResourceLoaderURL.getInstance().load(this);
         }
         if(this._design["Button_Buy_Cash"])
         {
            _cashButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Buy_Cash",cashPressed);
            _cashButton.setVisible(false);
         }
         if(this._design["Button_Buy_Coins"])
         {
            _coinsButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Buy_Coins",coinsPressed);
            _coinsButton.setVisible(false);
         }
         if(okButton)
         {
            okButton.setVisible(false);
            if(popupData && popupData.actionLabel)
            {
               okButton.setText(popupData.actionLabel);
            }
         }
         enableCorrectButton();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("UpdateTournamentScreen",enableTournamentButton);
         if(loader)
         {
            loader.dispose();
            loader = null;
         }
         _cashButton = null;
         _coinsButton = null;
         super.dispose();
      }
      
      private function enableCorrectButton() : void
      {
         var _loc1_:* = null;
         switch(popupData.actionCode)
         {
            case "directbuy":
               _loc1_ = ItemManager.getItemData(popupData.actionParameters.id);
               if(_loc1_)
               {
                  if(_loc1_.priceInfoReference.priceObject.isPremium)
                  {
                     _cashButton.setVisible(true);
                     _cashButton.setText("" + _loc1_.priceInfoReference.priceObject.priceValue);
                     break;
                  }
                  _coinsButton.setVisible(true);
                  _coinsButton.setText("" + _loc1_.priceInfoReference.priceObject.priceValue);
                  break;
               }
               LogUtils.log("No item found for id: " + popupData.actionParameters.id,this,2,"CRMPopup",false,false,false);
               okButton.setVisible(true);
               break;
            case "gototournament":
               okButton.setVisible(true);
               okButton.setEnabled(_game.player.isTournamentAvailable());
               MessageCenter.addListener("UpdateTournamentScreen",enableTournamentButton);
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
      
      private function enableTournamentButton(msg:Message) : void
      {
         MessageCenter.removeListener("UpdateTournamentScreen",enableTournamentButton);
         okButton.setEnabled(_game.player.isTournamentAvailable());
      }
      
      override protected function closePressed(event:MouseEvent) : void
      {
         super.closePressed(event);
      }
      
      override protected function okPressed(event:MouseEvent) : void
      {
         crmMessagePopUpLogic.runAction();
      }
      
      protected function cashPressed(event:MouseEvent) : void
      {
         crmMessagePopUpLogic.runAction();
      }
      
      protected function coinsPressed(event:MouseEvent) : void
      {
         crmMessagePopUpLogic.runAction();
      }
      
      public function getResourceUrl() : String
      {
         return crmMessagePopUpLogic.picture;
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
         return _cashButton;
      }
      
      public function get coinsButton() : UIButton
      {
         return _coinsButton;
      }
   }
}
