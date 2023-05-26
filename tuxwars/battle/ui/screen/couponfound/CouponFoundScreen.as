package tuxwars.battle.ui.screen.couponfound
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.ui.logic.couponfound.CouponFoundLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.DarkBackgroundElementWindow;
   import tuxwars.items.data.CouponData;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function CouponFoundScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/popups.swf","popup_coupon"));
         closeButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Close",closeCallback,null);
         darkBackGround = new DarkBackgroundElementWindow(this._design,game,null,null,true);
         darkBackGround.setVisible(true);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         var _loc2_:MovieClip = getDesignMovieClip();
         battleResults = params[0];
         couponData = params[1];
         saleSlot = new CouponSalesSlot(_loc2_.Slot_01,this,couponData);
         headerField.setTextField(_loc2_.Text_Header);
         messageField.setTextField(_loc2_.Text_Message);
         headerField.setText(ProjectManager.getText("COUPON_POPUP_HEADER"));
         messageField.setText(ProjectManager.getText("COUPON_POPUP_TEXT"));
      }
      
      override public function dispose() : void
      {
         closeButton.dispose();
         closeButton = null;
         darkBackGround.dispose();
         darkBackGround = null;
         saleSlot.dispose();
         saleSlot = null;
         super.dispose();
      }
      
      private function closeCallback(event:MouseEvent) : void
      {
         close(_game.currentStateParent);
      }
      
      private function get couponFoundLogic() : CouponFoundLogic
      {
         return logic;
      }
   }
}
