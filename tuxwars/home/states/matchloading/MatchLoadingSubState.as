package tuxwars.home.states.matchloading
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.data.Sounds;
   import tuxwars.data.Tuner;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.notenoughammo.NotEnoughAmmoSubState;
   
   public class MatchLoadingSubState extends TuxState
   {
       
      
      public function MatchLoadingSubState(game:TuxWarsGame, params:* = null)
      {
         game.battleServer.init(game);
         game.createStarling();
         super(game,params);
      }
      
      override public function enter() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         super.enter();
         if(allowEnterGame)
         {
            Sounds.playQueueTheme();
            changeState(new MatchLoadingLoadAssetsSubState(tuxGame,params));
         }
         else
         {
            var _loc3_:Tuner = Tuner;
            var _loc5_:Field = tuxwars.data.Tuner.getField("MinimumAmmoForMatch");
            LogUtils.log("Not enough ammo to enter game have: " + (_game as TuxWarsGame).player.inventory.getTotalAmountOfAmmo() + " and needed:" + (!!_loc5_ ? _loc5_.value : 0),this,0,"All",false,false,false);
            _loc2_ = _game as TuxWarsGame;
            _loc1_ = tuxGame.homeState;
            _loc2_.battleServer.dispose();
            _loc1_.exitCurrentState();
            var _loc4_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.triggerPopup(new NotEnoughAmmoSubState(_loc2_,params),_loc1_);
         }
      }
      
      protected function get allowEnterGame() : Boolean
      {
         return _game != null && ((_game as TuxWarsGame).player.inventory.getTotalAmountOfAmmo() >= (!!_loc2_ ? _loc2_.value : 0) || BattleManager.isPracticeMode());
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
