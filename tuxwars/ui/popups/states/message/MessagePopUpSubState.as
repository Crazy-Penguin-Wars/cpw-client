package tuxwars.ui.popups.states.message
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.screen.message.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class MessagePopUpSubState extends PopUpBaseSubState
   {
      public static const TYPE:String = "MessageType";
      
      public function MessagePopUpSubState(param1:TuxWarsGame, param2:Class, param3:* = null)
      {
         super("MessageType",param1,MessagePopUpScreen,param2,AssetsData.getMessagePopupAssets(),param3);
      }
   }
}

