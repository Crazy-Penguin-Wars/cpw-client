package tuxwars.home.ui.screen.privategame.host
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import com.dchoc.ui.spinner.UISpinner;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.BattleOptions;
   import tuxwars.battle.data.LevelData;
   import tuxwars.battle.data.Levels;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.ui.logic.privategame.host.HostPrivateGameSettingsLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function HostPrivateGameSettingsScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_settings"));
         var _loc2_:MovieClip = getDesignMovieClip();
         TuxUiUtils.createAutoTextField(_loc2_.Text_Header,"GAME_SETTINGS_HEADER");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Setting_Map,"GAME_SETTINGS_MAP");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Setting_Turn,"GAME_SETTINGS_TURN_TIME");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Setting_Match,"GAME_SETTINGS_MATCH_TIME");
         map.setTextField(_loc2_.Text_Setting_Map_Value);
         map.setText("");
         closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",closeCallback);
         cancelButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Cancel",closeCallback,"BUTTON_CANCEL");
         resetButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Reset",resetCallback,"BUTTON_RESET");
         confirmButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Confirm",confirmCallback,"BUTTON_CONFIRM");
         objectContainer = new ObjectContainer(_loc2_,game,getSlotButton,"transition_maps_left","transition_maps_right");
         objectContainer.radialGroup.addEventListener("selection_changed",mapSelectionChanged,false,0,true);
         turnSpinner = new UISpinner(_loc2_.Text_Setting_Turn_Setting);
         matchSpinner = new UISpinner(_loc2_.Text_Setting_Match_Setting);
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         reset();
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         closeButton.dispose();
         closeButton = null;
         cancelButton.dispose();
         cancelButton = null;
         resetButton.dispose();
         resetButton = null;
         confirmButton.dispose();
         confirmButton = null;
         objectContainer.radialGroup.removeEventListener("selection_changed",mapSelectionChanged,false);
         objectContainer.dispose();
         objectContainer = null;
         super.dispose();
      }
      
      private function confirmCallback(event:MouseEvent) : void
      {
         settingsLogic.updateModel(objectContainer.getSelectedObject(),matchSpinner.currentValue,turnSpinner.currentValue);
         settingsLogic.exit();
      }
      
      private function resetCallback(event:MouseEvent) : void
      {
         reset();
      }
      
      private function closeCallback(event:MouseEvent) : void
      {
         settingsLogic.exit();
      }
      
      private function mapSelectionChanged(event:UIRadialGroupEvent) : void
      {
         var _loc2_:* = objectContainer.getSelectedObject();
         map.setText(ProjectManager.getText(_loc2_ is String ? _loc2_ : _loc2_.tid));
         updateMapIconForMap(_loc2_ is String ? "RANDOM" : _loc2_.id);
      }
      
      private function reset() : void
      {
         map.setText(ProjectManager.getText(gameModel.matchData.mapId));
         objectContainer.init(settingsLogic.getLevels(),false);
         objectContainer.showObjectAtIndex(settingsLogic.indexForMapId(gameModel.matchData.mapId) + 1);
         updateMapIconForMap(gameModel.matchData.mapId);
         turnSpinner.minValue = BattleOptions.getMinTurnTime();
         turnSpinner.maxValue = BattleOptions.getMaxTurnTime();
         turnSpinner.increment = BattleOptions.getTurnTimeIncrement();
         turnSpinner.currentValue = gameModel.matchData.turnTime;
         matchSpinner.minValue = BattleOptions.getMinMatchTime();
         matchSpinner.maxValue = BattleOptions.getMaxMatchTime();
         matchSpinner.currentValue = gameModel.matchData.matchTime;
      }
      
      private function updateMapIconForMap(id:String) : void
      {
         var _loc2_:LevelData = Levels.findLevelData(id);
         if(_loc2_)
         {
            updateMapIcon(_loc2_.swf,_loc2_.export);
         }
         else
         {
            updateMapIcon("flash/ui/icons_maps.swf","icon_map_random");
         }
      }
      
      private function updateMapIcon(swf:String, export:String) : void
      {
         DCUtils.removeChildren(this._design.Container_Icon);
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF(swf,export);
         if(_loc3_)
         {
            this._design.Container_Icon.addChild(_loc3_);
         }
      }
      
      private function getSlotButton(index:int, object:*, mc:MovieClip) : *
      {
         return new LevelButtonContainers(mc,this,object);
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
