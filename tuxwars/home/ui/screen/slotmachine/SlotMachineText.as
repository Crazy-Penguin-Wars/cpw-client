package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.slotmachine.SlotWinReference;
   import tuxwars.items.data.ItemData;
   import tuxwars.utils.*;
   
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
      
      public function SlotMachineText(param1:MovieClip)
      {
         super();
         this._design = param1;
         this.gotoDefault();
      }
      
      public function gotoRotation() : void
      {
         this.removeTextBigListeners();
         this._design.gotoAndStop("Rotation");
      }
      
      public function gotoWin(param1:SlotWinReference, param2:String, param3:ItemData, param4:int, param5:TuxWarsGame) : void
      {
         this.removeTextBigListeners();
         this._design.gotoAndStop("Win");
         this.content = (this._design as MovieClip).getChildByName("Content") as MovieClip;
         this.winAward = new SlotMachineAward(this.content.getChildByName("Award") as MovieClip,param5);
         this.winAward.showContainer(param1,param2,param3,param4);
         this.textBig = TuxUiUtils.createAutoTextFieldWithText(this.content.getChildByName("Text_Big") as TextField,"WIN");
         this.textBig.getTextField().addEventListener("frameConstructed",this.textBigFramWin);
         var _loc6_:int = int(DCUtils.indexOfLabel(this.content,"Stop"));
         this.content.addFrameScript(_loc6_,this.startNextLine);
      }
      
      public function gotoNoSpins() : void
      {
         this.removeTextBigListeners();
         this._design.gotoAndStop("No_Spins");
         this.content = (this._design as MovieClip).getChildByName("Content") as MovieClip;
         this.textBig = TuxUiUtils.createAutoTextFieldWithText(this.content.getChildByName("Text_Big") as TextField,"NO MORE SPINS");
         this.textBig.getTextField().addEventListener("frameConstructed",this.textBigFramNoSpins);
         this.textMessage = TuxUiUtils.createAutoTextFieldWithText(this.content.getChildByName("Text_Message") as TextField,"Add more or come back tomorrow");
         this.textMessage.getTextField().addEventListener("frameConstructed",this.textMessageFramNoSpins);
      }
      
      public function gotoDefault() : void
      {
         this.removeTextBigListeners();
         this._design.gotoAndStop("Default");
         this.content = (this._design as MovieClip).getChildByName("Content") as MovieClip;
         this.textBig = TuxUiUtils.createAutoTextFieldWithText(this.content.getChildByName("Text_Big") as TextField,"PRESS \'SPIN\'");
         this.textBig.getTextField().addEventListener("frameConstructed",this.textBigFramDefault);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in textLabelArray)
         {
            this._design.gotoAndStop(_loc1_);
            this.content = (this._design as MovieClip).getChildByName("Content") as MovieClip;
            this.textBig = TuxUiUtils.createAutoTextFieldWithText(this.content.getChildByName("Text_Big") as TextField,"");
            this.removeTextBigListeners();
            if(this.textMessage != null)
            {
               this.textMessage.getTextField().removeEventListener("frameConstructed",this.textMessageFramNoSpins);
            }
         }
         this.pressSpinContainer = null;
         this.noSpinsContainer = null;
         this.winContainer = null;
         this.content = null;
         this.noSpins = null;
         this.win = null;
      }
      
      private function removeTextBigListeners() : void
      {
         if(this.textBig != null)
         {
            this.textBig.getTextField().removeEventListener("frameConstructed",this.textBigFramNoSpins);
            this.textBig.getTextField().removeEventListener("frameConstructed",this.textBigFramDefault);
            this.textBig.getTextField().removeEventListener("frameConstructed",this.textBigFramWin);
         }
      }
      
      private function textBigFramWin(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("frameConstructed",this.textBigFramWin);
         if(this.content != null)
         {
            this.textBig.setTextField(this.content.getChildByName("Text_Big") as TextField);
            this.textBig.setText(ProjectManager.getText("SLOTMACHINE_WIN"));
            this.textBig.getTextField().addEventListener("frameConstructed",this.textBigFramWin);
         }
      }
      
      private function textBigFramDefault(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("frameConstructed",this.textBigFramDefault);
         if(this.content != null)
         {
            this.textBig.setTextField(this.content.getChildByName("Text_Big") as TextField);
            this.textBig.setText(ProjectManager.getText("SLOTMACHINE_PRESS_SPIN"));
            this.textBig.getTextField().addEventListener("frameConstructed",this.textBigFramDefault);
         }
      }
      
      private function textBigFramNoSpins(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("frameConstructed",this.textBigFramNoSpins);
         if(this.content != null)
         {
            this.textBig.setTextField(this.content.getChildByName("Text_Big") as TextField);
            this.textBig.setText(ProjectManager.getText("SLOTMACHINE_INSERT_CASH"));
            this.textBig.getTextField().addEventListener("frameConstructed",this.textBigFramNoSpins);
         }
      }
      
      private function textMessageFramNoSpins(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("frameConstructed",this.textMessageFramNoSpins);
         if(this.content != null)
         {
            if(this.content.getChildByName("Text_Message") != null)
            {
               this.textMessage.setTextField(this.content.getChildByName("Text_Message") as TextField);
               this.textMessage.setText(ProjectManager.getText("SLOTMACHINE_ADD_OR_RETURN"));
               this.textMessage.getTextField().addEventListener("frameConstructed",this.textMessageFramNoSpins);
            }
         }
      }
      
      private function startNextLine() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this.content,"Stop"));
         this.content.addFrameScript(_loc1_,null);
         this.content.gotoAndStop("Stop");
         this.removeTextBigListeners();
         MessageCenter.sendMessage("NextWinLine");
      }
   }
}

