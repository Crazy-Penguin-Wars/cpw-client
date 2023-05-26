package tuxwars.battle.ui.logic.chat
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.messages.chat.ChatMessage;
   import tuxwars.battle.ui.screen.chat.ChatElementScreen;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.player.Player;
   import tuxwars.states.TuxState;
   
   public class ChatLogic extends TuxUILogic
   {
       
      
      public function ChatLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         MessageCenter.addListener("BattleResponse",chatResponseHandler);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("BattleResponse",chatResponseHandler);
         super.dispose();
      }
      
      public function sendMessage(text:String) : void
      {
         var _loc2_:ProfanityFilter = ProfanityFilter;
         §§push(MessageCenter);
         §§push(§§findproperty(ChatMessage));
         §§push(game.player.id);
         if(!tuxwars.battle.ui.logic.chat.ProfanityFilter._instance)
         {
            tuxwars.battle.ui.logic.chat.ProfanityFilter._instance = new tuxwars.battle.ui.logic.chat.ProfanityFilter();
         }
         §§pop().sendEvent(new §§pop().ChatMessage(§§pop(),tuxwars.battle.ui.logic.chat.ProfanityFilter._instance.filterString(text)));
      }
      
      private function chatResponseHandler(response:BattleResponse) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(response.responseType == 33)
         {
            _loc2_ = response.data;
            _loc3_ = !!_loc2_.tid ? ProjectManager.getText(_loc2_.tid) : _loc2_.text;
            _loc4_ = getPlayerName(_loc2_.id);
            if(_loc4_ != null)
            {
               chatElementScreen.addMessage(_loc2_.id,_loc4_,_loc3_,_loc2_.tid != null);
            }
         }
      }
      
      private function getPlayerName(id:String) : String
      {
         var _loc2_:Player = BattleManager.findPlayer(id);
         return !!_loc2_ ? _loc2_.name : null;
      }
      
      private function get chatElementScreen() : ChatElementScreen
      {
         return screen;
      }
   }
}
