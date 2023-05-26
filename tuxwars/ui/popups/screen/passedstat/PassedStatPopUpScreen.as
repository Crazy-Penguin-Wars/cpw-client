package tuxwars.ui.popups.screen.passedstat
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.passedstat.PassedStatData;
   import tuxwars.ui.popups.logic.passedstat.PassedStatPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class PassedStatPopUpScreen extends PopUpBaseScreen
   {
       
      
      private var playerSlot:PlayerSlot;
      
      private var rivalSlot:PlayerSlot;
      
      public function PassedStatPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_leaderboards");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         var _loc2_:String = getCategoryTid(passedStatData.stat);
         messageField.setText(ProjectManager.getText("LEADERBOARD_POPUP_MESSAGE",[passedStatLogic.passedFriend.name,ProjectManager.getText(_loc2_)]));
         TuxUiUtils.createAutoTextField(this._design.Text_Header,"LEADERBOARD_POPUP_HEADER");
         TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Place,passedStatData.newPosition.toString());
         TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Value,passedStatData.newValue.toString());
         TuxUiUtils.createAutoTextField(this._design.Text_Category,_loc2_);
         okButton.setText(ProjectManager.getText("BUTTON_SHARE"));
         playerSlot = new PlayerSlot(this._design.Slots.Slot_Player,tuxGame.player);
         rivalSlot = new PlayerSlot(this._design.Slots.Slot_Rival,passedStatLogic.passedFriend);
         this._design.Slots.gotoAndPlay(0);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("facebookFeedPostedCallback",feedPosted);
         playerSlot.dispose();
         playerSlot = null;
         rivalSlot.dispose();
         rivalSlot = null;
         super.dispose();
      }
      
      private function getCategoryTid(stat:String) : String
      {
         switch(stat)
         {
            case "kills":
               return "CATEGORY_STAT_KILLS";
            case "wins":
               return "CATEGORY_STAT_WINS";
            case "avg_position":
               return "CATEGORY_STAT_AVERAGE_POSITIONS";
            case "coins":
               return "CATEGORY_STAT_COLLECTED_COINS";
            case "xp":
               return "CATEGORY_STAT_COLLECTED_EXP";
            case "score":
               return "CATEGORY_STAT_AVERAGE_SCORE";
            default:
               return "UNKNOWN_STAT";
         }
      }
      
      override protected function okPressed(event:MouseEvent) : void
      {
         passedStatLogic.postFeed();
         MessageCenter.addListener("facebookFeedPostedCallback",feedPosted);
      }
      
      public function feedPosted(msg:Message) : void
      {
         exit();
      }
      
      private function get passedStatLogic() : PassedStatPopUpLogic
      {
         return logic;
      }
      
      private function get passedStatData() : PassedStatData
      {
         return params;
      }
   }
}
