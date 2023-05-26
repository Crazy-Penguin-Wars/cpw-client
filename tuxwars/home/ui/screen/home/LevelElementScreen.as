package tuxwars.home.ui.screen.home
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.progress.UIProgressIndicator;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.Experience;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class LevelElementScreen extends TuxUIElementScreen
   {
      
      private static const LEVEL_ICON:String = "Icon_Level";
      
      private static const LEVEL_NUMBER:String = "Text_Level";
      
      private static const EXP_TEXT:String = "Text";
       
      
      private var levelProgressBar:UIProgressIndicator;
      
      private var level:UIAutoTextField;
      
      private var expField:UIAutoTextField;
      
      public function LevelElementScreen(design:MovieClip, game:TuxWarsGame)
      {
         super(design,game);
         levelProgressBar = new UIProgressIndicator(design,Experience.getScore(game.player.level),Experience.getScore(game.player.level + 1));
         levelProgressBar.setValue(game.player.expValue);
         var _loc3_:MovieClip = design.getChildByName("Icon_Level") as MovieClip;
         level = TuxUiUtils.createAutoTextFieldWithText(_loc3_.getChildByName("Text_Level") as TextField,game.player.level.toString());
         expField = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text") as TextField,"");
         expField.setText(ProjectManager.getText("MENU_EXP",[game.player.expValue,Experience.getScore(game.player.level + 1)]));
         _loc3_.addEventListener("mouseOut",mouseOut,false,0,true);
         _loc3_.addEventListener("mouseOver",mouseOver,false,0,true);
         MessageCenter.addListener("LevelUp",levelUpCallback);
         MessageCenter.addListener("ExperienceChanged",expChangedCallback);
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip("TOOLTIP_XP"),event.target as DisplayObject);
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("LevelUp",levelUpCallback);
         MessageCenter.removeListener("ExperienceChanged",expChangedCallback);
         var _loc1_:MovieClip = this._design.getChildByName("Icon_Level") as MovieClip;
         _loc1_.removeEventListener("mouseOut",mouseOut);
         _loc1_.removeEventListener("mouseOver",mouseOver);
         TooltipManager.removeTooltip();
         levelProgressBar.dispose();
         levelProgressBar = null;
         level = null;
         expField = null;
         super.dispose();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         levelProgressBar.logicUpdate(deltaTime);
      }
      
      private function expChangedCallback(msg:Message) : void
      {
         expField.setText(ProjectManager.getText("MENU_EXP",[game.player.expValue,Experience.getScore(game.player.level + 1)]));
         levelProgressBar.setValue(game.player.expValue);
      }
      
      private function levelUpCallback(msg:Message) : void
      {
         level.setText(game.player.level.toString());
         levelProgressBar.dispose();
         levelProgressBar = new UIProgressIndicator(this._design,Experience.getScore(game.player.level),Experience.getScore(game.player.level + 1));
         levelProgressBar.setValue(game.player.expValue);
      }
   }
}
