package tuxwars.battle.actions
{
   import com.dchoc.input.AbstractInputAction;
   import com.dchoc.input.KeyboardInputAction;
   import com.dchoc.input.MouseInputAction;
   import tuxwars.battle.input.PlayerMoveControls;
   
   public class PlayerControlsAction extends AbstractInputAction implements MouseInputAction, KeyboardInputAction
   {
       
      
      protected var moveControls:PlayerMoveControls;
      
      private var _keyCode:int;
      
      public function PlayerControlsAction(type:String, moveControls:PlayerMoveControls, keyCode:int = -2)
      {
         super(type);
         this.moveControls = moveControls;
         _keyCode = keyCode;
      }
      
      public function get keyCode() : int
      {
         return _keyCode;
      }
   }
}
