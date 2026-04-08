package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   
   public class ResearchContainerOngoing extends ResearchContainer
   {
      public static const INSTANT:String = "Slot_Result";
      
      public function ResearchContainerOngoing(param1:MovieClip, param2:String, param3:String, param4:TuxWarsGame, param5:UIComponent = null)
      {
         super(param1,param2,param3,param5);
         resultContainers.add("Slot_Result",new ResearchResultTimer(resultMC.getChildByName("Slot_Result") as MovieClip,"Button_Buy",null,ingredientSlots.length,param4));
         resultContainers.show("Slot_Result",false);
      }
   }
}

