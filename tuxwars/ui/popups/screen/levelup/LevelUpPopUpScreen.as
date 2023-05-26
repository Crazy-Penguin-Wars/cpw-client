package tuxwars.ui.popups.screen.levelup
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.result.awards.container.ItemContainers;
   import tuxwars.items.data.ItemData;
   import tuxwars.net.CRMService;
   import tuxwars.net.FeedService;
   import tuxwars.ui.popups.logic.levelup.LevelUpPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class LevelUpPopUpScreen extends PopUpBaseScreen
   {
       
      
      private var levelNumber:UIAutoTextField;
      
      private var lootContainer:ItemContainers;
      
      private var saleSlot:LevelUpSalesSlot;
      
      private var rewardContainer:ItemContainers;
      
      public function LevelUpPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf",LevelUpSalesSlot.hasSaleWithPlayer(game.player) ? "popup_levelup_reward_with_ad" : "popup_levelup_reward");
      }
      
      override public function init(params:*) : void
      {
         var desc:* = null;
         super.init(params);
         headerField.setText(ProjectManager.getText("Level_Up_Title"));
         levelNumber = TuxUiUtils.createAutoTextFieldWithText(getDesignMovieClip().getChildByName("Text_Level") as TextField,levelReached.toString());
         CRMService.sendEvent("Level","Level Up","Reached",null,null,levelReached);
         lootContainer = new ItemContainers(this._design.getChildByName("Container_Items") as MovieClip,_game);
         okButton.setText(ProjectManager.getText("BUTTON_SHARE"));
         this._design.Text_Description.text = ProjectManager.getText("LEVEL_UP_SHARE_DESCRIPTION");
         rewardContainer = new ItemContainers(this._design.getChildByName("Container_Rewards") as MovieClip,_game);
         lootContainer.init(getLogic().unlockedItems);
         if(getLogic().unlockedItems && getLogic().unlockedItems.length > 0)
         {
            desc = ProjectManager.getText("Level_Up_Desc");
         }
         else
         {
            desc = ProjectManager.getText("NEW_LEVEL_NO_UNLOCK");
         }
         messageField.setText(desc);
         if(LevelUpSalesSlot.hasSale(levelReached))
         {
            saleSlot = new LevelUpSalesSlot(this._design.ad,this,tuxGame.player,levelReached);
         }
      }
      
      public function initRewardContainer(data:Vector.<ItemData>) : void
      {
         rewardContainer.init(data);
      }
      
      override public function dispose() : void
      {
         if(saleSlot)
         {
            saleSlot.dispose();
            saleSlot = null;
         }
         MessageCenter.sendMessage("ClearLevelUpSale");
         super.dispose();
      }
      
      override protected function okPressed(event:MouseEvent) : void
      {
         FeedService.publishMessage("Brag",[levelReached.toString()]);
         super.okPressed(event);
      }
      
      public function get levelReached() : int
      {
         return params;
      }
      
      private function getLogic() : LevelUpPopUpLogic
      {
         return logic as LevelUpPopUpLogic;
      }
   }
}
