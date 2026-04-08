package tuxwars.home.ui.screen.privategame.host
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import com.dchoc.ui.spinner.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.*;
   import tuxwars.data.*;
   import tuxwars.home.ui.logic.privategame.host.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
   public class HostPrivateGameSettingsScreen extends TuxUIScreen
   {
      private const map:UIAutoTextField = new UIAutoTextField();
      
      private var closeButton:UIButton;
      
      private var cancelButton:UIButton;
      
      private var resetButton:UIButton;
      
      private var confirmButton:UIButton;
      
      private var objectContainer:ObjectContainer;
      
      private var turnSpinner:UISpinner;
      
      private var matchSpinner:UISpinner;
      
      public function HostPrivateGameSettingsScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_settings"));
         var _loc2_:MovieClip = getDesignMovieClip();
         TuxUiUtils.createAutoTextField(_loc2_.Text_Header,"GAME_SETTINGS_HEADER");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Setting_Map,"GAME_SETTINGS_MAP");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Setting_Turn,"GAME_SETTINGS_TURN_TIME");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Setting_Match,"GAME_SETTINGS_MATCH_TIME");
         this.map.setTextField(_loc2_.Text_Setting_Map_Value);
         this.map.setText("");
         this.closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",this.closeCallback);
         this.cancelButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Cancel",this.closeCallback,"BUTTON_CANCEL");
         this.resetButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Reset",this.resetCallback,"BUTTON_RESET");
         this.confirmButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Confirm",this.confirmCallback,"BUTTON_CONFIRM");
         this.objectContainer = new ObjectContainer(_loc2_,param1,this.getSlotButton,"transition_maps_left","transition_maps_right");
         this.objectContainer.radialGroup.addEventListener("selection_changed",this.mapSelectionChanged,false,0,true);
         this.turnSpinner = new UISpinner(_loc2_.Text_Setting_Turn_Setting);
         this.matchSpinner = new UISpinner(_loc2_.Text_Setting_Match_Setting);
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.reset();
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         this.closeButton.dispose();
         this.closeButton = null;
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.resetButton.dispose();
         this.resetButton = null;
         this.confirmButton.dispose();
         this.confirmButton = null;
         this.objectContainer.radialGroup.removeEventListener("selection_changed",this.mapSelectionChanged,false);
         this.objectContainer.dispose();
         this.objectContainer = null;
         super.dispose();
      }
      
      private function confirmCallback(param1:MouseEvent) : void
      {
         this.settingsLogic.updateModel(this.objectContainer.getSelectedObject(),this.matchSpinner.currentValue,this.turnSpinner.currentValue);
         this.settingsLogic.exit();
      }
      
      private function resetCallback(param1:MouseEvent) : void
      {
         this.reset();
      }
      
      private function closeCallback(param1:MouseEvent) : void
      {
         this.settingsLogic.exit();
      }
      
      private function mapSelectionChanged(param1:UIRadialGroupEvent) : void
      {
         var _loc2_:* = this.objectContainer.getSelectedObject();
         this.map.setText(ProjectManager.getText(_loc2_ is String ? _loc2_ : _loc2_.tid));
         this.updateMapIconForMap(_loc2_ is String ? "RANDOM" : _loc2_.id);
      }
      
      private function reset() : void
      {
         this.map.setText(ProjectManager.getText(this.gameModel.matchData.mapId));
         this.objectContainer.init(this.settingsLogic.getLevels(),false);
         this.objectContainer.showObjectAtIndex(this.settingsLogic.indexForMapId(this.gameModel.matchData.mapId) + 1);
         this.updateMapIconForMap(this.gameModel.matchData.mapId);
         this.turnSpinner.minValue = BattleOptions.getMinTurnTime();
         this.turnSpinner.maxValue = BattleOptions.getMaxTurnTime();
         this.turnSpinner.increment = BattleOptions.getTurnTimeIncrement();
         this.turnSpinner.currentValue = this.gameModel.matchData.turnTime;
         this.matchSpinner.minValue = BattleOptions.getMinMatchTime();
         this.matchSpinner.maxValue = BattleOptions.getMaxMatchTime();
         this.matchSpinner.currentValue = this.gameModel.matchData.matchTime;
      }
      
      private function updateMapIconForMap(param1:String) : void
      {
         var _loc2_:LevelData = Levels.findLevelData(param1);
         if(_loc2_)
         {
            this.updateMapIcon(_loc2_.swf,_loc2_.export);
         }
         else
         {
            this.updateMapIcon("flash/ui/icons_maps.swf","icon_map_random");
         }
      }
      
      private function updateMapIcon(param1:String, param2:String) : void
      {
         DCUtils.removeChildren(this._design.Container_Icon);
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF(param1,param2);
         if(_loc3_)
         {
            this._design.Container_Icon.addChild(_loc3_);
         }
      }
      
      private function getSlotButton(param1:int, param2:*, param3:MovieClip) : *
      {
         return new LevelButtonContainers(param3,this,param2);
      }
      
      private function get gameModel() : PrivateGameModel
      {
         return params as PrivateGameModel;
      }
      
      private function get settingsLogic() : HostPrivateGameSettingsLogic
      {
         return logic as HostPrivateGameSettingsLogic;
      }
   }
}

