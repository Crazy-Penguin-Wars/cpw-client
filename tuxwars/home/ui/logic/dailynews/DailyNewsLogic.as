package tuxwars.home.ui.logic.dailynews
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.gifts.*;
   import tuxwars.home.states.inbox.*;
   import tuxwars.home.states.slotmachine.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.dailynews.DailyNewsScreen;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   
   public class DailyNewsLogic extends TuxUILogic
   {
      public function DailyNewsLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function exit() : void
      {
         CRMService.sendEvent("Game","Cpw_news","Clicked","CloseNews");
         super.close();
      }
      
      public function openGifts() : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Gifts","DailyNews");
         game.homeState.changeState(new GiftState(game));
      }
      
      public function openInbox() : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Inbox","DailyNews");
         game.homeState.changeState(new InboxState(game));
      }
      
      public function openSlotMachine() : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","SlotMachine","DailyNews");
         game.homeState.changeState(new SlotMachineState(game));
      }
      
      private function get dailyNewsScreen() : DailyNewsScreen
      {
         return screen;
      }
   }
}

