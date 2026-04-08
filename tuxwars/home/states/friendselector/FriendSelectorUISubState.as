package tuxwars.home.states.friendselector
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.friendselector.*;
   import tuxwars.home.ui.screen.friendselector.*;
   import tuxwars.net.*;
   
   public class FriendSelectorUISubState extends TuxUIState
   {
      public function FriendSelectorUISubState(param1:TuxWarsGame, param2:* = null)
      {
         var _loc3_:Class = null;
         if(SendRequestObject(param2).type == "GIFT")
         {
            _loc3_ = FriendSelectorGiftScreen;
         }
         else
         {
            _loc3_ = FriendSelectorInviteScreen;
         }
         super(_loc3_,FriendSelectorLogic,param1,param2);
      }
   }
}

