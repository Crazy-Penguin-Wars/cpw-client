package tuxwars.battle.actions
{
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.input.AbstractMouseInputAction;
   import flash.display.MovieClip;
   import flash.events.Event;
   import tuxwars.battle.states.TuxBattleEditSubState;
   
   public class EditMouseHandler extends AbstractMouseInputAction
   {
      private var editState:TuxBattleEditSubState;
      
      public var isMoving:Boolean;
      
      private var currentCameraTarget:GameObject;
      
      private var objectContainer:MovieClip;
      
      public function EditMouseHandler(param1:TuxBattleEditSubState)
      {
         super("mouseMove");
         this.editState = param1;
      }
      
      override public function execute(param1:Event) : void
      {
      }
   }
}

