package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.Research;
   
   public class ResearchContainers extends UIContainers
   {
      
      public static const COMPLETED:String = "Slot_Done";
      
      public static const ONGOING:String = "Slot_Ongoing";
      
      public static const START:String = "Slot_Default";
       
      
      public function ResearchContainers(design:MovieClip, game:TuxWarsGame)
      {
         super();
         add("Slot_Done",new ResearchContainerDone(design.getChildByName("Slot_Done") as MovieClip,"RESEARCH_COLLECT_RECEPIEFOUND_TITLE","RESEARCH_COLLECT_RECEPIEFOUND_DESCRIPTION",game));
         add("Slot_Ongoing",new ResearchContainerOngoing(design.getChildByName("Slot_Ongoing") as MovieClip,"RESEARCH_ONGOING_TITLE","RESEARCH_ONGOING_DESCRIPTION",game));
         add("Slot_Default",new ResearchContainerStart(design.getChildByName("Slot_Default") as MovieClip,"RESEARCH_START_TITLE",null,game));
         MessageCenter.addListener("ResearchStart",changeDisplayedScreen);
         MessageCenter.addListener("ResearchUpdateScreen",changeDisplayedScreen);
         changeDisplayedScreen(null);
      }
      
      private function changeDisplayedScreen(event:Message) : void
      {
         var _loc2_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         if(!tuxwars.home.ui.screen.crafting.Research._instance.hasTimeLeft)
         {
            var _loc3_:Research = Research;
            if(!tuxwars.home.ui.screen.crafting.Research._instance)
            {
               new tuxwars.home.ui.screen.crafting.Research();
            }
            if(tuxwars.home.ui.screen.crafting.Research._instance.completed)
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
         MessageCenter.removeListener("ResearchStart",changeDisplayedScreen);
         MessageCenter.removeListener("ResearchUpdateScreen",changeDisplayedScreen);
      }
   }
}
