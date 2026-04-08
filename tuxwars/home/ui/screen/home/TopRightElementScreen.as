package tuxwars.home.ui.screen.home
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.home.MoneyResourceElementLogic;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
   public class TopRightElementScreen
   {
      private static const RESOURCE:String = "HUD_money";
      
      private var _moneyResourceElementScreen:MoneyResourceElementScreen;
      
      private var topBarRightElement:TopBarRightElement;
      
      private var design:MovieClip;
      
      private var _dealSpotElement:DealSpotElement;
      
      public function TopRightElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         DCUtils.stopMovieClip(_loc3_);
         this.design = _loc3_.getChildByName("HUD_money") as MovieClip;
         DCUtils.playMovieClip(this.design);
         if(Config.ENABLE_DEAL_SPOT_PROMOTION && Config.getPlatform() == "FB")
         {
            this._dealSpotElement = new DealSpotElement(this.design.deal_spot,param2);
         }
         this._moneyResourceElementScreen = new MoneyResourceElementScreen(this.design,param2);
         this.topBarRightElement = new TopBarRightElement(this.design.Top_Bar_Right,param2);
         TuxUiUtils.setMovieClipPosition(this.design,"top","right");
         param1.addChild(this.design);
      }
      
      public function dispose() : void
      {
         if(Config.ENABLE_DEAL_SPOT_PROMOTION && Config.getPlatform() == "FB")
         {
            this._dealSpotElement.dispose();
            this._dealSpotElement = null;
         }
         this._moneyResourceElementScreen.dispose();
         this._moneyResourceElementScreen = null;
         this.topBarRightElement.dispose();
         this.topBarRightElement = null;
      }
      
      public function logicUpdate(param1:int) : void
      {
         if(Config.ENABLE_DEAL_SPOT_PROMOTION && Config.getPlatform() == "FB")
         {
            this._dealSpotElement.logicUpdate(param1);
         }
         this._moneyResourceElementScreen.logicUpdate(param1);
      }
      
      public function setMoneyLogic(param1:MoneyResourceElementLogic) : void
      {
         this._moneyResourceElementScreen.logic = param1;
      }
      
      public function get moneyResourceElement() : MoneyResourceElementScreen
      {
         return this._moneyResourceElementScreen;
      }
      
      public function fullscreenChanged(param1:Boolean) : void
      {
         TuxUiUtils.setMovieClipPosition(this.design,"top","right");
      }
   }
}

