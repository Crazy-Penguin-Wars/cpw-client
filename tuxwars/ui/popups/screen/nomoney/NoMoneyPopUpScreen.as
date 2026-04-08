package tuxwars.ui.popups.screen.nomoney
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.money.*;
   import tuxwars.net.*;
   import tuxwars.net.objects.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class NoMoneyPopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      public static const TABLE:String = "PopupData";
      
      private static const TITLE:String = "Title";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const PICTURE:String = "Picture";
      
      private var loader:URLResourceLoader;
      
      private var imageID:String;
      
      public function NoMoneyPopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_message");
      }
      
      override public function init(param1:*) : void
      {
         var _loc15_:String = null;
         var _loc16_:* = undefined;
         var _loc17_:Row = null;
         var _loc18_:String = null;
         var _loc19_:* = undefined;
         var _loc20_:Row = null;
         var _loc2_:Row = null;
         super.init(param1);
         var _loc3_:String = "PopupData";
         var _loc4_:Table = ProjectManager.findTable(_loc3_);
         if(this.currencyIsCoins())
         {
            _loc15_ = "no_coins_popup";
            _loc16_ = _loc4_;
            if(!_loc16_.getCache[_loc15_])
            {
               _loc17_ = DCUtils.find(_loc16_.rows,"id",_loc15_);
               if(!_loc17_)
               {
                  LogUtils.log("No row with name: \'" + _loc15_ + "\' was found in table: \'" + _loc16_.name + "\'",_loc16_,3);
               }
               _loc16_.getCache[_loc15_] = _loc17_;
            }
            _loc2_ = _loc16_.getCache[_loc15_];
            CRMService.sendEvent("PopUp","Shown","Not_Enough_Coins");
         }
         else
         {
            _loc18_ = "no_cash_popup";
            _loc19_ = _loc4_;
            if(!_loc19_.getCache[_loc18_])
            {
               _loc20_ = DCUtils.find(_loc19_.rows,"id",_loc18_);
               if(!_loc20_)
               {
                  LogUtils.log("No row with name: \'" + _loc18_ + "\' was found in table: \'" + _loc19_.name + "\'",_loc19_,3);
               }
               _loc19_.getCache[_loc18_] = _loc20_;
            }
            _loc2_ = _loc19_.getCache[_loc18_];
            CRMService.sendEvent("PopUp","Shown","Not_Enough_Cash");
         }
         var _loc5_:String = "Picture";
         if(!_loc2_.getCache[_loc5_])
         {
            _loc2_.getCache[_loc5_] = DCUtils.find(_loc2_.getFields(),"name",_loc5_);
         }
         var _loc6_:Field = _loc2_.getCache[_loc5_];
         this.imageID = Config.getDataDir() + (_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value);
         this.loader = ResourceLoaderURL.getInstance().load(this);
         var _loc7_:String = "Title";
         var _loc8_:* = _loc2_;
         if(!_loc8_.getCache[_loc7_])
         {
            _loc8_.getCache[_loc7_] = DCUtils.find(_loc8_.getFields(),"name",_loc7_);
         }
         var _loc9_:* = _loc8_.getCache[_loc7_];
         var _loc10_:String = _loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value;
         var _loc11_:String = "Description";
         var _loc12_:* = _loc2_;
         if(!_loc12_.getCache[_loc11_])
         {
            _loc12_.getCache[_loc11_] = DCUtils.find(_loc12_.getFields(),"name",_loc11_);
         }
         var _loc13_:* = _loc12_.getCache[_loc11_];
         var _loc14_:String = _loc13_.overrideValue != null ? _loc13_.overrideValue : _loc13_._value;
         headerField.setText(ProjectManager.getText(_loc10_));
         messageField.setText(ProjectManager.getText(_loc14_));
         okButton.setMouseClickFunction(this.toTheMoneyScreen);
         okButton.setText(ProjectManager.getText("BUTTON_YES_PLEASE"));
      }
      
      private function toTheMoneyScreen(param1:MouseEvent) : void
      {
         if(this.currencyIsCoins())
         {
            this.addInGameMoneyCallback();
            CRMService.sendEvent("PopUp","Buy_Coins_Clicked","Not_Enough_Coins");
         }
         else
         {
            this.addPremiumMoneyCallback();
            CRMService.sendEvent("PopUp","Buy_Cash_Clicked","Not_Enough_Cash");
         }
         logic.exit();
      }
      
      private function addInGameMoneyCallback() : void
      {
         MessageCenter.addListener("showMoneyState",this.openMoneyState);
         JavaScriptServices.callJavascript(new ShowPaymentObject("Coins"));
      }
      
      private function addPremiumMoneyCallback() : void
      {
         MessageCenter.addListener("showMoneyState",this.openMoneyState);
         JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
      }
      
      private function openMoneyState(param1:Message) : void
      {
         LogUtils.log("Entered the openMoneyState",null,2,"Messages",false,false,false);
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         var _loc2_:* = JSON.parse(param1.data);
         if(_loc2_ != null)
         {
            if(_loc2_.type == "Coins")
            {
               tuxGame.currentState.parent.parent.changeState(new MoneyState(tuxGame,"popup_get_coins"));
               CRMService.sendEvent("PopUp","Buy_Coins_Clicked","Not_Enough_Coins");
            }
            else if(_loc2_.type == "Cash")
            {
               tuxGame.currentState.parent.parent.changeState(new MoneyState(tuxGame,"popup_get_cash_new"));
               CRMService.sendEvent("PopUp","Buy_Cash_Clicked","Not_Enough_Cash");
            }
            else
            {
               LogUtils.log("sendMessage: No eventListener for type: " + _loc2_.type,null,2,"Messages",false,false,false);
            }
         }
      }
      
      private function currencyIsCoins() : Boolean
      {
         return params == "Coins";
      }
      
      public function getResourceUrl() : String
      {
         return this.imageID;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      override public function exit() : void
      {
         if(this.currencyIsCoins())
         {
            CRMService.sendEvent("PopUp","Skip_Clicked","Not_Enough_Coins");
         }
         else
         {
            CRMService.sendEvent("PopUp","Skip_Clicked","Not_Enough_Cash");
         }
         MessageCenter.removeListener("showMoneyState",this.openMoneyState);
         super.exit();
      }
   }
}

