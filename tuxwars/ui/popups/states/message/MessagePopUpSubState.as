package tuxwars.ui.popups.states.message
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.screen.message.MessagePopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class MessagePopUpSubState extends PopUpBaseSubState
   {
      
      public static const TYPE:String = "MessageType";
       
      
      public function MessagePopUpSubState(game:TuxWarsGame, logic:Class, params:* = null)
      {
         super("MessageType",game,MessagePopUpScreen,logic,AssetsData.getMessagePopupAssets(),params);
      }
   }
}
