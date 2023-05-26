package tuxwars.home.ui.screen.home
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.home.MoneyResourceElementLogic;
   import tuxwars.ui.components.DealSpotElement;
   import tuxwars.ui.components.TopBarRightElement;
   import tuxwars.utils.TuxUiUtils;
   
   public class TopRightElementScreen
   {
      
      private static const RESOURCE:String = "HUD_money";
       
      
      private var _moneyResourceElementScreen:MoneyResourceElementScreen;
      
      private var topBarRightElement:TopBarRightElement;
      
      private var design:MovieClip;
      
      private var _dealSpotElement:DealSpotElement;
      
      public function TopRightElementScreen(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         super();
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         DCUtils.stopMovieClip(_loc3_);
         design = _loc3_.getChildByName("HUD_money") as MovieClip;
         DCUtils.playMovieClip(design);
         if(Config.ENABLE_DEAL_SPOT_PROMOTION && Config.getPlatform() == "FB")
         {
            _dealSpotElement = new DealSpotElement(design.deal_spot,game);
         }
         _moneyResourceElementScreen = new MoneyResourceElementScreen(design,game);
         topBarRightElement = new TopBarRightElement(design.Top_Bar_Right,game);
         TuxUiUtils.setMovieClipPosition(design,"top","right");
         whereToAdd.addChild(design);
      }
      
      public function dispose() : void
      {
         if(Config.ENABLE_DEAL_SPOT_PROMOTION && Config.getPlatform() == "FB")
         {
            _dealSpotElement.dispose();
            _dealSpotElement = null;
         }
         _moneyResourceElementScreen.dispose();
         _moneyResourceElementScreen = null;
         topBarRightElement.dispose();
         topBarRightElement = null;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         if(Config.ENABLE_DEAL_SPOT_PROMOTION && Config.getPlatform() == "FB")
         {
            _dealSpotElement.logicUpdate(deltaTime);
         }
         _moneyResourceElementScreen.logicUpdate(deltaTime);
      }
      
      public function setMoneyLogic(logic:MoneyResourceElementLogic) : void
      {
         _moneyResourceElementScreen.logic = logic;
      }
      
      public function get moneyResourceElement() : MoneyResourceElementScreen
      {
         return _moneyResourceElementScreen;
      }
      
      public function fullscreenChanged(fullscreen:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(design,"top","right");
      }
   }
}
