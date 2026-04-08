package tuxwars.home.ui.screen.crafting
{
   import flash.display.*;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.home.ui.screen.crafting.researchslot.*;
   import tuxwars.utils.*;
   
   public class ResearchElement extends TuxUIElementScreen
   {
      private const RESEARCH_DESCRIPTION:String = "Text_Description";
      
      private const RESEARCH_INGREDIENTS_TEXT:String = "Text_Ingredient";
      
      private const RESEARCH_SLOT:String = "Reserach_Slot";
      
      private var containers:ResearchContainers;
      
      public function ResearchElement(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Description") as TextField,"Research_Description");
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Ingredient") as TextField,"Research_Ingredient");
         this.containers = new ResearchContainers(param1.getChildByName("Reserach_Slot") as MovieClip,param2);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.containers.dispose();
      }
   }
}

