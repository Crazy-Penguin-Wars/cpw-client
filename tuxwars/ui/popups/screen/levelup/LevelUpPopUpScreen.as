package tuxwars.ui.popups.screen.levelup
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.result.awards.container.*;
   import tuxwars.items.data.ItemData;
   import tuxwars.net.*;
   import tuxwars.ui.popups.logic.levelup.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.*;
   
   public class LevelUpPopUpScreen extends PopUpBaseScreen
   {
      private var levelNumber:UIAutoTextField;
      
      private var lootContainer:ItemContainers;
      
      private var saleSlot:LevelUpSalesSlot;
      
      private var rewardContainer:ItemContainers;
      
      public function LevelUpPopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf",!!LevelUpSalesSlot.hasSaleWithPlayer(param1.player) ? "popup_levelup_reward_with_ad" : "popup_levelup_reward");
      }
      
      override public function init(param1:*) : void
      {
         var _loc2_:String = null;
         super.init(param1);
         headerField.setText(ProjectManager.getText("Level_Up_Title"));
         this.levelNumber = TuxUiUtils.createAutoTextFieldWithText(getDesignMovieClip().getChildByName("Text_Level") as TextField,this.levelReached.toString());
         CRMService.sendEvent("Level","Level Up","Reached",null,null,this.levelReached);
         this.lootContainer = new ItemContainers(this._design.getChildByName("Container_Items") as MovieClip,_game);
         okButton.setText(ProjectManager.getText("BUTTON_SHARE"));
         this._design.Text_Description.text = ProjectManager.getText("LEVEL_UP_SHARE_DESCRIPTION");
         this.rewardContainer = new ItemContainers(this._design.getChildByName("Container_Rewards") as MovieClip,_game);
         this.lootContainer.init(this.getLogic().unlockedItems);
         if(Boolean(this.getLogic().unlockedItems) && this.getLogic().unlockedItems.length > 0)
         {
            _loc2_ = ProjectManager.getText("Level_Up_Desc");
         }
         else
         {
            _loc2_ = ProjectManager.getText("NEW_LEVEL_NO_UNLOCK");
         }
         messageField.setText(_loc2_);
         if(LevelUpSalesSlot.hasSale(this.levelReached))
         {
            this.saleSlot = new LevelUpSalesSlot(this._design.ad,this,tuxGame.player,this.levelReached);
         }
      }
      
      public function initRewardContainer(param1:Vector.<ItemData>) : void
      {
         this.rewardContainer.init(param1);
      }
      
      override public function dispose() : void
      {
         if(this.saleSlot)
         {
            this.saleSlot.dispose();
            this.saleSlot = null;
         }
         MessageCenter.sendMessage("ClearLevelUpSale");
         super.dispose();
      }
      
      override protected function okPressed(param1:MouseEvent) : void
      {
         FeedService.publishMessage("Brag",[this.levelReached.toString()]);
         super.okPressed(param1);
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

