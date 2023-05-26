package tuxwars.home.ui.screen.home
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.crafting.CraftingState;
   import tuxwars.home.states.equipment.EquipmentState;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.states.leaderboard.LeaderboardState;
   import tuxwars.home.states.shop.ShopState;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.net.CRMService;
   import tuxwars.states.tutorial.TuxTutorialSubState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function NavigationButtonsElementScreen(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         var _loc3_:Boolean = false;
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","home_screen");
         super(_loc4_,game);
         DCUtils.stopMovieClip(_loc4_);
         DCUtils.playMovieClip(_loc4_.Button_Character);
         DCUtils.playMovieClip(_loc4_.Button_Crafting);
         DCUtils.playMovieClip(_loc4_.Button_Supplies);
         DCUtils.playMovieClip(_loc4_.Button_Teams);
         character = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Character",characterHandler,"BUTTON_CHARACTER","TOOLTIP_CHARACTER");
         character.addEventListener("out",mouseOut,false,0,true);
         character.addEventListener("over",mouseOver,false,0,true);
         crafting = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Crafting",craftingHandler,"BUTTON_CRAFTING","TOOLTIP_CRAFTING");
         crafting.addEventListener("out",mouseOut,false,0,true);
         crafting.addEventListener("over",mouseOver,false,0,true);
         supplies = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Supplies",suppliesHandler,"BUTTON_SUPPLIES","TOOLTIP_SUPPLIES");
         supplies.addEventListener("out",mouseOut,false,0,true);
         supplies.addEventListener("over",mouseOver,false,0,true);
         leaderboard = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Teams",leaderboardHandler,"BUTTON_LEADERBOARD","TOOLTIP_LEADERBOARD");
         leaderboard.addEventListener("out",mouseOut,false,0,true);
         leaderboard.addEventListener("over",mouseOver,false,0,true);
         var _loc5_:UIButton = character;
         whereToAdd.addChild(_loc5_._design);
         var _loc6_:UIButton = crafting;
         whereToAdd.addChild(_loc6_._design);
         var _loc7_:UIButton = supplies;
         whereToAdd.addChild(_loc7_._design);
         var _loc8_:UIButton = leaderboard;
         whereToAdd.addChild(_loc8_._design);
         var _loc9_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            var _loc10_:Tutorial = Tutorial;
            _loc3_ = !(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart");
            character.setEnabled(_loc3_);
            crafting.setEnabled(_loc3_);
            supplies.setEnabled(_loc3_);
            leaderboard.setEnabled(_loc3_);
         }
      }
      
      override public function dispose() : void
      {
         character.dispose();
         character = null;
         crafting.dispose();
         crafting = null;
         supplies.dispose();
         supplies = null;
         leaderboard.dispose();
         leaderboard = null;
         super.dispose();
      }
      
      public function get charactersButton() : UIButton
      {
         return character;
      }
      
      public function get suppliesButton() : UIButton
      {
         return supplies;
      }
      
      public function get craftingButton() : UIButton
      {
         return crafting;
      }
      
      public function get teamsButton() : UIButton
      {
         return leaderboard;
      }
      
      public function characterHandler(event:MouseEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || tuxwars.tutorial.Tutorial._tutorial)
         {
            CRMService.sendEvent("Game","Menu","Clicked","Character");
            game.homeState.changeState(new EquipmentState(game));
         }
      }
      
      private function craftingHandler(event:MouseEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || tuxwars.tutorial.Tutorial._tutorial)
         {
            CRMService.sendEvent("Game","Menu","Clicked","Crafting");
            game.homeState.changeState(new CraftingState(game));
         }
      }
      
      private function suppliesHandler(event:MouseEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || tuxwars.tutorial.Tutorial._tutorial)
         {
            CRMService.sendEvent("Game","Menu","Clicked","Supplies");
            game.homeState.changeState(new ShopState(game));
         }
      }
      
      private function leaderboardHandler(event:MouseEvent) : void
      {
         if(game.currentState is HomeState || game.currentState is TuxTutorialSubState || tuxwars.tutorial.Tutorial._tutorial)
         {
            CRMService.sendEvent("Game","Menu","Clicked","Leaderboard");
            game.homeState.changeState(new LeaderboardState(game));
         }
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
