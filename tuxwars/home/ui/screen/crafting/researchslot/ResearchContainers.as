package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.*;
   
   public class ResearchContainers extends UIContainers
   {
      public static const COMPLETED:String = "Slot_Done";
      
      public static const ONGOING:String = "Slot_Ongoing";
      
      public static const START:String = "Slot_Default";
      
      public function ResearchContainers(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         add("Slot_Done",new ResearchContainerDone(param1.getChildByName("Slot_Done") as MovieClip,"RESEARCH_COLLECT_RECEPIEFOUND_TITLE","RESEARCH_COLLECT_RECEPIEFOUND_DESCRIPTION",param2));
         add("Slot_Ongoing",new ResearchContainerOngoing(param1.getChildByName("Slot_Ongoing") as MovieClip,"RESEARCH_ONGOING_TITLE","RESEARCH_ONGOING_DESCRIPTION",param2));
         add("Slot_Default",new ResearchContainerStart(param1.getChildByName("Slot_Default") as MovieClip,"RESEARCH_START_TITLE",null,param2));
         MessageCenter.addListener("ResearchStart",this.changeDisplayedScreen);
         MessageCenter.addListener("ResearchUpdateScreen",this.changeDisplayedScreen);
         this.changeDisplayedScreen(null);
      }
      
      private function changeDisplayedScreen(param1:Message) : void
      {
         if(!Research._instance)
         {
            new Research();
         }
         if(!Research._instance.hasTimeLeft)
         {
            if(!Research._instance)
            {
               new Research();
            }
            if(Research._instance.completed)
            {
               show("Slot_Done",false);
            }
            else
            {
               show("Slot_Default",false);
            }
         }
         else
         {
            show("Slot_Ongoing",false);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("ResearchStart",this.changeDisplayedScreen);
         MessageCenter.removeListener("ResearchUpdateScreen",this.changeDisplayedScreen);
      }
   }
}

