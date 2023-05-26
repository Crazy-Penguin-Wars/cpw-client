package tuxwars.home.ui.screen.crafting.researchslot.collect
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.home.ui.screen.crafting.researchslot.ResearchContainerDone;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.RecipeData;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class ResearchResultBuild extends UIContainer
   {
       
      
      private var _button:UIButton;
      
      private var ingridientsSlots:int;
      
      protected var game:TuxWarsGame;
      
      protected var researchContainerDone:ResearchContainerDone;
      
      private var tooltipTid:String;
      
      private var hasRecipe:Boolean = false;
      
      protected var knownRecipeContainer:MovieClip;
      
      protected var knownRecipe:MovieClip;
      
      protected var knownRecipeText:UIAutoTextField;
      
      protected var rememberedRecipe:MovieClip;
      
      public function ResearchResultBuild(design:MovieClip, buttonName:String, buttonTid:String, ingridientsSlots:int, game:TuxWarsGame, tooltipTid:String)
      {
         super(design);
         this.ingridientsSlots = ingridientsSlots;
         this.tooltipTid = tooltipTid;
         _button = TuxUiUtils.createButton(UIButton,design,buttonName,buttonPressed,buttonTid);
         _button.getDesignMovieClip().addEventListener("mouseOver",mouseOver,false,0,true);
         _button.getDesignMovieClip().addEventListener("mouseOut",mouseOut,false,0,true);
         if(buttonName == "Button_Build" && knownRecipeText == null)
         {
            knownRecipeContainer = getDesignMovieClip().getChildByName("Container") as MovieClip;
            knownRecipe = MovieClip(knownRecipeContainer).getChildByName("Container_Icon") as MovieClip;
            knownRecipeText = TuxUiUtils.createAutoTextFieldWithText(MovieClip(knownRecipeContainer).getChildByName("Text") as TextField,ProjectManager.getText("RESEARCH_RECIPE_KNOWN"));
            knownRecipeText.setVisible(false);
         }
         MessageCenter.addListener("ResearchIngridientsUpdated",updateButton);
         updateButton(null);
         this.game = game;
      }
      
      public function get button() : UIButton
      {
         return _button;
      }
      
      protected function updateButton(msg:Message) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = undefined;
         var _loc4_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         if(tuxwars.home.ui.screen.crafting.Research._instance.currentIngredients.length <= 0)
         {
            _button.setEnabled(false);
            _button.setText(ProjectManager.getText("BUTTON_RESEARCH"));
            checkExistingRecipe();
         }
         else
         {
            if(game && game.player)
            {
               hasRecipe = false;
               var _loc5_:Research = Research;
               if(!tuxwars.home.ui.screen.crafting.Research._instance)
               {
                  new tuxwars.home.ui.screen.crafting.Research();
               }
               _loc3_ = tuxwars.home.ui.screen.crafting.Research._instance.receipe;
               if(_loc3_)
               {
                  hasRecipe = game.player.inventory.containsItem(_loc3_.id);
               }
            }
            if(msg)
            {
               _loc2_ = msg.data;
               _button.setEnabled(!hasRecipe && _loc2_.length >= ingridientsSlots);
               if(hasRecipe && _loc2_.length >= ingridientsSlots && knownRecipeText != null)
               {
                  _button.setText(ProjectManager.getText("RESEARCH_KNOWN"));
                  knownRecipeText.setVisible(true);
                  if(_loc3_)
                  {
                     while(knownRecipe.numChildren > 0)
                     {
                        knownRecipe.removeChildAt(0);
                     }
                     knownRecipe.addChild(_loc3_.icon);
                     knownRecipe.visible = true;
                     rememberedRecipe = _loc3_.icon;
                     rememberedRecipe.visible = true;
                  }
               }
               else
               {
                  _button.setText(ProjectManager.getText("BUTTON_RESEARCH"));
               }
            }
            else
            {
               _button.setEnabled(!hasRecipe && tuxwars.home.ui.screen.crafting.Research._instance.currentIngredients.length >= ingridientsSlots);
               _button.setText(ProjectManager.getText("BUTTON_RESEARCH"));
            }
         }
      }
      
      private function checkExistingRecipe() : void
      {
         if(knownRecipeText != null)
         {
            knownRecipeText.setVisible(false);
         }
         if(rememberedRecipe != null)
         {
            rememberedRecipe.visible = false;
         }
         if(knownRecipe)
         {
            knownRecipe.visible = false;
         }
      }
      
      protected function buttonPressed(event:MouseEvent) : void
      {
         var _loc2_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         tuxwars.home.ui.screen.crafting.Research._instance.startResearch();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("ResearchIngridientsUpdated",updateButton);
         if(_button)
         {
            _button.getDesignMovieClip().removeEventListener("mouseOver",mouseOver,false);
            _button.getDesignMovieClip().removeEventListener("mouseOut",mouseOut,false);
            _button.dispose();
            _button = null;
            knownRecipeContainer = null;
            rememberedRecipe = null;
            knownRecipe = null;
            knownRecipeText = null;
         }
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         if(!knownRecipe || !knownRecipe.visible)
         {
            TooltipManager.showTooltip(new GenericTooltip(tooltipTid),_button.getDesignMovieClip());
         }
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
