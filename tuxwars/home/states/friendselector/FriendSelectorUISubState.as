package tuxwars.home.states.friendselector
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.friendselector.FriendSelectorLogic;
   import tuxwars.home.ui.screen.friendselector.FriendSelectorGiftScreen;
   import tuxwars.home.ui.screen.friendselector.FriendSelectorInviteScreen;
   import tuxwars.net.SendRequestObject;
   
   public class FriendSelectorUISubState extends TuxUIState
   {
       
      
      public function FriendSelectorUISubState(game:TuxWarsGame, params:* = null)
      {
         var c:* = null;
         if(SendRequestObject(params).type == "GIFT")
         {
            c = FriendSelectorGiftScreen;
         }
         else
         {
            c = FriendSelectorInviteScreen;
         }
         super(c,FriendSelectorLogic,game,params);
      }
   }
}
