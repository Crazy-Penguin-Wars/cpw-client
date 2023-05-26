package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.slotmachine.SlotWinReference;
   import tuxwars.items.data.ItemData;
   import tuxwars.utils.TuxUiUtils;
   
   public class SlotMachineText
   {
      
      private static const textLabelArray:Array = ["Win","No_Spins","Default"];
      
      private static const finnTextArray:Array = ["VOITIT!","PAINA \'SPIN\'","SPINNIT LOPPU","Lisää spinnejä tai tule huomenna uudestaan"];
      
      private static const engTextArray:Array = ["YOU WIN!","PRESS \'SPIN\'","NO MORE SPINS","Add more or come back tomorrow"];
       
      
      private var _design:MovieClip;
      
      private var pressSpinContainer:MovieClip;
      
      private var noSpinsContainer:MovieClip;
      
      private var winContainer:MovieClip;
      
      private var content:MovieClip;
      
      private var textBig:UIAutoTextField;
      
      private var textMessage:UIAutoTextField;
      
      private var noSpins:UIAutoTextField;
      
      private var win:UIAutoTextField;
      
      private var winAward:SlotMachineAward;
      
      public function SlotMachineText(design:MovieClip)
      {
         super();
         _design = design;
         gotoDefault();
      }
      
      public function gotoRotation() : void
      {
         removeTextBigListeners();
         _design.gotoAndStop("Rotation");
      }
      
      public function gotoWin(value:SlotWinReference, type:String, itemIcon:ItemData, itemValue:int, game:TuxWarsGame) : void
      {
         removeTextBigListeners();
         _design.gotoAndStop("Win");
         content = (_design as MovieClip).getChildByName("Content") as MovieClip;
         winAward = new SlotMachineAward(content.getChildByName("Award") as MovieClip,game);
         winAward.showContainer(value,type,itemIcon,itemValue);
         textBig = TuxUiUtils.createAutoTextFieldWithText(content.getChildByName("Text_Big") as TextField,"WIN");
         textBig.getTextField().addEventListener("frameConstructed",textBigFramWin);
         var index:int = DCUtils.indexOfLabel(content,"Stop");
         content.addFrameScript(index,startNextLine);
      }
      
      public function gotoNoSpins() : void
      {
         removeTextBigListeners();
         _design.gotoAndStop("No_Spins");
         content = (_design as MovieClip).getChildByName("Content") as MovieClip;
         textBig = TuxUiUtils.createAutoTextFieldWithText(content.getChildByName("Text_Big") as TextField,"NO MORE SPINS");
         textBig.getTextField().addEventListener("frameConstructed",textBigFramNoSpins);
         textMessage = TuxUiUtils.createAutoTextFieldWithText(content.getChildByName("Text_Message") as TextField,"Add more or come back tomorrow");
         textMessage.getTextField().addEventListener("frameConstructed",textMessageFramNoSpins);
      }
      
      public function gotoDefault() : void
      {
         removeTextBigListeners();
         _design.gotoAndStop("Default");
         content = (_design as MovieClip).getChildByName("Content") as MovieClip;
         textBig = TuxUiUtils.createAutoTextFieldWithText(content.getChildByName("Text_Big") as TextField,"PRESS \'SPIN\'");
         textBig.getTextField().addEventListener("frameConstructed",textBigFramDefault);
      }
      
      public function dispose() : void
      {
         for each(var textString in textLabelArray)
         {
            _design.gotoAndStop(textString);
            content = (_design as MovieClip).getChildByName("Content") as MovieClip;
            textBig = TuxUiUtils.createAutoTextFieldWithText(content.getChildByName("Text_Big") as TextField,"");
            removeTextBigListeners();
            if(textMessage != null)
            {
               textMessage.getTextField().removeEventListener("frameConstructed",textMessageFramNoSpins);
            }
         }
         pressSpinContainer = null;
         noSpinsContainer = null;
         winContainer = null;
         content = null;
         noSpins = null;
         win = null;
      }
      
      private function removeTextBigListeners() : void
      {
         if(textBig != null)
         {
            textBig.getTextField().removeEventListener("frameConstructed",textBigFramNoSpins);
            textBig.getTextField().removeEventListener("frameConstructed",textBigFramDefault);
            textBig.getTextField().removeEventListener("frameConstructed",textBigFramWin);
         }
      }
      
      private function textBigFramWin(event:Event) : void
      {
         event.currentTarget.removeEventListener("frameConstructed",textBigFramWin);
         if(content != null)
         {
            textBig.setTextField(content.getChildByName("Text_Big") as TextField);
            textBig.setText(ProjectManager.getText("SLOTMACHINE_WIN"));
            textBig.getTextField().addEventListener("frameConstructed",textBigFramWin);
         }
      }
      
      private function textBigFramDefault(event:Event) : void
      {
         event.currentTarget.removeEventListener("frameConstructed",textBigFramDefault);
         if(content != null)
         {
            textBig.setTextField(content.getChildByName("Text_Big") as TextField);
            textBig.setText(ProjectManager.getText("SLOTMACHINE_PRESS_SPIN"));
            textBig.getTextField().addEventListener("frameConstructed",textBigFramDefault);
         }
      }
      
      private function textBigFramNoSpins(event:Event) : void
      {
         event.currentTarget.removeEventListener("frameConstructed",textBigFramNoSpins);
         if(content != null)
         {
            textBig.setTextField(content.getChildByName("Text_Big") as TextField);
            textBig.setText(ProjectManager.getText("SLOTMACHINE_INSERT_CASH"));
            textBig.getTextField().addEventListener("frameConstructed",textBigFramNoSpins);
         }
      }
      
      private function textMessageFramNoSpins(event:Event) : void
      {
         event.currentTarget.removeEventListener("frameConstructed",textMessageFramNoSpins);
         if(content != null)
         {
            if(content.getChildByName("Text_Message") != null)
            {
               textMessage.setTextField(content.getChildByName("Text_Message") as TextField);
               textMessage.setText(ProjectManager.getText("SLOTMACHINE_ADD_OR_RETURN"));
               textMessage.getTextField().addEventListener("frameConstructed",textMessageFramNoSpins);
            }
         }
      }
      
      private function startNextLine() : void
      {
         var index:int = DCUtils.indexOfLabel(content,"Stop");
         content.addFrameScript(index,null);
         content.gotoAndStop("Stop");
         removeTextBigListeners();
         MessageCenter.sendMessage("NextWinLine");
      }
   }
}
