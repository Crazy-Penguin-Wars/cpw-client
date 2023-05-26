package tuxwars.battle.ui.screen
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.chat.ChatElementScreen;
   import tuxwars.battle.ui.screen.ingamebetting.IngameBettingScreen;
   import tuxwars.battle.ui.screen.tab.BattleHudTabElement;
   import tuxwars.ui.components.ToolsElementScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class BottomElement
   {
      
      private static const BOTTOM:String = "Bottom";
      
      private static const BETTING:String = "Betting";
      
      private static const EXIT_BUTTON:String = "Button_Exit";
      
      private static const BUTTON_OPTIONS:String = "Button_Options";
       
      
      private var toolsElementScreen:ToolsElementScreen;
      
      private var optionsButton:UIButton;
      
      private var _tabElement:BattleHudTabElement;
      
      private var _controlsElement:BattleHudControlsElementScreen;
      
      private var _chatElement:ChatElementScreen;
      
      private var _ingameBettingElement:IngameBettingScreen;
      
      private var _design:MovieClip;
      
      private var game:TuxWarsGame;
      
      public function BottomElement(whereToAdd:MovieClip, game:TuxWarsGame, battleHud:BattleHudScreen)
      {
         super();
         this.game = game;
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","ingame_hud");
         _design = _loc4_.getChildByName("Bottom") as MovieClip;
         _design.mouseEnabled = false;
         _tabElement = new BattleHudTabElement(_design,game,battleHud.playerTimerContainer,battleHud.matchTimeElement);
         _controlsElement = new BattleHudControlsElementScreen(_design,game);
         _chatElement = new ChatElementScreen(_design,game);
         _ingameBettingElement = new IngameBettingScreen(_design.getChildByName("Betting") as MovieClip,game);
         toolsElementScreen = new ToolsElementScreen(_design,game);
         optionsButton = TuxUiUtils.createButton(UIButton,_design,"Button_Options",toolsElementScreen.optionsCallback);
         TuxUiUtils.setMovieClipPosition(_design,"bottom","center");
         whereToAdd.addChild(_design);
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         _controlsElement.logicUpdate(deltaTime);
         _tabElement.logicUpdate(deltaTime);
         _chatElement.logicUpdate(deltaTime);
         _ingameBettingElement.logicUpdate(deltaTime);
      }
      
      public function dispose() : void
      {
         _tabElement.dispose();
         _tabElement = null;
         _controlsElement.dispose();
         _controlsElement = null;
         _chatElement.dispose();
         _chatElement = null;
         _ingameBettingElement.dispose();
         _ingameBettingElement = null;
         toolsElementScreen.dispose();
         toolsElementScreen = null;
         optionsButton.dispose();
         optionsButton = null;
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      public function get chatElementScreen() : ChatElementScreen
      {
         return _chatElement;
      }
      
      public function get ingameBettingElement() : IngameBettingScreen
      {
         return _ingameBettingElement;
      }
      
      public function get controlsElement() : BattleHudControlsElementScreen
      {
         return _controlsElement;
      }
      
      public function fullscreenChanged(fullScreen:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(_design,"bottom","center");
         toolsElementScreen.fullscreenChanged(fullScreen);
      }
      
      public function set logic(logic:*) : void
      {
         _tabElement.logic = logic;
         _controlsElement.logic = logic;
         _chatElement.logic = logic.getChatLogic();
         _ingameBettingElement.logic = logic;
      }
   }
}
