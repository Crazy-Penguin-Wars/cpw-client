package tuxwars.battle.actions
{
   import com.dchoc.input.*;
   import tuxwars.battle.input.PlayerMoveControls;
   
   public class PlayerControlsAction extends AbstractInputAction implements MouseInputAction, KeyboardInputAction
   {
      protected var moveControls:PlayerMoveControls;
      
      private var _keyCode:int;
      
      public function PlayerControlsAction(param1:String, param2:PlayerMoveControls, param3:int = -2)
      {
         super(param1);
         this.moveControls = param2;
         this._keyCode = param3;
      }
      
      public function get keyCode() : int
      {
         return this._keyCode;
      }
   }
}

