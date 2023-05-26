package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.home.ui.screen.crafting.researchslot.collect.ResearchResultBuild;
   import tuxwars.home.ui.screen.crafting.researchslot.collect.ResearchResultDone;
   import tuxwars.home.ui.screen.crafting.researchslot.collect.ResearchResultRecipe;
   
   public class ResearchContainerDone extends ResearchContainer
   {
      
      public static const RECEPIE:String = "Slot_Recipe";
      
      public static const MONEY_EXP:String = "Slot_Money_and_Exp";
      
      public static const EXP:String = "Slot_Exp";
      
      public static const MONEY:String = "Slot_Money";
       
      
      public function ResearchContainerDone(design:MovieClip, titleTid:String, descriptionTid:String, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,titleTid,descriptionTid,parent);
         resultContainers.add("Slot_Recipe",new ResearchResultRecipe(resultMC.getChildByName("Slot_Recipe") as MovieClip,"Button_Get","BUTTON_COLLECT",ingredientSlots.length,game));
         resultContainers.add("Slot_Money_and_Exp",new ResearchResultDone(resultMC.getChildByName("Slot_Money_and_Exp") as MovieClip,"Button_Get","BUTTON_COLLECT",ingredientSlots.length,game));
         resultContainers.add("Slot_Money",new ResearchResultDone(resultMC.getChildByName("Slot_Money") as MovieClip,"Button_Get","BUTTON_COLLECT",ingredientSlots.length,game));
         resultContainers.add("Slot_Exp",new ResearchResultDone(resultMC.getChildByName("Slot_Exp") as MovieClip,"Button_Get","BUTTON_COLLECT",ingredientSlots.length,game));
      }
      
      override public function shown() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.shown();
         var _loc3_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         if(tuxwars.home.ui.screen.crafting.Research._instance.isValidRecipe)
         {
            resultContainers.show("Slot_Recipe",false);
         }
         else
         {
            var _loc4_:Research = Research;
            if(!tuxwars.home.ui.screen.crafting.Research._instance)
            {
               new tuxwars.home.ui.screen.crafting.Research();
            }
            _loc2_ = int(tuxwars.home.ui.screen.crafting.Research._instance.failCoins);
            var _loc5_:Research = Research;
            if(!tuxwars.home.ui.screen.crafting.Research._instance)
            {
               new tuxwars.home.ui.screen.crafting.Research();
            }
            _loc1_ = int(tuxwars.home.ui.screen.crafting.Research._instance.failExp);
            if(_loc2_ > 0 && _loc1_ > 0)
            {
               resultContainers.show("Slot_Money_and_Exp",false);
            }
            else if(_loc1_ > 0)
            {
               resultContainers.show("Slot_Exp",false);
            }
            else if(_loc2_ > 0)
            {
               resultContainers.show("Slot_Money",false);
            }
         }
         ResearchResultBuild(resultContainers.getCurrentContainer()).button.setText(ProjectManager.getText("BUTTON_COLLECT"));
      }
   }
}
