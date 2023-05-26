package tuxwars.ui.popups.screen.refund
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.messages.SetFlagMessage;
   import tuxwars.ui.popups.screen.PopUpBaseImageScreen;
   
   public class RefundPopupScreen extends PopUpBaseImageScreen
   {
      
      private static const CASH:String = "cash";
      
      private static const CASH_TID:String = "CASH";
      
      private static const COINS_TID:String = "COINS";
      
      private static const REFUND_CASH_POPUP:String = "refund_cash_popup";
      
      private static const REFUND_COINS_POPUP:String = "refund_coins_popup";
       
      
      private var cash:Boolean;
      
      private var amount:int;
      
      public function RefundPopupScreen(game:TuxWarsGame)
      {
         super(game);
      }
      
      override public function init(params:*) : void
      {
         var dataString:* = null;
         var dataArray:* = null;
         if(params is String)
         {
            dataString = params as String;
            dataArray = dataString.split("-");
            if(dataArray.length == 2 && dataArray[1] is String && (dataArray[1] as String).length > 0)
            {
               amount = dataArray[0];
               cash = (dataArray[1] as String).toLowerCase() == "cash".toLowerCase();
            }
            else
            {
               LogUtils.log("Server data in not correct format: " + dataString + " cannot parse",this,2,"Warning",true,false,true);
            }
         }
         super.init(cash ? "refund_cash_popup" : "refund_coins_popup");
      }
      
      override public function get tidDescriptionParams() : Array
      {
         return ["" + amount,cash ? ProjectManager.getText("CASH") : ProjectManager.getText("COINS")];
      }
      
      override public function dispose() : void
      {
         MessageCenter.sendEvent(new SetFlagMessage("recent_cb_refund","Removed",1));
         super.dispose();
      }
   }
}
