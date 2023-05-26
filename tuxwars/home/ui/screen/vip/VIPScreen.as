package tuxwars.home.ui.screen.vip
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.vip.VIPLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class VIPScreen extends TuxUIScreen
   {
       
      
      private const VIP_SCREEN:String = "popup_membership";
      
      private var buttonClose:UIButton;
      
      private var titleText:UIAutoTextField;
      
      private var benefitsText:UIAutoTextField;
      
      private var benefits1Text:UIAutoTextField;
      
      private var benefits2Text:UIAutoTextField;
      
      private var timeText:UIAutoTextField;
      
      private var _membershipContainers1:MembershipContainers;
      
      private var _membershipContainers2:MembershipContainers;
      
      private var _membershipContainers3:MembershipContainers;
      
      private var gotPRICE1ID:Boolean;
      
      private var gotPRICE2ID:Boolean;
      
      private var gotPRICE3ID:Boolean;
      
      public function VIPScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_membership"));
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeScreen);
         titleText = TuxUiUtils.createAutoTextField(this._design.Text_Header,"VIP_HEADER");
         _membershipContainers1 = new MembershipContainers(this._design.Container_Slots_Membership1,game,this,1);
         _membershipContainers2 = new MembershipContainers(this._design.Container_Slots_Membership2,game,this,2);
         _membershipContainers3 = new MembershipContainers(this._design.Container_Slots_Membership3,game,this,3);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         buttonClose.dispose();
         buttonClose = null;
         titleText = null;
         _membershipContainers1.dispose();
         _membershipContainers1 = null;
         _membershipContainers2.dispose();
         _membershipContainers2 = null;
         _membershipContainers3.dispose();
         _membershipContainers3 = null;
         super.dispose();
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         switch(tuxGame.player.vipMembership.boughtPackId)
         {
            case "Price1":
               gotPRICE1ID = true;
               gotPRICE2ID = false;
               gotPRICE3ID = false;
               break;
            case "Price2":
               gotPRICE1ID = false;
               gotPRICE2ID = true;
               gotPRICE3ID = false;
               break;
            case "Price3":
               gotPRICE1ID = false;
               gotPRICE2ID = false;
               gotPRICE3ID = true;
         }
         trace("tuxGame.player.vipMembership.boughtPackId:" + tuxGame.player.vipMembership.boughtPackId);
         disableOtherButtons(tuxGame.player.vipMembership.boughtPackId);
         _membershipContainers1.init(tuxGame.player.vipMembership,gotPRICE1ID);
         _membershipContainers2.init(tuxGame.player.vipMembership,gotPRICE2ID);
         _membershipContainers3.init(tuxGame.player.vipMembership,gotPRICE3ID);
      }
      
      public function get memberShipContainer1() : MembershipContainers
      {
         return _membershipContainers1;
      }
      
      public function get memberShipContainer2() : MembershipContainers
      {
         return _membershipContainers2;
      }
      
      public function get memberShipContainer3() : MembershipContainers
      {
         return _membershipContainers3;
      }
      
      public function get vipLogic() : VIPLogic
      {
         return logic as VIPLogic;
      }
      
      private function closeScreen(event:MouseEvent) : void
      {
         vipLogic.exit();
      }
      
      public function disableOtherButtons(id:String) : void
      {
         switch(id)
         {
            case "Price1":
               _membershipContainers2.enableButton(false);
               _membershipContainers3.enableButton(false);
               break;
            case "Price2":
               _membershipContainers1.enableButton(false);
               _membershipContainers3.enableButton(false);
               break;
            case "Price3":
               _membershipContainers2.enableButton(false);
               _membershipContainers1.enableButton(false);
         }
      }
      
      public function updateButtonState(id:String) : void
      {
         switch(id)
         {
            case "Price1":
               _membershipContainers1.updateButtonState();
               break;
            case "Price2":
               _membershipContainers2.updateButtonState();
               break;
            case "Price3":
               _membershipContainers3.updateButtonState();
         }
      }
      
      public function geBoughtPriceID(value:String) : Boolean
      {
         switch(value)
         {
            case "Price1":
               return true;
            case "Price2":
               return true;
            case "Price3":
               return true;
            default:
               return false;
         }
      }
   }
}
