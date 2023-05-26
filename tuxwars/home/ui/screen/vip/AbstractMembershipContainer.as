package tuxwars.home.ui.screen.vip
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.player.VIPMembership;
   import tuxwars.utils.TuxUiUtils;
   
   public class AbstractMembershipContainer extends UIContainer
   {
       
      
      private var _membershipText:UIAutoTextField;
      
      private var _statusText:UIAutoTextField;
      
      private var _subscriptionText:UIAutoTextField;
      
      public function AbstractMembershipContainer(design:MovieClip, parent:UIComponent = null)
      {
         super(design,parent);
         _membershipText = TuxUiUtils.createAutoTextFieldWithText(design.Text_Membership);
         _statusText = TuxUiUtils.createAutoTextFieldWithText(design.Text_Status);
         _subscriptionText = TuxUiUtils.createAutoTextFieldWithText(design.Text_Subscription);
      }
      
      public function init(membership:VIPMembership) : void
      {
      }
      
      override public function dispose() : void
      {
         _membershipText = null;
         _statusText = null;
         _subscriptionText = null;
         super.dispose();
      }
      
      public function set membershipText(value:String) : void
      {
         _membershipText.setText(value);
      }
      
      public function set statusText(value:String) : void
      {
         _statusText.setText(value);
      }
      
      public function set subscriptionText(value:String) : void
      {
         _subscriptionText.setText(value);
      }
   }
}
