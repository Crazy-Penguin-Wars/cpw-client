package tuxwars.home.ui.screen.vip
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.vip.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.utils.*;
   
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
      
      public function VIPScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_membership"));
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         this.buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",this.closeScreen);
         this.titleText = TuxUiUtils.createAutoTextField(this._design.Text_Header,"VIP_HEADER");
         this._membershipContainers1 = new MembershipContainers(this._design.Container_Slots_Membership1,param1,this,1);
         this._membershipContainers2 = new MembershipContainers(this._design.Container_Slots_Membership2,param1,this,2);
         this._membershipContainers3 = new MembershipContainers(this._design.Container_Slots_Membership3,param1,this,3);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         this.buttonClose.dispose();
         this.buttonClose = null;
         this.titleText = null;
         this._membershipContainers1.dispose();
         this._membershipContainers1 = null;
         this._membershipContainers2.dispose();
         this._membershipContainers2 = null;
         this._membershipContainers3.dispose();
         this._membershipContainers3 = null;
         super.dispose();
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         switch(tuxGame.player.vipMembership.boughtPackId)
         {
            case "Price1":
               this.gotPRICE1ID = true;
               this.gotPRICE2ID = false;
               this.gotPRICE3ID = false;
               break;
            case "Price2":
               this.gotPRICE1ID = false;
               this.gotPRICE2ID = true;
               this.gotPRICE3ID = false;
               break;
            case "Price3":
               this.gotPRICE1ID = false;
               this.gotPRICE2ID = false;
               this.gotPRICE3ID = true;
         }
         trace("tuxGame.player.vipMembership.boughtPackId:" + tuxGame.player.vipMembership.boughtPackId);
         this.disableOtherButtons(tuxGame.player.vipMembership.boughtPackId);
         this._membershipContainers1.init(tuxGame.player.vipMembership,this.gotPRICE1ID);
         this._membershipContainers2.init(tuxGame.player.vipMembership,this.gotPRICE2ID);
         this._membershipContainers3.init(tuxGame.player.vipMembership,this.gotPRICE3ID);
      }
      
      public function get memberShipContainer1() : MembershipContainers
      {
         return this._membershipContainers1;
      }
      
      public function get memberShipContainer2() : MembershipContainers
      {
         return this._membershipContainers2;
      }
      
      public function get memberShipContainer3() : MembershipContainers
      {
         return this._membershipContainers3;
      }
      
      public function get vipLogic() : VIPLogic
      {
         return logic as VIPLogic;
      }
      
      private function closeScreen(param1:MouseEvent) : void
      {
         this.vipLogic.exit();
      }
      
      public function disableOtherButtons(param1:String) : void
      {
         switch(param1)
         {
            case "Price1":
               this._membershipContainers2.enableButton(false);
               this._membershipContainers3.enableButton(false);
               break;
            case "Price2":
               this._membershipContainers1.enableButton(false);
               this._membershipContainers3.enableButton(false);
               break;
            case "Price3":
               this._membershipContainers2.enableButton(false);
               this._membershipContainers1.enableButton(false);
         }
      }
      
      public function updateButtonState(param1:String) : void
      {
         switch(param1)
         {
            case "Price1":
               this._membershipContainers1.updateButtonState();
               break;
            case "Price2":
               this._membershipContainers2.updateButtonState();
               break;
            case "Price3":
               this._membershipContainers3.updateButtonState();
         }
      }
      
      public function geBoughtPriceID(param1:String) : Boolean
      {
         switch(param1)
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

