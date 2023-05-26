package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.home.ui.screen.crafting.researchslot.collect.ResearchResultBuild;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class ResearchContainerStart extends ResearchContainer
   {
      
      public static const START:String = "Slot_Result";
       
      
      private var buttonReset:UIButton;
      
      public function ResearchContainerStart(design:MovieClip, titleTid:String, descriptionTid:String, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,titleTid,descriptionTid,parent);
         resultContainers.add("Slot_Result",new ResearchResultBuild(resultMC.getChildByName("Slot_Result") as MovieClip,"Button_Build","BUTTON_RESEARCH",ingredientSlots.length,game,"TOOLTIP_RESEARCH_START"));
         buttonReset = TuxUiUtils.createButton(UIButton,design,"Button_Reset",buttonResetPressed,"Button_Reset");
         buttonReset.getDesignMovieClip().addEventListener("mouseOver",mouseOver,false,0,true);
         buttonReset.getDesignMovieClip().addEventListener("mouseOut",mouseOut,false,0,true);
         enableReset(null);
         MessageCenter.addListener("ResearchIngridientsUpdated",enableReset);
         resultContainers.show("Slot_Result",false);
      }
      
      public function enableReset(msg:Message) : void
      {
         var _loc2_:Research = Research;
         §§push(buttonReset);
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         §§pop().setEnabled(tuxwars.home.ui.screen.crafting.Research._instance.currentIngredients.length > 0);
         TooltipManager.removeTooltip();
      }
      
      public function buttonResetPressed(event:MouseEvent) : void
      {
         clearSlots();
         var _loc2_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         tuxwars.home.ui.screen.crafting.Research._instance.clearIngridients();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clearSlots();
         var _loc1_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         tuxwars.home.ui.screen.crafting.Research._instance.clearIngridients();
         buttonReset.getDesignMovieClip().removeEventListener("mouseOver",mouseOver,false);
         buttonReset.getDesignMovieClip().removeEventListener("mouseOut",mouseOut,false);
         buttonReset.dispose();
         MessageCenter.removeListener("ResearchIngridientsUpdated",enableReset);
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip("TOOLTIP_RESEARCH_RESET"),buttonReset.getDesignMovieClip());
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
