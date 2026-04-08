package tuxwars.home.ui.screen.oldcustomgame
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.*;
   import tuxwars.home.ui.logic.oldcustomgame.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
   public class OldCustomGameScreen extends TuxUIScreen
   {
      private static const EXPORT:String = "multiplayer_test";
      
      private static const TEXT_HEADER:String = "Text_Header";
      
      private static const TEXT_DESCRIPTION:String = "Text_Description";
      
      private static const TEXT_CHOOSE_LEVEL:String = "Text_Choose_Level";
      
      private static const BUTTON_CLOSE:String = "Button_Close";
      
      private static const BUTTON_PLAY:String = "Button_Play";
      
      private static const BUTTON_PRACTICE:String = "Button_Practice";
      
      private static const INPUT_PLAYERS:String = "Input_Players";
      
      private static const INPUT_MATCH_TIME:String = "Input_Match";
      
      private static const INPUT_TURN_TIME:String = "Input_Turn";
      
      private static const TEXT_INPUT:String = "Text_Input";
      
      private var closeButton:UIButton;
      
      private var playButton:UIButton;
      
      private var practiceButton:UIButton;
      
      private var objectContainer:ObjectContainer;
      
      public function OldCustomGameScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_test"));
         this.closeButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",this.closeButtonHandler);
         this.playButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Play",this.playButtonHandler,"BUTTON_PLAY");
         this.practiceButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Practice",this.practiceButtonHandler,"Practice");
         TuxUiUtils.createAutoTextField(this._design.getChildByName("Text_Header") as TextField,"CUSTOM_GAME_TITLE");
         TuxUiUtils.createAutoTextField(this._design.getChildByName("Text_Choose_Level") as TextField,"Choose Level:");
         this.objectContainer = new ObjectContainer(this._design,param1,this.getSlotButton,"transition_maps_left","transition_maps_right");
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,false);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.setupInput(this._design.getChildByName("Input_Players") as MovieClip,"Number of Players:",this.customGameLogic.getDefaultPlayerNumber());
         this.setupInput(this._design.getChildByName("Input_Match") as MovieClip,"Match Time (s):",this.customGameLogic.getDefaultMatchTime());
         this.setupInput(this._design.getChildByName("Input_Turn") as MovieClip,"Turn Time (s):",this.customGameLogic.getDefaultTurnTime());
         this.objectContainer.init(this.customGameLogic.getLevels(),false);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,false);
         this.closeButton.dispose();
         this.closeButton = null;
         this.playButton.dispose();
         this.playButton = null;
         this.practiceButton.dispose();
         this.practiceButton = null;
         this.objectContainer.dispose();
         this.objectContainer = null;
         super.dispose();
      }
      
      public function disableButtons() : void
      {
         this.closeButton.setEnabled(false);
         this.playButton.setEnabled(false);
         this.practiceButton.setEnabled(false);
      }
      
      private function getSlotButton(param1:int, param2:*, param3:MovieClip) : *
      {
         var _loc4_:UIToggleButton = TuxUiUtils.createButton(UIToggleButton,param3,null);
         _loc4_.setText(param2.name);
         return _loc4_;
      }
      
      private function setupInput(param1:MovieClip, param2:String, param3:String) : void
      {
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Description") as TextField,param2);
         var _loc4_:TextField = param1.getChildByName("Text_Input") as TextField;
         _loc4_.text = param3;
      }
      
      private function getInputField(param1:String) : TextField
      {
         var _loc2_:MovieClip = this._design.getChildByName(param1) as MovieClip;
         return _loc2_.getChildByName("Text_Input") as TextField;
      }
      
      private function playButtonHandler(param1:MouseEvent) : void
      {
         this.customGameLogic.play(this.getConfigParams());
      }
      
      private function practiceButtonHandler(param1:MouseEvent) : void
      {
         this.customGameLogic.practice(this.getConfigParams());
      }
      
      private function getConfigParams() : Object
      {
         var _loc1_:LevelData = this.objectContainer.getSelectedObject() as LevelData;
         return {
            "map_id":_loc1_.id,
            "map":_loc1_.id,
            "num_players":this.getInputField("Input_Players").text,
            "match_time":this.getInputField("Input_Match").text,
            "turn_time":this.getInputField("Input_Turn").text
         };
      }
      
      private function closeButtonHandler(param1:MouseEvent) : void
      {
         this.customGameLogic.quit();
      }
      
      private function get customGameLogic() : OldCustomGameLogic
      {
         return logic as OldCustomGameLogic;
      }
   }
}

