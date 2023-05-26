package tuxwars.home.ui.screen.crafting.researchslot.collect
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.items.data.RecipeData;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.loot.LootPopupSubState;
   
   public class ResearchResultRecipe extends ResearchResultBuild
   {
       
      
      private var icon:MovieClip;
      
      private var recipeData:RecipeData;
      
      public function ResearchResultRecipe(design:MovieClip, buttonName:String, buttonTid:String, ingridientsSlots:int, game:TuxWarsGame)
      {
         super(design,buttonName,buttonTid,ingridientsSlots,game,"TOOLTIP_RESEARCH_COLLECT");
         icon = design.getChildByName("Icon") as MovieClip;
      }
      
      override protected function buttonPressed(event:MouseEvent) : void
      {
         var _loc2_:Research = Research;
         §§push(MessageCenter);
         §§push("CollectResearchRewards");
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         §§pop().sendMessage(§§pop(),tuxwars.home.ui.screen.crafting.Research._instance.currentIngredients);
         MessageCenter.addListener("CollectResearchRewardsResponse",buttonPressedCallBack);
      }
      
      public function buttonPressedCallBack(msg:Message) : void
      {
         if(game.player.inventory.containsItem(recipeData.id))
         {
            var _loc2_:Research = Research;
            if(!tuxwars.home.ui.screen.crafting.Research._instance)
            {
               new tuxwars.home.ui.screen.crafting.Research();
            }
            tuxwars.home.ui.screen.crafting.Research._instance.completeResearch(game.player);
         }
         else
         {
            game.player.inventory.addItem(recipeData.id);
         }
         MessageCenter.removeListener("CollectResearchRewardsResponse",buttonPressedCallBack);
         var _loc3_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         tuxwars.home.ui.screen.crafting.Research._instance.completeResearch(game.player);
         showNewRecipeCollected();
      }
      
      public function showNewRecipeCollected() : void
      {
         var showRecipe:LootPopupSubState = new LootPopupSubState(game,recipeData);
         var _loc2_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.addPopup(showRecipe);
         var _loc3_:PopUpManager = PopUpManager;
         if(!tuxwars.ui.popups.PopUpManager._instance)
         {
            tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
         }
         tuxwars.ui.popups.PopUpManager._instance.showPopUps(game.currentState);
      }
      
      override public function shown() : void
      {
         var _loc1_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         recipeData = tuxwars.home.ui.screen.crafting.Research._instance.receipe;
         while(icon.numChildren > 0)
         {
            icon.removeChildAt(0);
         }
         icon.addChild(recipeData.icon);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("CollectResearchRewardsResponse",buttonPressedCallBack);
      }
   }
}
