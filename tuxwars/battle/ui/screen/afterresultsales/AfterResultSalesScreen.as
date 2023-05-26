package tuxwars.battle.ui.screen.afterresultsales
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.ui.logic.afterresultsales.AfterResultSalesLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.DarkBackgroundElementWindow;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function AfterResultSalesScreen(game:TuxWarsGame)
      {
         super(game,new MovieClip());
         darkBackGround = new DarkBackgroundElementWindow(this._design,game,null,null,true);
         darkBackGround.setVisible(true);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         actionAfterClose = params[0];
         battleResults = params[1];
         winner = battleResults.getPosition(tuxGame.player.id) == 1;
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/popups.swf",winner ? "popup_winner" : "popup_looser");
         getDesignMovieClip().addChild(_loc2_);
         closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",closeCallback,null);
         storeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Store",storeCallback,"BUTTON_STORE");
         headerField.setTextField(_loc2_.Text_Header);
         messageField.setTextField(_loc2_.Text_Message);
         headerField.setText(ProjectManager.getText(winner ? "AFTER_RESULT_WINNNER_HEADER" : "AFTER_RESULT_LOSER_HEADER"));
         messageField.setText(ProjectManager.getText(winner ? "AFTER_RESULT_WINNNER_TEXT" : "AFTER_RESULT_LOSER_TEXT"));
         button1 = new SlotElement(_loc2_.Slot_01,_game,afterResultsSalesLogic.getShopItem(winner,1),this);
         button2 = new SlotElement(_loc2_.Slot_02,_game,afterResultsSalesLogic.getShopItem(winner,2),this);
         button3 = new SlotElement(_loc2_.Slot_03,_game,afterResultsSalesLogic.getShopItem(winner,3),this);
      }
      
      override public function dispose() : void
      {
         closeButton.dispose();
         closeButton = null;
         button1.dispose();
         button1 = null;
         button2.dispose();
         button2 = null;
         button3.dispose();
         button3 = null;
         darkBackGround.dispose();
         darkBackGround = null;
         super.dispose();
      }
      
      private function storeCallback(event:MouseEvent) : void
      {
         afterResultsSalesLogic.goToStore();
      }
      
      private function closeCallback(event:MouseEvent) : void
      {
         if(actionAfterClose == AfterResultSalesLogic.PLAY_AGAIN || actionAfterClose == AfterResultSalesLogic.PLAY_AGAIN_CUSTOM || actionAfterClose == AfterResultSalesLogic.PLAY_AGAIN_TOURNAMENT)
         {
            afterResultsSalesLogic.playAgain(battleResults);
         }
         else
         {
            afterResultsSalesLogic.goHome();
         }
      }
      
      private function get afterResultsSalesLogic() : AfterResultSalesLogic
      {
         return logic;
      }
   }
}
