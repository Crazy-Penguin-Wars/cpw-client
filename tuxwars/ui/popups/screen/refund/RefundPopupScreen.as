package tuxwars.ui.popups.screen.refund
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.messages.*;
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
      
      public function RefundPopupScreen(param1:TuxWarsGame)
      {
         super(param1);
      }
      
      override public function init(param1:*) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         if(param1 is String)
         {
            _loc2_ = param1 as String;
            _loc3_ = _loc2_.split("-");
            if(_loc3_.length == 2 && _loc3_[1] is String && (_loc3_[1] as String).length > 0)
            {
               this.amount = _loc3_[0];
               this.cash = (_loc3_[1] as String).toLowerCase() == "cash".toLowerCase();
            }
            else
            {
               LogUtils.log("Server data in not correct format: " + _loc2_ + " cannot parse",this,2,"Warning",true,false,true);
            }
         }
         super.init(!!this.cash ? "refund_cash_popup" : "refund_coins_popup");
      }
      
      override public function get tidDescriptionParams() : Array
      {
         return ["" + this.amount,!!this.cash ? ProjectManager.getText("CASH") : ProjectManager.getText("COINS")];
      }
      
      override public function dispose() : void
      {
         MessageCenter.sendEvent(new SetFlagMessage("recent_cb_refund","Removed",1));
         super.dispose();
      }
   }
}

