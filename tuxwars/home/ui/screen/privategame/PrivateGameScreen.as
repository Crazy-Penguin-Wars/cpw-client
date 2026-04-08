package tuxwars.home.ui.screen.privategame
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.*;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.ui.logic.privategame.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.ui.containers.player.*;
   import tuxwars.utils.*;
   
   public class PrivateGameScreen extends TuxUIScreen
   {
      private const roomName:UIAutoTextField = new UIAutoTextField();
      
      private const map:UIAutoTextField = new UIAutoTextField();
      
      private const turnTime:UIAutoTextField = new UIAutoTextField();
      
      private const matchTime:UIAutoTextField = new UIAutoTextField();
      
      private var closeButton:UIButton;
      
      private var playerContainers:PlayerContainers;
      
      public function PrivateGameScreen(param1:TuxWarsGame, param2:MovieClip, param3:String)
      {
         super(param1,param2);
         TuxUiUtils.createAutoTextField(param2.Text_Header,param3);
         TuxUiUtils.createAutoTextField(param2.Text_Setting_Map,"HOST_GAME_MAP");
         TuxUiUtils.createAutoTextField(param2.Text_Setting_Players,"HOST_GAME_NUM_PLAYERS");
         TuxUiUtils.createAutoTextField(param2.Text_Setting_Players_Value,"HOST_GAME_NUM_PLAYERS_VALUE");
         TuxUiUtils.createAutoTextField(param2.Text_Setting_Turn,"HOST_GAME_TURN_TIME");
         TuxUiUtils.createAutoTextField(param2.Text_Setting_Match,"HOST_GAME_MATCH_TIME");
         TuxUiUtils.createAutoTextField(param2.Text_Message,"HOST_GAME_MESSAGE");
         this.roomName.setTextField(param2.Text_Room_Name);
         this.map.setTextField(param2.Text_Setting_Map_Value);
         this.turnTime.setTextField(param2.Text_Setting_Turn_Value);
         this.matchTime.setTextField(param2.Text_Setting_Match_Value);
         this.roomName.setText("");
         this.map.setText("");
         this.turnTime.setText("");
         this.matchTime.setText("");
         this.closeButton = TuxUiUtils.createButton(UIButton,param2,"Button_Close",this.closeCallback);
         this.playerContainers = new PlayerContainers(param2.Container_Slots);
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.update();
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         this.closeButton.dispose();
         this.closeButton = null;
         this.playerContainers.dispose();
         this.playerContainers = null;
         super.dispose();
      }
      
      public function update() : void
      {
         var _loc1_:PrivateGameModel = params;
         this.roomName.setText(_loc1_.name);
         this.map.setText(_loc1_.matchData.mapId);
         this.turnTime.setText(TextUtils.getTimeTextFromSeconds(_loc1_.matchData.turnTime));
         this.matchTime.setText(TextUtils.getTimeTextFromMinutes(_loc1_.matchData.matchTime));
         this.updateMapIconForMap(_loc1_.matchData.mapId);
         this.playerContainers.init(_loc1_.players);
      }
      
      private function closeCallback(param1:MouseEvent) : void
      {
         this.privateGameLogic.exit();
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
      
      private function get privateGameLogic() : PrivateGameLogic
      {
         return logic as PrivateGameLogic;
      }
   }
}

