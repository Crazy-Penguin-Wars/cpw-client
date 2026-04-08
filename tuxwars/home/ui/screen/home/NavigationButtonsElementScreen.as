package tuxwars.home.ui.screen.home
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.crafting.*;
   import tuxwars.home.states.equipment.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.states.leaderboard.*;
   import tuxwars.home.states.shop.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.net.*;
   import tuxwars.states.tutorial.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class NavigationButtonsElementScreen extends TuxUIElementScreen
   {
      private static const BUTTON_CHARACTER:String = "Button_Character";
      
      private static const BUTTON_CRAFTING:String = "Button_Crafting";
      
      private static const BUTTON_SUPPLIES:String = "Button_Supplies";
      
      private static const BUTTON_LEADERBOARD:String = "Button_Teams";
      
      private var character:UIButton;
      
      private var crafting:UIButton;
      
      private var supplies:UIButton;
      
      private var leaderboard:UIButton;
      
      public function NavigationButtonsElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:* = false;
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         super(_loc4_,param2);
         DCUtils.stopMovieClip(_loc4_);
         DCUtils.playMovieClip(_loc4_.Button_Character);
         DCUtils.playMovieClip(_loc4_.Button_Crafting);
         DCUtils.playMovieClip(_loc4_.Button_Supplies);
         DCUtils.playMovieClip(_loc4_.Button_Teams);
         this.character = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Character",this.characterHandler,"BUTTON_CHARACTER","TOOLTIP_CHARACTER");
         this.character.addEventListener("out",this.mouseOut,false,0,true);
         this.character.addEventListener("over",this.mouseOver,false,0,true);
         this.crafting = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Crafting",this.craftingHandler,"BUTTON_CRAFTING","TOOLTIP_CRAFTING");
         this.crafting.addEventListener("out",this.mouseOut,false,0,true);
         this.crafting.addEventListener("over",this.mouseOver,false,0,true);
         this.supplies = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Supplies",this.suppliesHandler,"BUTTON_SUPPLIES","TOOLTIP_SUPPLIES");
         this.supplies.addEventListener("out",this.mouseOut,false,0,true);
         this.supplies.addEventListener("over",this.mouseOver,false,0,true);
         this.leaderboard = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Teams",this.leaderboardHandler,"BUTTON_LEADERBOARD","TOOLTIP_LEADERBOARD");
         this.leaderboard.addEventListener("out",this.mouseOut,false,0,true);
         this.leaderboard.addEventListener("over",this.mouseOver,false,0,true);
         var _loc5_:UIButton = this.character;
         param1.addChild(_loc5_._design);
         var _loc6_:UIButton = this.crafting;
         param1.addChild(_loc6_._design);
         var _loc7_:UIButton = this.supplies;
         param1.addChild(_loc7_._design);
         var _loc8_:UIButton = this.leaderboard;
         param1.addChild(_loc8_._design);
         if(Tutorial._tutorial)
         {
            _loc3_ = !(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart");
            this.character.setEnabled(_loc3_);
            this.crafting.setEnabled(_loc3_);
            this.supplies.setEnabled(_loc3_);
            this.leaderboard.setEnabled(_loc3_);
         }
      }
      
      override public function dispose() : void
      {
         this.character.dispose();
         this.character = null;
         this.crafting.dispose();
         this.crafting = null;
         this.supplies.dispose();
         this.supplies = null;
         this.leaderboard.dispose();
         this.leaderboard = null;
         super.dispose();
      }
      
      public function get charactersButton() : UIButton
      {
         return this.character;
      }
      
      public function get suppliesButton() : UIButton
      {
         return this.supplies;
      }
      
      public function get craftingButton() : UIButton
      {
         return this.crafting;
      }
      
      public function get teamsButton() : UIButton
      {
         return this.leaderboard;
      }
      
      public function characterHandler(param1:MouseEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || Boolean(Tutorial._tutorial))
         {
            CRMService.sendEvent("Game","Menu","Clicked","Character");
            game.homeState.changeState(new EquipmentState(game));
         }
      }
      
      private function craftingHandler(param1:MouseEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || Boolean(Tutorial._tutorial))
         {
            CRMService.sendEvent("Game","Menu","Clicked","Crafting");
            game.homeState.changeState(new CraftingState(game));
         }
      }
      
      private function suppliesHandler(param1:MouseEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || Boolean(Tutorial._tutorial))
         {
            CRMService.sendEvent("Game","Menu","Clicked","Supplies");
            game.homeState.changeState(new ShopState(game));
         }
      }
      
      private function leaderboardHandler(param1:MouseEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || Boolean(Tutorial._tutorial))
         {
            CRMService.sendEvent("Game","Menu","Clicked","Leaderboard");
            game.homeState.changeState(new LeaderboardState(game));
         }
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

