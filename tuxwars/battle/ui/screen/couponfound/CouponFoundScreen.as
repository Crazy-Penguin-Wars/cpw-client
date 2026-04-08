package tuxwars.battle.ui.screen.couponfound
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.ui.logic.couponfound.CouponFoundLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.items.data.CouponData;
   import tuxwars.utils.*;
   
   public class CouponFoundScreen extends TuxUIScreen
   {
      private const BUTTONS:String = "Slot_0";
      
      protected const headerField:UIAutoTextField = new UIAutoTextField();
      
      protected const messageField:UIAutoTextField = new UIAutoTextField();
      
      private var closeButton:UIButton;
      
      private var darkBackGround:DarkBackgroundElementWindow;
      
      private var saleSlot:CouponSalesSlot;
      
      private var couponData:CouponData;
      
      private var battleResults:BattleResults;
      
      public function CouponFoundScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_coupon"));
         this.closeButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Close",this.closeCallback,null);
         this.darkBackGround = new DarkBackgroundElementWindow(this._design,param1,null,null,true);
         this.darkBackGround.setVisible(true);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         var _loc2_:MovieClip = getDesignMovieClip();
         this.battleResults = param1[0];
         this.couponData = param1[1];
         this.saleSlot = new CouponSalesSlot(_loc2_.Slot_01,this,this.couponData);
         this.headerField.setTextField(_loc2_.Text_Header);
         this.messageField.setTextField(_loc2_.Text_Message);
         this.headerField.setText(ProjectManager.getText("COUPON_POPUP_HEADER"));
         this.messageField.setText(ProjectManager.getText("COUPON_POPUP_TEXT"));
      }
      
      override public function dispose() : void
      {
         this.closeButton.dispose();
         this.closeButton = null;
         this.darkBackGround.dispose();
         this.darkBackGround = null;
         this.saleSlot.dispose();
         this.saleSlot = null;
         super.dispose();
      }
      
      private function closeCallback(param1:MouseEvent) : void
      {
         close(_game.currentStateParent);
      }
      
      private function get couponFoundLogic() : CouponFoundLogic
      {
         return logic;
      }
   }
}

