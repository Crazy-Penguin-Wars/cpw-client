package tuxwars.home.ui.screen.oldcustomgame
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.buttons.UIToggleButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.LevelData;
   import tuxwars.home.ui.logic.oldcustomgame.OldCustomGameLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function OldCustomGameScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/multiplayer.swf","multiplayer_test"));
         closeButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeButtonHandler);
         playButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Play",playButtonHandler,"BUTTON_PLAY");
         practiceButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Practice",practiceButtonHandler,"Practice");
         TuxUiUtils.createAutoTextField(this._design.getChildByName("Text_Header") as TextField,"CUSTOM_GAME_TITLE");
         TuxUiUtils.createAutoTextField(this._design.getChildByName("Text_Choose_Level") as TextField,"Choose Level:");
         objectContainer = new ObjectContainer(this._design,game,getSlotButton,"transition_maps_left","transition_maps_right");
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,false);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         setupInput(this._design.getChildByName("Input_Players") as MovieClip,"Number of Players:",customGameLogic.getDefaultPlayerNumber());
         setupInput(this._design.getChildByName("Input_Match") as MovieClip,"Match Time (s):",customGameLogic.getDefaultMatchTime());
         setupInput(this._design.getChildByName("Input_Turn") as MovieClip,"Turn Time (s):",customGameLogic.getDefaultTurnTime());
         objectContainer.init(customGameLogic.getLevels(),false);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,false);
         closeButton.dispose();
         closeButton = null;
         playButton.dispose();
         playButton = null;
         practiceButton.dispose();
         practiceButton = null;
         objectContainer.dispose();
         objectContainer = null;
         super.dispose();
      }
      
      public function disableButtons() : void
      {
         closeButton.setEnabled(false);
         playButton.setEnabled(false);
         practiceButton.setEnabled(false);
      }
      
      private function getSlotButton(index:int, object:*, mc:MovieClip) : *
      {
         var _loc4_:UIToggleButton = TuxUiUtils.createButton(UIToggleButton,mc,null);
         _loc4_.setText(object.name);
         return _loc4_;
      }
      
      private function setupInput(mc:MovieClip, text:String, defaultInput:String) : void
      {
         TuxUiUtils.createAutoTextField(mc.getChildByName("Text_Description") as TextField,text);
         var _loc4_:TextField = mc.getChildByName("Text_Input") as TextField;
         _loc4_.text = defaultInput;
      }
      
      private function getInputField(name:String) : TextField
      {
         var _loc2_:MovieClip = this._design.getChildByName(name) as MovieClip;
         return _loc2_.getChildByName("Text_Input") as TextField;
      }
      
      private function playButtonHandler(event:MouseEvent) : void
      {
         customGameLogic.play(getConfigParams());
      }
      
      private function practiceButtonHandler(event:MouseEvent) : void
      {
         customGameLogic.practice(getConfigParams());
      }
      
      private function getConfigParams() : Object
      {
         var _loc1_:LevelData = objectContainer.getSelectedObject() as LevelData;
         return {
            "map_id":_loc1_.id,
            "map":_loc1_.id,
            "num_players":getInputField("Input_Players").text,
            "match_time":getInputField("Input_Match").text,
            "turn_time":getInputField("Input_Turn").text
         };
      }
      
      private function closeButtonHandler(event:MouseEvent) : void
      {
         customGameLogic.quit();
      }
      
      private function get customGameLogic() : OldCustomGameLogic
      {
         return logic as OldCustomGameLogic;
      }
   }
}
