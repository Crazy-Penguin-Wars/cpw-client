package tuxwars.battle.ui.screen.afterresultsales
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.ui.logic.afterresultsales.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.ui.containers.slotitem.*;
   import tuxwars.utils.*;
   
   public class AfterResultSalesScreen extends TuxUIScreen
   {
      private const BUTTONS:String = "Slot_0";
      
      private const POPUP_WINNER:String = "popup_winner";
      
      private const POPUP_LOSER:String = "popup_looser";
      
      protected const headerField:UIAutoTextField = new UIAutoTextField();
      
      protected const messageField:UIAutoTextField = new UIAutoTextField();
      
      protected var button1:UIComponent;
      
      protected var button2:UIComponent;
      
      protected var button3:UIComponent;
      
      protected var winner:Boolean;
      
      private var closeButton:UIButton;
      
      private var storeButton:UIButton;
      
      private var battleResults:BattleResults;
      
      private var actionAfterClose:int;
      
      private var darkBackGround:DarkBackgroundElementWindow;
      
      public function AfterResultSalesScreen(param1:TuxWarsGame)
      {
         super(param1,new MovieClip());
         this.darkBackGround = new DarkBackgroundElementWindow(this._design,param1,null,null,true);
         this.darkBackGround.setVisible(true);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.actionAfterClose = param1[0];
         this.battleResults = param1[1];
         this.winner = this.battleResults.getPosition(tuxGame.player.id) == 1;
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf",!!this.winner ? "popup_winner" : "popup_looser");
         getDesignMovieClip().addChild(_loc2_);
         this.closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",this.closeCallback,null);
         this.storeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Store",this.storeCallback,"BUTTON_STORE");
         this.headerField.setTextField(_loc2_.Text_Header);
         this.messageField.setTextField(_loc2_.Text_Message);
         this.headerField.setText(ProjectManager.getText(!!this.winner ? "AFTER_RESULT_WINNNER_HEADER" : "AFTER_RESULT_LOSER_HEADER"));
         this.messageField.setText(ProjectManager.getText(!!this.winner ? "AFTER_RESULT_WINNNER_TEXT" : "AFTER_RESULT_LOSER_TEXT"));
         this.button1 = new SlotElement(_loc2_.Slot_01,_game,this.afterResultsSalesLogic.getShopItem(this.winner,1),this);
         this.button2 = new SlotElement(_loc2_.Slot_02,_game,this.afterResultsSalesLogic.getShopItem(this.winner,2),this);
         this.button3 = new SlotElement(_loc2_.Slot_03,_game,this.afterResultsSalesLogic.getShopItem(this.winner,3),this);
      }
      
      override public function dispose() : void
      {
         this.closeButton.dispose();
         this.closeButton = null;
         this.button1.dispose();
         this.button1 = null;
         this.button2.dispose();
         this.button2 = null;
         this.button3.dispose();
         this.button3 = null;
         this.darkBackGround.dispose();
         this.darkBackGround = null;
         super.dispose();
      }
      
      private function storeCallback(param1:MouseEvent) : void
      {
         this.afterResultsSalesLogic.goToStore();
      }
      
      private function closeCallback(param1:MouseEvent) : void
      {
         if(this.actionAfterClose == AfterResultSalesLogic.PLAY_AGAIN || this.actionAfterClose == AfterResultSalesLogic.PLAY_AGAIN_CUSTOM || this.actionAfterClose == AfterResultSalesLogic.PLAY_AGAIN_TOURNAMENT)
         {
            this.afterResultsSalesLogic.playAgain(this.battleResults);
         }
         else
         {
            this.afterResultsSalesLogic.goHome();
         }
      }
      
      private function get afterResultsSalesLogic() : AfterResultSalesLogic
      {
         return logic;
      }
   }
}

