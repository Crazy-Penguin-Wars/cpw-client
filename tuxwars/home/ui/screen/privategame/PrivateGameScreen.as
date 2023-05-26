package tuxwars.home.ui.screen.privategame
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.TextUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.LevelData;
   import tuxwars.battle.data.Levels;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.ui.logic.privategame.PrivateGameLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.ui.containers.player.PlayerContainers;
   import tuxwars.utils.TuxUiUtils;
   
   public class PrivateGameScreen extends TuxUIScreen
   {
       
      
      private const roomName:UIAutoTextField = new UIAutoTextField();
      
      private const map:UIAutoTextField = new UIAutoTextField();
      
      private const turnTime:UIAutoTextField = new UIAutoTextField();
      
      private const matchTime:UIAutoTextField = new UIAutoTextField();
      
      private var closeButton:UIButton;
      
      private var playerContainers:PlayerContainers;
      
      public function PrivateGameScreen(game:TuxWarsGame, design:MovieClip, titleTID:String)
      {
         super(game,design);
         TuxUiUtils.createAutoTextField(design.Text_Header,titleTID);
         TuxUiUtils.createAutoTextField(design.Text_Setting_Map,"HOST_GAME_MAP");
         TuxUiUtils.createAutoTextField(design.Text_Setting_Players,"HOST_GAME_NUM_PLAYERS");
         TuxUiUtils.createAutoTextField(design.Text_Setting_Players_Value,"HOST_GAME_NUM_PLAYERS_VALUE");
         TuxUiUtils.createAutoTextField(design.Text_Setting_Turn,"HOST_GAME_TURN_TIME");
         TuxUiUtils.createAutoTextField(design.Text_Setting_Match,"HOST_GAME_MATCH_TIME");
         TuxUiUtils.createAutoTextField(design.Text_Message,"HOST_GAME_MESSAGE");
         roomName.setTextField(design.Text_Room_Name);
         map.setTextField(design.Text_Setting_Map_Value);
         turnTime.setTextField(design.Text_Setting_Turn_Value);
         matchTime.setTextField(design.Text_Setting_Match_Value);
         roomName.setText("");
         map.setText("");
         turnTime.setText("");
         matchTime.setText("");
         closeButton = TuxUiUtils.createButton(UIButton,design,"Button_Close",closeCallback);
         playerContainers = new PlayerContainers(design.Container_Slots);
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         update();
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         closeButton.dispose();
         closeButton = null;
         playerContainers.dispose();
         playerContainers = null;
         super.dispose();
      }
      
      public function update() : void
      {
         var _loc1_:PrivateGameModel = params;
         roomName.setText(_loc1_.name);
         map.setText(_loc1_.matchData.mapId);
         turnTime.setText(TextUtils.getTimeTextFromSeconds(_loc1_.matchData.turnTime));
         matchTime.setText(TextUtils.getTimeTextFromMinutes(_loc1_.matchData.matchTime));
         updateMapIconForMap(_loc1_.matchData.mapId);
         playerContainers.init(_loc1_.players);
      }
      
      private function closeCallback(event:MouseEvent) : void
      {
         privateGameLogic.exit();
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
      
      private function get privateGameLogic() : PrivateGameLogic
      {
         return logic as PrivateGameLogic;
      }
   }
}
