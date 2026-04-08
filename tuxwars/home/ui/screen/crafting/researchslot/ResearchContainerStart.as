package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class ResearchContainerStart extends ResearchContainer
   {
      public static const START:String = "Slot_Result";
      
      private var buttonReset:UIButton;
      
      public function ResearchContainerStart(param1:MovieClip, param2:String, param3:String, param4:TuxWarsGame, param5:UIComponent = null)
      {
         super(param1,param2,param3,param5);
         resultContainers.add("Slot_Result",new ResearchResultBuild(resultMC.getChildByName("Slot_Result") as MovieClip,"Button_Build","BUTTON_RESEARCH",ingredientSlots.length,param4,"TOOLTIP_RESEARCH_START"));
         this.buttonReset = TuxUiUtils.createButton(UIButton,param1,"Button_Reset",this.buttonResetPressed,"Button_Reset");
         this.buttonReset.getDesignMovieClip().addEventListener("mouseOver",this.mouseOver,false,0,true);
         this.buttonReset.getDesignMovieClip().addEventListener("mouseOut",this.mouseOut,false,0,true);
         this.enableReset(null);
         MessageCenter.addListener("ResearchIngridientsUpdated",this.enableReset);
         resultContainers.show("Slot_Result",false);
      }
      
      public function enableReset(param1:Message) : void
      {
         if(!Research._instance)
         {
            new Research();
         }
         this.buttonReset.setEnabled(Research._instance.currentIngredients.length > 0);
         TooltipManager.removeTooltip();
      }
      
      public function buttonResetPressed(param1:MouseEvent) : void
      {
         clearSlots();
         if(!Research._instance)
         {
            new Research();
         }
         Research._instance.clearIngridients();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clearSlots();
         if(!Research._instance)
         {
            new Research();
         }
         Research._instance.clearIngridients();
         this.buttonReset.getDesignMovieClip().removeEventListener("mouseOver",this.mouseOver,false);
         this.buttonReset.getDesignMovieClip().removeEventListener("mouseOut",this.mouseOut,false);
         this.buttonReset.dispose();
         MessageCenter.removeListener("ResearchIngridientsUpdated",this.enableReset);
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip("TOOLTIP_RESEARCH_RESET"),this.buttonReset.getDesignMovieClip());
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

