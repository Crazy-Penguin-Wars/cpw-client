package tuxwars.home.ui.screen.vip
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.player.VIPMembership;
   
   public class MembershipContainers extends UIContainers
   {
      
      public static const ACTIVE_CONTAINER:String = "ActiveContainer";
      
      public static const INACTIVE_CONTAINER:String = "InactiveContainer";
       
      
      public function MembershipContainers(design:MovieClip, game:TuxWarsGame, vipScreen:VIPScreen, no:int)
      {
         super();
         add("ActiveContainer",new ActiveMembershipContainer(design.Slot_Active,game));
         add("InactiveContainer",new InactiveMembershipContainer(design.Slot_Inactive,game,vipScreen,no));
      }
      
      public function init(membership:VIPMembership, boughtPackId:Boolean) : void
      {
         if(membership.vip)
         {
            ActiveMembershipContainer(getContainer("ActiveContainer")).init(membership);
         }
         if(boughtPackId)
         {
            trace("pack active");
            show(membership.vip ? "ActiveContainer" : "InactiveContainer",false);
         }
         else
         {
            show("InactiveContainer",false);
         }
      }
      
      public function enableButton(value:Boolean) : void
      {
         InactiveMembershipContainer(getContainer("InactiveContainer")).enableButton(value);
      }
      
      public function updateButtonState() : void
      {
         InactiveMembershipContainer(getContainer("InactiveContainer")).updateButtonState();
      }
   }
}
