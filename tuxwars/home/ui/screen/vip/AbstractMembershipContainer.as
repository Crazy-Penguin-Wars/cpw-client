package tuxwars.home.ui.screen.vip
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.player.VIPMembership;
   import tuxwars.utils.*;
   
   public class AbstractMembershipContainer extends UIContainer
   {
      private var _membershipText:UIAutoTextField;
      
      private var _statusText:UIAutoTextField;
      
      private var _subscriptionText:UIAutoTextField;
      
      public function AbstractMembershipContainer(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1,param2);
         this._membershipText = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Membership);
         this._statusText = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Status);
         this._subscriptionText = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Subscription);
      }
      
      public function init(param1:VIPMembership) : void
      {
      }
      
      override public function dispose() : void
      {
         this._membershipText = null;
         this._statusText = null;
         this._subscriptionText = null;
         super.dispose();
      }
      
      public function set membershipText(param1:String) : void
      {
         this._membershipText.setText(param1);
      }
      
      public function set statusText(param1:String) : void
      {
         this._statusText.setText(param1);
      }
      
      public function set subscriptionText(param1:String) : void
      {
         this._subscriptionText.setText(param1);
      }
   }
}

