package tuxwars.net
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.money.CashPackage;
   import tuxwars.money.CoinPackage;
   import tuxwars.money.MoneyManager;
   import tuxwars.net.objects.JavaScriptObject;
   import tuxwars.net.objects.PaymentObject;
   
   public class MoneyService
   {
      
      public static const CRM_TYPE_MONEY:String = "Money";
      
      public static const PLATFORM_REQUEST_TYPE_MONEY:int = 10;
      
      public static const CRM_PRODUCT_MONEY_PURCHASE:String = "MoneyPurchase";
      
      private static var currentGame:TuxWarsGame;
       
      
      public function MoneyService()
      {
         super();
         throw new Error("MoneyService is a static class!");
      }
      
      public static function init(game:TuxWarsGame) : void
      {
         LogUtils.log("Initialized MoneyService","MoneyService",0,"Money",false,false,false);
         currentGame = game;
         MessageCenter.addListener("beforeFederalPayment",beforeFederalPayment);
         MessageCenter.addListener("afterFederalPayment",afterFederalPayment);
         MessageCenter.addListener("ResponseReceived_" + "MoneyPurchase",callbackCatcher);
         MessageCenter.addListener("trialPayResponse",trialPayResponse);
      }
      
      public static function dispose(game:TuxWarsGame) : void
      {
         LogUtils.log("Disposed MoneyService","MoneyService",0,"Money",false,false,false);
         currentGame = null;
         MessageCenter.removeListener("trialPayResponse",trialPayResponse);
         MessageCenter.removeListener("ResponseReceived_" + "MoneyPurchase",callbackCatcher);
         MessageCenter.removeListener("beforeFederalPayment",beforeFederalPayment);
         MessageCenter.removeListener("afterFederalPayment",afterFederalPayment);
      }
      
      public static function purchaseMoney(packageId:String, packageCost:int, titleTID:String, messageTID:String, titleTIDParam:Array = null, messageTIDParam:Array = null) : void
      {
         LogUtils.log("Money purchase package: " + packageId + " cost: " + packageCost,"MoneyService",0,"Money",true,false,true);
         CRMService.sendEvent("Game","Settings_changed","Clicked","FullScreen off");
         DCGame.setFullScreen(false,"showAll");
         JavaScriptServices.callJavascript(createObject(packageId,packageCost,ProjectManager.getText(titleTID,titleTIDParam),ProjectManager.getText(messageTID,messageTIDParam),null),false);
      }
      
      private static function createObject(packageId:String, packageCost:int, title:String, message:String, toPlatform:String) : JavaScriptObject
      {
         var obj:PaymentObject = new PaymentObject(packageId,toPlatform,title,message);
         obj.type = 10;
         return obj;
      }
      
      private static function callbackCatcher(msg:Message) : void
      {
         var _loc2_:* = null;
         if(msg.data)
         {
            if(Config.debugMode)
            {
               LogUtils.log("DEBUG: " + msg.data,"MoneyService",0,"Money",false,false,false);
            }
            _loc2_ = JSON.parse(msg.data);
            if(_loc2_ != null)
            {
               if(_loc2_.data != null && _loc2_.type == 10)
               {
                  LogUtils.log("callbackCatcher data is as follows, use if needed","MoneyService",0,"Money",false,false,false);
                  LogUtils.log(msg.data,"MoneyService",0,"Money",false,false,false);
               }
            }
         }
      }
      
      private static function beforeFederalPayment(msg:Message) : void
      {
         callbackCatcher(msg);
      }
      
      private static function trialPayResponse(msg:Message) : void
      {
         var data:* = null;
         if(msg.data)
         {
            data = JSON.parse(msg.data);
            if(data != null)
            {
               if(data.success == 1 && Config.getPlatform() == "FB")
               {
                  LogUtils.log("trial pay amount credited" + data.credits,"MoneyService",0,"Money",true,false,false);
                  currentGame.player.addPremiumMoney(data.credits);
               }
            }
         }
      }
      
      private static function afterFederalPayment(msg:Message) : void
      {
         var data:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var currencyType:* = null;
         var currencyAmount:int = 0;
         if(msg.data)
         {
            data = JSON.parse(msg.data);
            if(data != null)
            {
               if(data.data != null && data.success == 1 && data.type == 10 && data.data.platform != "Spil")
               {
                  _loc4_ = MoneyManager.getCashPackage(data.data.order_info.id);
                  if(_loc4_)
                  {
                     LogUtils.log("Money purchase requestID:" + data.orderId + ". Cash package: " + data.data.order_info.id,"MoneyService",0,"Money",true,false,false);
                     currentGame.player.addPremiumMoney(_loc4_.amount + _loc4_.extraAmount);
                  }
                  else
                  {
                     _loc2_ = MoneyManager.getCoinPackage(data.data.order_info.id);
                     if(_loc2_)
                     {
                        LogUtils.log("Money purchase requestID:" + data.orderId + ". Coin package: " + data.data.order_info.id,"MoneyService",0,"Money",true,false,false);
                        currentGame.player.addIngameMoney(_loc2_.amount + _loc2_.extraAmount);
                     }
                     else
                     {
                        LogUtils.log("Money purchase requestID:" + data.orderId + ". Invalid money package: " + data.data.order_info.id,"MoneyService",3,"Money",true,false,true);
                     }
                  }
               }
               else if(data.data != null && data.success == 1 && data.type == 10 && data.data.platform == "Spil")
               {
                  currencyType = data.data.currencyType;
                  currencyAmount = int(data.data.amount);
                  if(currencyType == "Cash")
                  {
                     LogUtils.log("Money purchase request from Spiel. Amount of Cash given: " + currencyAmount,"MoneyService",0,"Money",true,false,false);
                     currentGame.player.addPremiumMoney(currencyAmount);
                  }
                  else if(currencyType == "Coins")
                  {
                     LogUtils.log("Money purchase request from Spiel. Amount of Coins given: " + currencyAmount,"MoneyService",0,"Money",true,false,false);
                     currentGame.player.addIngameMoney(currencyAmount);
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
