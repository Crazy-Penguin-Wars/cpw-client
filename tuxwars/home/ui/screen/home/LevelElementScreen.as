package tuxwars.home.ui.screen.home
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.progress.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class LevelElementScreen extends TuxUIElementScreen
   {
      private static const LEVEL_ICON:String = "Icon_Level";
      
      private static const LEVEL_NUMBER:String = "Text_Level";
      
      private static const EXP_TEXT:String = "Text";
      
      private var levelProgressBar:UIProgressIndicator;
      
      private var level:UIAutoTextField;
      
      private var expField:UIAutoTextField;
      
      public function LevelElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this.levelProgressBar = new UIProgressIndicator(param1,Experience.getScore(param2.player.level),Experience.getScore(param2.player.level + 1));
         this.levelProgressBar.setValue(param2.player.expValue);
         var _loc3_:MovieClip = param1.getChildByName("Icon_Level") as MovieClip;
         this.level = TuxUiUtils.createAutoTextFieldWithText(_loc3_.getChildByName("Text_Level") as TextField,param2.player.level.toString());
         this.expField = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text") as TextField,"");
         this.expField.setText(ProjectManager.getText("MENU_EXP",[param2.player.expValue,Experience.getScore(param2.player.level + 1)]));
         _loc3_.addEventListener("mouseOut",this.mouseOut,false,0,true);
         _loc3_.addEventListener("mouseOver",this.mouseOver,false,0,true);
         MessageCenter.addListener("LevelUp",this.levelUpCallback);
         MessageCenter.addListener("ExperienceChanged",this.expChangedCallback);
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip("TOOLTIP_XP"),param1.target as DisplayObject);
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("LevelUp",this.levelUpCallback);
         MessageCenter.removeListener("ExperienceChanged",this.expChangedCallback);
         var _loc1_:MovieClip = this._design.getChildByName("Icon_Level") as MovieClip;
         _loc1_.removeEventListener("mouseOut",this.mouseOut);
         _loc1_.removeEventListener("mouseOver",this.mouseOver);
         TooltipManager.removeTooltip();
         this.levelProgressBar.dispose();
         this.levelProgressBar = null;
         this.level = null;
         this.expField = null;
         super.dispose();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this.levelProgressBar.logicUpdate(param1);
      }
      
      private function expChangedCallback(param1:Message) : void
      {
         this.expField.setText(ProjectManager.getText("MENU_EXP",[game.player.expValue,Experience.getScore(game.player.level + 1)]));
         this.levelProgressBar.setValue(game.player.expValue);
      }
      
      private function levelUpCallback(param1:Message) : void
      {
         this.level.setText(game.player.level.toString());
         this.levelProgressBar.dispose();
         this.levelProgressBar = new UIProgressIndicator(this._design,Experience.getScore(game.player.level),Experience.getScore(game.player.level + 1));
         this.levelProgressBar.setValue(game.player.expValue);
      }
   }
}

