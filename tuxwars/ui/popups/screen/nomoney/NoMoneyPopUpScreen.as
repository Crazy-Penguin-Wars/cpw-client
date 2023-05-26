package tuxwars.ui.popups.screen.nomoney
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.money.MoneyState;
   import tuxwars.net.CRMService;
   import tuxwars.net.JavaScriptServices;
   import tuxwars.net.objects.ShowPaymentObject;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class NoMoneyPopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      
      public static const TABLE:String = "PopupData";
      
      private static const TITLE:String = "Title";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const PICTURE:String = "Picture";
       
      
      private var loader:URLResourceLoader;
      
      private var imageID:String;
      
      public function NoMoneyPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_message");
      }
      
      override public function init(params:*) : void
      {
         var row:* = null;
         super.init(params);
         var _loc6_:ProjectManager = ProjectManager;
         var _loc2_:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable("PopupData");
         if(currencyIsCoins())
         {
            var _loc7_:* = _loc2_;
            if(!_loc7_._cache["no_coins_popup"])
            {
               var _loc17_:Row = com.dchoc.utils.DCUtils.find(_loc7_.rows,"id","no_coins_popup");
               if(!_loc17_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "no_coins_popup" + "\' was found in table: \'" + _loc7_.name + "\'",_loc7_,3);
               }
               _loc7_._cache["no_coins_popup"] = _loc17_;
            }
            row = _loc7_._cache["no_coins_popup"];
            CRMService.sendEvent("PopUp","Shown","Not_Enough_Coins");
         }
         else
         {
            var _loc8_:* = _loc2_;
            if(!_loc8_._cache["no_cash_popup"])
            {
               var _loc19_:Row = com.dchoc.utils.DCUtils.find(_loc8_.rows,"id","no_cash_popup");
               if(!_loc19_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "no_cash_popup" + "\' was found in table: \'" + _loc8_.name + "\'",_loc8_,3);
               }
               _loc8_._cache["no_cash_popup"] = _loc19_;
            }
            row = _loc8_._cache["no_cash_popup"];
            CRMService.sendEvent("PopUp","Shown","Not_Enough_Cash");
         }
         var _loc9_:* = row;
         §§push(Config.getDataDir());
         if(!_loc9_._cache["Picture"])
         {
            _loc9_._cache["Picture"] = com.dchoc.utils.DCUtils.find(_loc9_._fields,"name","Picture");
         }
         var _loc10_:* = _loc9_._cache["Picture"];
         imageID = §§pop() + (_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value);
         loader = ResourceLoaderURL.getInstance().load(this);
         var _loc11_:* = row;
         if(!_loc11_._cache["Title"])
         {
            _loc11_._cache["Title"] = com.dchoc.utils.DCUtils.find(_loc11_._fields,"name","Title");
         }
         var _loc12_:* = _loc11_._cache["Title"];
         var _loc4_:String = _loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value;
         var _loc13_:* = row;
         if(!_loc13_._cache["Description"])
         {
            _loc13_._cache["Description"] = com.dchoc.utils.DCUtils.find(_loc13_._fields,"name","Description");
         }
         var _loc14_:* = _loc13_._cache["Description"];
         var _loc3_:String = _loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value;
         headerField.setText(ProjectManager.getText(_loc4_));
         messageField.setText(ProjectManager.getText(_loc3_));
         okButton.setMouseClickFunction(toTheMoneyScreen);
         okButton.setText(ProjectManager.getText("BUTTON_YES_PLEASE"));
      }
      
      private function toTheMoneyScreen(event:MouseEvent) : void
      {
         if(currencyIsCoins())
         {
            addInGameMoneyCallback();
            CRMService.sendEvent("PopUp","Buy_Coins_Clicked","Not_Enough_Coins");
         }
         else
         {
            addPremiumMoneyCallback();
            CRMService.sendEvent("PopUp","Buy_Cash_Clicked","Not_Enough_Cash");
         }
         logic.exit();
      }
      
      private function addInGameMoneyCallback() : void
      {
         MessageCenter.addListener("showMoneyState",openMoneyState);
         JavaScriptServices.callJavascript(new ShowPaymentObject("Coins"));
      }
      
      private function addPremiumMoneyCallback() : void
      {
         MessageCenter.addListener("showMoneyState",openMoneyState);
         JavaScriptServices.callJavascript(new ShowPaymentObject("Cash"));
      }
      
      private function openMoneyState(msg:Message) : void
      {
         LogUtils.log("Entered the openMoneyState",null,2,"Messages",false,false,false);
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         var _loc2_:* = JSON.parse(msg.data);
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
         return imageID;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      override public function exit() : void
      {
         if(currencyIsCoins())
         {
            CRMService.sendEvent("PopUp","Skip_Clicked","Not_Enough_Coins");
         }
         else
         {
            CRMService.sendEvent("PopUp","Skip_Clicked","Not_Enough_Cash");
         }
         MessageCenter.removeListener("showMoneyState",openMoneyState);
         super.exit();
      }
   }
}
