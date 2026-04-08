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
      
      public function PopUpBaseSubState(param1:String, param2:DCGame, param3:Class, param4:Class, param5:AssetsData, param6:* = null)
      {
         this._type = param1;
         this.screen = param3;
         this.logic = param4;
         this.assetsData = param5;
         super(param2,param6);
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      override public function allowStateChange(param1:State) : Boolean
      {
         return false;
      }
      
      override public function enter() : void
      {
         super.enter();
         this.playEnterSound();
         changeState(new PopUpBaseLoadAssetsSubState(game,this.screen,this.logic,this.assetsData,params));
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

