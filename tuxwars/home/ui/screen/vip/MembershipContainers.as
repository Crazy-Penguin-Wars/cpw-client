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
      
      public function MembershipContainers(param1:MovieClip, param2:TuxWarsGame, param3:VIPScreen, param4:int)
      {
         super();
         add("ActiveContainer",new ActiveMembershipContainer(param1.Slot_Active,param2));
         add("InactiveContainer",new InactiveMembershipContainer(param1.Slot_Inactive,param2,param3,param4));
      }
      
      public function init(param1:VIPMembership, param2:Boolean) : void
      {
         if(param1.vip)
         {
            ActiveMembershipContainer(getContainer("ActiveContainer")).init(param1);
         }
         if(param2)
         {
            trace("pack active");
            show(param1.vip ? "ActiveContainer" : "InactiveContainer",false);
         }
         else
         {
            show("InactiveContainer",false);
         }
      }
      
      public function enableButton(param1:Boolean) : void
      {
         InactiveMembershipContainer(getContainer("InactiveContainer")).enableButton(param1);
      }
      
      public function updateButtonState() : void
      {
         InactiveMembershipContainer(getContainer("InactiveContainer")).updateButtonState();
      }
   }
}

