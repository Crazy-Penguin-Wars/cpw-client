package tuxwars.home.ui.screen.privategame.host
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.battle.data.LevelData;
   import tuxwars.ui.containers.shopitem.*;
   import tuxwars.utils.*;
   
   public class AbstractLevelButtonContainer extends UIContainer implements ButtonContainer
   {
      private var _levelData:LevelData;
      
      private var _button:UIToggleButton;
      
      public function AbstractLevelButtonContainer(param1:MovieClip, param2:UIComponent, param3:LevelData)
      {
         super(param1,param2);
         this._levelData = param3;
         this._button = TuxUiUtils.createButton(UIToggleButton,param1,null);
         this._button.setText(!!param3 ? param3.name : ProjectManager.getText("RANDOM"));
      }
      
      override public function dispose() : void
      {
         this._button.dispose();
         this._button = null;
         this._levelData = null;
         super.dispose();
      }
      
      public function get button() : UIButton
      {
         return this._button;
      }
      
      public function get levelData() : LevelData
      {
         return this._levelData;
      }
   }
}

