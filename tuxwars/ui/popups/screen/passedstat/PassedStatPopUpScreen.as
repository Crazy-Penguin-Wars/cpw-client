package tuxwars.ui.popups.screen.passedstat
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.passedstat.PassedStatData;
   import tuxwars.ui.popups.logic.passedstat.PassedStatPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.*;
   
   public class PassedStatPopUpScreen extends PopUpBaseScreen
   {
      private var playerSlot:PlayerSlot;
      
      private var rivalSlot:PlayerSlot;
      
      public function PassedStatPopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_leaderboards");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         var _loc2_:String = this.getCategoryTid(this.passedStatData.stat);
         messageField.setText(ProjectManager.getText("LEADERBOARD_POPUP_MESSAGE",[this.passedStatLogic.passedFriend.name,ProjectManager.getText(_loc2_)]));
         TuxUiUtils.createAutoTextField(this._design.Text_Header,"LEADERBOARD_POPUP_HEADER");
         TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Place,this.passedStatData.newPosition.toString());
         TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Value,this.passedStatData.newValue.toString());
         TuxUiUtils.createAutoTextField(this._design.Text_Category,_loc2_);
         okButton.setText(ProjectManager.getText("BUTTON_SHARE"));
         this.playerSlot = new PlayerSlot(this._design.Slots.Slot_Player,tuxGame.player);
         this.rivalSlot = new PlayerSlot(this._design.Slots.Slot_Rival,this.passedStatLogic.passedFriend);
         this._design.Slots.gotoAndPlay(0);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("facebookFeedPostedCallback",this.feedPosted);
         this.playerSlot.dispose();
         this.playerSlot = null;
         this.rivalSlot.dispose();
         this.rivalSlot = null;
         super.dispose();
      }
      
      private function getCategoryTid(param1:String) : String
      {
         switch(param1)
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
      
      override protected function okPressed(param1:MouseEvent) : void
      {
         this.passedStatLogic.postFeed();
         MessageCenter.addListener("facebookFeedPostedCallback",this.feedPosted);
      }
      
      public function feedPosted(param1:Message) : void
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

