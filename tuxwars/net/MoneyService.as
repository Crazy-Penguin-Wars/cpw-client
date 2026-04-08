package tuxwars.net
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.money.*;
   import tuxwars.net.objects.*;
   
   public class MoneyService
   {
      private static var currentGame:TuxWarsGame;
      
      public static const CRM_TYPE_MONEY:String = "Money";
      
      public static const PLATFORM_REQUEST_TYPE_MONEY:int = 10;
      
      public static const CRM_PRODUCT_MONEY_PURCHASE:String = "MoneyPurchase";
      
      public function MoneyService()
      {
         super();
         throw new Error("MoneyService is a static class!");
      }
      
      public static function init(param1:TuxWarsGame) : void
      {
         LogUtils.log("Initialized MoneyService","MoneyService",0,"Money",false,false,false);
         currentGame = param1;
         MessageCenter.addListener("beforeFederalPayment",beforeFederalPayment);
         MessageCenter.addListener("afterFederalPayment",afterFederalPayment);
         MessageCenter.addListener("ResponseReceived_" + "MoneyPurchase",callbackCatcher);
         MessageCenter.addListener("trialPayResponse",trialPayResponse);
      }
      
      public static function dispose(param1:TuxWarsGame) : void
      {
         LogUtils.log("Disposed MoneyService","MoneyService",0,"Money",false,false,false);
         currentGame = null;
         MessageCenter.removeListener("trialPayResponse",trialPayResponse);
         MessageCenter.removeListener("ResponseReceived_" + "MoneyPurchase",callbackCatcher);
         MessageCenter.removeListener("beforeFederalPayment",beforeFederalPayment);
         MessageCenter.removeListener("afterFederalPayment",afterFederalPayment);
      }
      
      public static function purchaseMoney(param1:String, param2:int, param3:String, param4:String, param5:Array = null, param6:Array = null) : void
      {
         LogUtils.log("Money purchase package: " + param1 + " cost: " + param2,"MoneyService",0,"Money",true,false,true);
         CRMService.sendEvent("Game","Settings_changed","Clicked","FullScreen off");
         DCGame.setFullScreen(false,"showAll");
         JavaScriptServices.callJavascript(createObject(param1,param2,ProjectManager.getText(param3,param5),ProjectManager.getText(param4,param6),null),false);
      }
      
      private static function createObject(param1:String, param2:int, param3:String, param4:String, param5:String) : JavaScriptObject
      {
         var _loc6_:PaymentObject = new PaymentObject(param1,param5,param3,param4);
         _loc6_.type = 10;
         return _loc6_;
      }
      
      private static function callbackCatcher(param1:Message) : void
      {
         var _loc2_:Object = null;
         if(param1.data)
         {
            if(Config.debugMode)
            {
               LogUtils.log("DEBUG: " + param1.data,"MoneyService",0,"Money",false,false,false);
            }
            _loc2_ = JSON.parse(param1.data);
            if(_loc2_ != null)
            {
               if(_loc2_.data != null && _loc2_.type == 10)
               {
                  LogUtils.log("callbackCatcher data is as follows, use if needed","MoneyService",0,"Money",false,false,false);
                  LogUtils.log(param1.data,"MoneyService",0,"Money",false,false,false);
               }
            }
         }
      }
      
      private static function beforeFederalPayment(param1:Message) : void
      {
         callbackCatcher(param1);
      }
      
      private static function trialPayResponse(param1:Message) : void
      {
         var _loc2_:Object = null;
         if(param1.data)
         {
            _loc2_ = JSON.parse(param1.data);
            if(_loc2_ != null)
            {
               if(_loc2_.success == 1 && Config.getPlatform() == "FB")
               {
                  LogUtils.log("trial pay amount credited" + _loc2_.credits,"MoneyService",0,"Money",true,false,false);
                  currentGame.player.addPremiumMoney(_loc2_.credits);
               }
            }
         }
      }
      
      private static function afterFederalPayment(param1:Message) : void
      {
         var _loc2_:Object = null;
         var _loc3_:CashPackage = null;
         var _loc4_:CoinPackage = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         if(param1.data)
         {
            _loc2_ = JSON.parse(param1.data);
            if(_loc2_ != null)
            {
               if(_loc2_.data != null && _loc2_.success == 1 && _loc2_.type == 10 && _loc2_.data.platform != "Spil")
               {
                  _loc3_ = MoneyManager.getCashPackage(_loc2_.data.order_info.id);
                  if(_loc3_)
                  {
                     LogUtils.log("Money purchase requestID:" + _loc2_.orderId + ". Cash package: " + _loc2_.data.order_info.id,"MoneyService",0,"Money",true,false,false);
                     currentGame.player.addPremiumMoney(_loc3_.amount + _loc3_.extraAmount);
                  }
                  else
                  {
                     _loc4_ = MoneyManager.getCoinPackage(_loc2_.data.order_info.id);
                     if(_loc4_)
                     {
                        LogUtils.log("Money purchase requestID:" + _loc2_.orderId + ". Coin package: " + _loc2_.data.order_info.id,"MoneyService",0,"Money",true,false,false);
                        currentGame.player.addIngameMoney(_loc4_.amount + _loc4_.extraAmount);
                     }
                     else
                     {
                        LogUtils.log("Money purchase requestID:" + _loc2_.orderId + ". Invalid money package: " + _loc2_.data.order_info.id,"MoneyService",3,"Money",true,false,true);
                     }
                  }
               }
               else if(_loc2_.data != null && _loc2_.success == 1 && _loc2_.type == 10 && _loc2_.data.platform == "Spil")
               {
                  _loc5_ = _loc2_.data.currencyType;
                  _loc6_ = int(_loc2_.data.amount);
                  if(_loc5_ == "Cash")
                  {
                     LogUtils.log("Money purchase request from Spiel. Amount of Cash given: " + _loc6_,"MoneyService",0,"Money",true,false,false);
                     currentGame.player.addPremiumMoney(_loc6_);
                  }
                  else if(_loc5_ == "Coins")
                  {
                     LogUtils.log("Money purchase request from Spiel. Amount of Coins given: " + _loc6_,"MoneyService",0,"Money",true,false,false);
                     currentGame.player.addIngameMoney(_loc6_);
                  }
                  else
                  {
                     LogUtils.log("Money purchase request from Spiel. Invalid currencytype","MoneyService",3,"Money",true,false,true);
                  }
               }
            }
         }
      }
   }
}

