package tuxwars.battle.ui.screen
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.chat.*;
   import tuxwars.battle.ui.screen.ingamebetting.*;
   import tuxwars.battle.ui.screen.tab.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
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
      
      public function BottomElement(param1:MovieClip, param2:TuxWarsGame, param3:BattleHudScreen)
      {
         super();
         this.game = param2;
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","ingame_hud");
         this._design = _loc4_.getChildByName("Bottom") as MovieClip;
         this._design.mouseEnabled = false;
         this._tabElement = new BattleHudTabElement(this._design,param2,param3.playerTimerContainer,param3.matchTimeElement);
         this._controlsElement = new BattleHudControlsElementScreen(this._design,param2);
         this._chatElement = new ChatElementScreen(this._design,param2);
         this._ingameBettingElement = new IngameBettingScreen(this._design.getChildByName("Betting") as MovieClip,param2);
         this.toolsElementScreen = new ToolsElementScreen(this._design,param2);
         this.optionsButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Options",this.toolsElementScreen.optionsCallback);
         TuxUiUtils.setMovieClipPosition(this._design,"bottom","center");
         param1.addChild(this._design);
      }
      
      public function logicUpdate(param1:int) : void
      {
         this._controlsElement.logicUpdate(param1);
         this._tabElement.logicUpdate(param1);
         this._chatElement.logicUpdate(param1);
         this._ingameBettingElement.logicUpdate(param1);
      }
      
      public function dispose() : void
      {
         this._tabElement.dispose();
         this._tabElement = null;
         this._controlsElement.dispose();
         this._controlsElement = null;
         this._chatElement.dispose();
         this._chatElement = null;
         this._ingameBettingElement.dispose();
         this._ingameBettingElement = null;
         this.toolsElementScreen.dispose();
         this.toolsElementScreen = null;
         this.optionsButton.dispose();
         this.optionsButton = null;
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      public function get chatElementScreen() : ChatElementScreen
      {
         return this._chatElement;
      }
      
      public function get ingameBettingElement() : IngameBettingScreen
      {
         return this._ingameBettingElement;
      }
      
      public function get controlsElement() : BattleHudControlsElementScreen
      {
         return this._controlsElement;
      }
      
      public function fullscreenChanged(param1:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(this._design,"bottom","center");
         this.toolsElementScreen.fullscreenChanged(param1);
      }
      
      public function set logic(param1:*) : void
      {
         this._tabElement.logic = param1;
         this._controlsElement.logic = param1;
         this._chatElement.logic = param1.getChatLogic();
         this._ingameBettingElement.logic = param1;
      }
   }
}

