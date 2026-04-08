package tuxwars.battle.ui.logic.chat
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.messages.chat.*;
   import tuxwars.battle.ui.screen.chat.ChatElementScreen;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.player.Player;
   import tuxwars.states.TuxState;
   
   public class ChatLogic extends TuxUILogic
   {
      public function ChatLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         MessageCenter.addListener("BattleResponse",this.chatResponseHandler);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("BattleResponse",this.chatResponseHandler);
         super.dispose();
      }
      
      public function sendMessage(param1:String) : void
      {
         if(!ProfanityFilter._instance)
         {
            ProfanityFilter._instance = new ProfanityFilter();
         }
         var _loc2_:String = ProfanityFilter._instance.filterString(param1);
         MessageCenter.sendEvent(new ChatMessage(game.player.id,_loc2_));
      }
      
      private function chatResponseHandler(param1:BattleResponse) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.responseType == 33)
         {
            _loc2_ = param1.data;
            _loc3_ = !!_loc2_.tid ? ProjectManager.getText(_loc2_.tid) : _loc2_.text;
            _loc4_ = this.getPlayerName(_loc2_.id);
            if(_loc4_ != null)
            {
               this.chatElementScreen.addMessage(_loc2_.id,_loc4_,_loc3_,_loc2_.tid != null);
            }
         }
      }
      
      private function getPlayerName(param1:String) : String
      {
         var _loc2_:Player = BattleManager.findPlayer(param1);
         return !!_loc2_ ? _loc2_.name : null;
      }
      
      private function get chatElementScreen() : ChatElementScreen
      {
         return screen;
      }
   }
}

