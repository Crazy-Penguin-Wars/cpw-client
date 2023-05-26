package tuxwars.home.ui.screen.crafting.researchslot.collect
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.utils.TuxUiUtils;
   
   public class ResearchResultDone extends ResearchResultBuild
   {
       
      
      private var coinsTF:UIAutoTextField;
      
      private var expTF:UIAutoTextField;
      
      public function ResearchResultDone(design:MovieClip, buttonName:String, buttonTid:String, ingridientsSlots:int, game:TuxWarsGame)
      {
         super(design,buttonName,buttonTid,ingridientsSlots,game,"TOOLTIP_RESEARCH_COLLECT");
         if(design.Text_Coins)
         {
            coinsTF = TuxUiUtils.createAutoTextField(design.Text_Coins,null);
         }
         if(design.Text_Exp)
         {
            expTF = TuxUiUtils.createAutoTextField(design.Text_Exp,null);
         }
      }
      
      override protected function buttonPressed(event:MouseEvent) : void
      {
         var _loc2_:Research = Research;
         §§push(MessageCenter);
         §§push("CollectResearchRewards");
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         §§pop().sendMessage(§§pop(),tuxwars.home.ui.screen.crafting.Research._instance.currentIngredients);
         MessageCenter.addListener("CollectResearchRewardsResponse",buttonPressedCallBack);
      }
      
      public function buttonPressedCallBack(msg:Message) : void
      {
         MessageCenter.removeListener("CollectResearchRewardsResponse",buttonPressedCallBack);
         var _loc2_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         tuxwars.home.ui.screen.crafting.Research._instance.completeResearch(game.player);
      }
      
      override public function shown() : void
      {
         if(coinsTF)
         {
            var _loc1_:Research = Research;
            §§push(coinsTF);
            if(!tuxwars.home.ui.screen.crafting.Research._instance)
            {
               new tuxwars.home.ui.screen.crafting.Research();
            }
            §§pop().setText(tuxwars.home.ui.screen.crafting.Research._instance.failCoins.toString());
         }
         if(expTF)
         {
            var _loc2_:Research = Research;
            §§push(expTF);
            if(!tuxwars.home.ui.screen.crafting.Research._instance)
            {
               new tuxwars.home.ui.screen.crafting.Research();
            }
            §§pop().setText(tuxwars.home.ui.screen.crafting.Research._instance.failExp.toString());
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("CollectResearchRewardsResponse",buttonPressedCallBack);
      }
   }
}
