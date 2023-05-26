package tuxwars.home.ui.screen.crafting
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.home.ui.screen.crafting.researchslot.ResearchContainers;
   import tuxwars.utils.TuxUiUtils;
   
   public class ResearchElement extends TuxUIElementScreen
   {
       
      
      private const RESEARCH_DESCRIPTION:String = "Text_Description";
      
      private const RESEARCH_INGREDIENTS_TEXT:String = "Text_Ingredient";
      
      private const RESEARCH_SLOT:String = "Reserach_Slot";
      
      private var containers:ResearchContainers;
      
      public function ResearchElement(design:MovieClip, game:TuxWarsGame)
      {
         super(design,game);
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Description") as TextField,"Research_Description");
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Ingredient") as TextField,"Research_Ingredient");
         containers = new ResearchContainers(design.getChildByName("Reserach_Slot") as MovieClip,game);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         containers.dispose();
      }
   }
}
