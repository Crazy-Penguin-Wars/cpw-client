package tuxwars.home.ui.screen.home
{
   import tuxwars.home.ui.screenhandlers.IScreen;
   
   public interface IHomeScreen extends IScreen
   {
       
      
      function setDarkBackground(param1:Boolean, param2:*, param3:Boolean) : void;
      
      function refreshFriends() : void;
   }
}
