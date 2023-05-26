package tuxwars.home.ui.screen.vip
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.TextUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.items.ClothingItem;
   import tuxwars.player.VIPMembership;
   import tuxwars.utils.TuxUiUtils;
   
   public class ActiveMembershipContainer extends AbstractMembershipContainer
   {
      
      private static const AVATAR_CONTAINER:String = "Container_Character";
       
      
      private var timeText:UIAutoTextField;
      
      private var membership:VIPMembership;
      
      private var avatar:TuxAvatar;
      
      private var game:TuxWarsGame;
      
      public function ActiveMembershipContainer(design:MovieClip, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,parent);
         this.game = game;
         timeText = TuxUiUtils.createAutoTextFieldWithText(design.Text_Time);
         setupAvatar(design.getChildByName("Container_Character") as MovieClip);
      }
      
      override public function init(membership:VIPMembership) : void
      {
         super.init(membership);
         this.membership = membership;
         timeText.setText(TextUtils.getTimeTextFromSeconds(membership.timeLeft));
         membershipText = ProjectManager.getText("VIP_MEMBERSHIP_HEADER");
         statusText = ProjectManager.getText("VIP_MEMBERSHIP_STATUS_ACTIVE");
         subscriptionText = ProjectManager.getText("VIP_MEMBERSHIP_SUBSCRIPTION_ACTIVE");
         if(membership.vip)
         {
            LogicUpdater.register(this,"ActiveMembershipContainer");
         }
      }
      
      override public function dispose() : void
      {
         timeText = null;
         avatar.dispose();
         avatar = null;
         LogicUpdater.unregister(this,"ActiveMembershipContainer");
         super.dispose();
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         timeText.setText(TextUtils.getTimeTextFromSeconds(membership.timeLeft));
      }
      
      private function setupAvatar(container:MovieClip) : void
      {
         avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         avatar.animate(new AvatarAnimation("idle"));
         container.addChild(avatar);
         var _loc2_:Object = game.player.wornItemsContainer.getWornItems();
         for each(var item in _loc2_)
         {
            if(item)
            {
               avatar.wearClothing(item);
            }
         }
      }
   }
}
