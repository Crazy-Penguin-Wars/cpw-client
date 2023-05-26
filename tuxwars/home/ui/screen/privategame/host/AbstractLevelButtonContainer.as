package tuxwars.home.ui.screen.privategame.host
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.battle.data.LevelData;
   import tuxwars.ui.containers.shopitem.ButtonContainer;
   import tuxwars.utils.TuxUiUtils;
   
   public class AbstractLevelButtonContainer extends UIContainer implements ButtonContainer
   {
       
      
      private var _levelData:LevelData;
      
      private var _button:UIToggleButton;
      
      public function AbstractLevelButtonContainer(design:MovieClip, parent:UIComponent, levelData:LevelData)
      {
         super(design,parent);
         _levelData = levelData;
         _button = TuxUiUtils.createButton(UIToggleButton,design,null);
         _button.setText(!!levelData ? levelData.name : ProjectManager.getText("RANDOM"));
      }
      
      override public function dispose() : void
      {
         _button.dispose();
         _button = null;
         _levelData = null;
         super.dispose();
      }
      
      public function get button() : UIButton
      {
         return _button;
      }
      
      public function get levelData() : LevelData
      {
         return _levelData;
      }
   }
}
