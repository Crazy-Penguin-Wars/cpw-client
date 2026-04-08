package tuxwars.home.states.matchloading
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.utils.*;
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.data.*;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.notenoughammo.*;
   
   public class MatchLoadingSubState extends TuxState
   {
      public function MatchLoadingSubState(param1:TuxWarsGame, param2:* = null)
      {
         param1.battleServer.init(param1);
         param1.createStarling();
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         var _loc3_:Field = null;
         var _loc1_:TuxWarsGame = null;
         var _loc2_:HomeState = null;
         super.enter();
         if(this.allowEnterGame)
         {
            Sounds.playQueueTheme();
            changeState(new MatchLoadingLoadAssetsSubState(tuxGame,params));
         }
         else
         {
            _loc3_ = Tuner.getField("MinimumAmmoForMatch");
            LogUtils.log("Not enough ammo to enter game have: " + (_game as TuxWarsGame).player.inventory.getTotalAmountOfAmmo() + " and needed:" + (!!_loc3_ ? _loc3_.value : 0),this,0,"All",false,false,false);
            _loc1_ = _game as TuxWarsGame;
            _loc2_ = tuxGame.homeState;
            _loc1_.battleServer.dispose();
            _loc2_.exitCurrentState();
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.triggerPopup(new NotEnoughAmmoSubState(_loc1_,params),_loc2_);
         }
      }
      
      protected function get allowEnterGame() : Boolean
      {
         var _loc1_:Field = Tuner.getField("MinimumAmmoForMatch");
         return _game != null && ((_game as TuxWarsGame).player.inventory.getTotalAmountOfAmmo() >= (!!_loc1_ ? _loc1_.value : 0) || Boolean(BattleManager.isPracticeMode()));
      }
      
      public function get logicClass() : Class
      {
         return null;
      }
      
      public function isPracticeMatch() : Boolean
      {
         return false;
      }
   }
}

