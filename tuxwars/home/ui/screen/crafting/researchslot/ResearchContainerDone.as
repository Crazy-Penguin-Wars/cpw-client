package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.*;
   
   public class ResearchContainerDone extends ResearchContainer
   {
      public static const RECEPIE:String = "Slot_Recipe";
      
      public static const MONEY_EXP:String = "Slot_Money_and_Exp";
      
      public static const EXP:String = "Slot_Exp";
      
      public static const MONEY:String = "Slot_Money";
      
      public function ResearchContainerDone(param1:MovieClip, param2:String, param3:String, param4:TuxWarsGame, param5:UIComponent = null)
      {
         super(param1,param2,param3,param5);
         resultContainers.add("Slot_Recipe",new ResearchResultRecipe(resultMC.getChildByName("Slot_Recipe") as MovieClip,"Button_Get","BUTTON_COLLECT",ingredientSlots.length,param4));
         resultContainers.add("Slot_Money_and_Exp",new ResearchResultDone(resultMC.getChildByName("Slot_Money_and_Exp") as MovieClip,"Button_Get","BUTTON_COLLECT",ingredientSlots.length,param4));
         resultContainers.add("Slot_Money",new ResearchResultDone(resultMC.getChildByName("Slot_Money") as MovieClip,"Button_Get","BUTTON_COLLECT",ingredientSlots.length,param4));
         resultContainers.add("Slot_Exp",new ResearchResultDone(resultMC.getChildByName("Slot_Exp") as MovieClip,"Button_Get","BUTTON_COLLECT",ingredientSlots.length,param4));
      }
      
      override public function shown() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.shown();
         if(!Research._instance)
         {
            new Research();
         }
         if(Research._instance.isValidRecipe)
         {
            resultContainers.show("Slot_Recipe",false);
         }
         else
         {
            if(!Research._instance)
            {
               new Research();
            }
            _loc1_ = int(Research._instance.failCoins);
            if(!Research._instance)
            {
               new Research();
            }
            _loc2_ = int(Research._instance.failExp);
            if(_loc1_ > 0 && _loc2_ > 0)
            {
               resultContainers.show("Slot_Money_and_Exp",false);
            }
            else if(_loc2_ > 0)
            {
               resultContainers.show("Slot_Exp",false);
            }
            else if(_loc1_ > 0)
            {
               resultContainers.show("Slot_Money",false);
            }
         }
         ResearchResultBuild(resultContainers.getCurrentContainer()).button.setText(ProjectManager.getText("BUTTON_COLLECT"));
      }
   }
}

