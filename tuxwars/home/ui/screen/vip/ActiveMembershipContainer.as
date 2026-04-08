package tuxwars.home.ui.screen.vip
{
   import com.dchoc.avatar.*;
   import com.dchoc.game.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.player.VIPMembership;
   import tuxwars.utils.*;
   
   public class ActiveMembershipContainer extends AbstractMembershipContainer
   {
      private static const AVATAR_CONTAINER:String = "Container_Character";
      
      private var timeText:UIAutoTextField;
      
      private var membership:VIPMembership;
      
      private var avatar:TuxAvatar;
      
      private var game:TuxWarsGame;
      
      public function ActiveMembershipContainer(param1:MovieClip, param2:TuxWarsGame, param3:UIComponent = null)
      {
         super(param1,param3);
         this.game = param2;
         this.timeText = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Time);
         this.setupAvatar(param1.getChildByName("Container_Character") as MovieClip);
      }
      
      override public function init(param1:VIPMembership) : void
      {
         super.init(param1);
         this.membership = param1;
         this.timeText.setText(TextUtils.getTimeTextFromSeconds(param1.timeLeft));
         membershipText = ProjectManager.getText("VIP_MEMBERSHIP_HEADER");
         statusText = ProjectManager.getText("VIP_MEMBERSHIP_STATUS_ACTIVE");
         subscriptionText = ProjectManager.getText("VIP_MEMBERSHIP_SUBSCRIPTION_ACTIVE");
         if(param1.vip)
         {
            LogicUpdater.register(this,"ActiveMembershipContainer");
         }
      }
      
      override public function dispose() : void
      {
         this.timeText = null;
         this.avatar.dispose();
         this.avatar = null;
         LogicUpdater.unregister(this,"ActiveMembershipContainer");
         super.dispose();
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.timeText.setText(TextUtils.getTimeTextFromSeconds(this.membership.timeLeft));
      }
      
      private function setupAvatar(param1:MovieClip) : void
      {
         var _loc3_:* = undefined;
         this.avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         this.avatar.animate(new AvatarAnimation("idle"));
         param1.addChild(this.avatar);
         var _loc2_:Object = this.game.player.wornItemsContainer.getWornItems();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_)
            {
               this.avatar.wearClothing(_loc3_);
            }
         }
      }
   }
}

