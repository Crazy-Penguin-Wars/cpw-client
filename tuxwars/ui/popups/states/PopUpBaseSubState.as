package tuxwars.ui.popups.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.states.State;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxState;
   
   public class PopUpBaseSubState extends TuxState
   {
      
      public static const TYPE_NONE:String = "Base";
       
      
      private var _type:String = "Base";
      
      private var screen:Class;
      
      private var logic:Class;
      
      private var assetsData:AssetsData;
      
      public function PopUpBaseSubState(type:String, game:DCGame, screen:Class, logic:Class, assetsData:AssetsData, params:* = null)
      {
         this._type = type;
         this.screen = screen;
         this.logic = logic;
         this.assetsData = assetsData;
         super(game,params);
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      override public function allowStateChange(nextState:State) : Boolean
      {
         return false;
      }
      
      override public function enter() : void
      {
         super.enter();
         playEnterSound();
         changeState(new PopUpBaseLoadAssetsSubState(game,screen,logic,assetsData,params));
      }
      
      protected function playEnterSound() : void
      {
      }
      
      public function forcePopup() : Boolean
      {
         return false;
      }
   }
}
