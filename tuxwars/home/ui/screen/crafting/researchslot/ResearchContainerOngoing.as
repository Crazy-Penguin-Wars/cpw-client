package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.researchslot.collect.ResearchResultTimer;
   
   public class ResearchContainerOngoing extends ResearchContainer
   {
      
      public static const INSTANT:String = "Slot_Result";
       
      
      public function ResearchContainerOngoing(design:MovieClip, titleTid:String, descriptionTid:String, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,titleTid,descriptionTid,parent);
         resultContainers.add("Slot_Result",new ResearchResultTimer(resultMC.getChildByName("Slot_Result") as MovieClip,"Button_Buy",null,ingredientSlots.length,game));
         resultContainers.show("Slot_Result",false);
      }
   }
}
