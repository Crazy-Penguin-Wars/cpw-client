package tuxwars.home.ui.screen.crafting.researchslot.collect
{
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.TextUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.Tuner;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.utils.TuxUiUtils;
   
   public class ResearchResultTimer extends ResearchResultBuild
   {
       
      
      private var timeTF:UIAutoTextField;
      
      private var timePi:MovieClip;
      
      public function ResearchResultTimer(design:MovieClip, buttonName:String, buttonTid:String, ingridientsSlots:int, game:TuxWarsGame)
      {
         super(design,buttonName,buttonTid,ingridientsSlots,game,"TOOLTIP_RESEARCH_INSTANT");
         var _loc6_:Tuner = Tuner;
         button.setText(tuxwars.data.Tuner.getField("ResearchInstantCompleteCost").value.toString());
         updateButton(null);
         timeTF = TuxUiUtils.createAutoTextField(design.getChildByName("Text") as TextField,null);
         timePi = design.getChildByName("Fill") as MovieClip;
         LogicUpdater.register(this);
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         var _loc5_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         var _loc4_:int = int(tuxwars.home.ui.screen.crafting.Research._instance.remainingTime);
         var _loc6_:Tuner = Tuner;
         var _loc3_:int = int(tuxwars.data.Tuner.getField("ResearchDuration").value);
         timeTF.setText(TextUtils.getShortTimeTextFromSeconds(_loc4_ / 1000));
         var _loc2_:int = timePi.totalFrames * (1 - _loc4_ / _loc3_);
         timePi.gotoAndStop(_loc2_);
      }
      
      override protected function updateButton(msg:Message) : void
      {
         if(game != null)
         {
            var _loc2_:Tuner = Tuner;
            button.setEnabled(game.player.premiumMoney >= tuxwars.data.Tuner.getField("ResearchInstantCompleteCost").value);
         }
      }
      
      override protected function buttonPressed(event:MouseEvent) : void
      {
         MessageCenter.sendMessage("ResearchCompleteInstant");
         button.setEnabled(false);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         LogicUpdater.unregister(this);
      }
   }
}
