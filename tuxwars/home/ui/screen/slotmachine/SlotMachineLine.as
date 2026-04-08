package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.utils.*;
   
   public class SlotMachineLine
   {
      private var _design:MovieClip;
      
      private var _lineNumber:int;
      
      private var content:MovieClip;
      
      private var lineText:UIAutoTextField;
      
      private var _value:String;
      
      public function SlotMachineLine(param1:MovieClip, param2:int, param3:String)
      {
         super();
         this._design = param1;
         this._lineNumber = param2;
         this._value = param3;
         param1.gotoAndStop("Disabled");
         this.content = (this._design as MovieClip).getChildByName("Content") as MovieClip;
         this.lineText = TuxUiUtils.createAutoTextFieldWithText(this.content.getChildByName("Text") as TextField,this._value);
      }
      
      public function setActiveState() : void
      {
         var _loc1_:int = 0;
         if(this._design != null)
         {
            this._design.gotoAndStop("Active");
            this.content = (this._design as MovieClip).getChildByName("Content") as MovieClip;
            _loc1_ = int(DCUtils.indexOfLabel(this.content,"Stop"));
            this.content.addFrameScript(_loc1_,null);
            this.content.gotoAndStop("Default");
            this.setText(this._value);
         }
      }
      
      public function setWinState() : void
      {
         var _loc1_:int = 0;
         if(this._design != null)
         {
            this._design.gotoAndStop("Active");
            this.content = (this._design as MovieClip).getChildByName("Content") as MovieClip;
            _loc1_ = int(DCUtils.indexOfLabel(this.content,"Stop"));
            this.content.addFrameScript(_loc1_,this.setActiveState);
            this.content.gotoAndPlay("Win");
         }
      }
      
      public function setDefaultState() : void
      {
         if(this._design != null)
         {
            this._design.gotoAndStop("Default");
            this.setText(this._value);
         }
      }
      
      public function setDisabledState() : void
      {
         if(this._design != null)
         {
            this._design.gotoAndStop("Disabled");
            this.setText(this._value);
         }
      }
      
      public function dispose() : void
      {
         this._design = null;
         this.lineText = null;
      }
      
      public function setText(param1:String) : void
      {
         if(this._design != null)
         {
            this.content = (this._design as MovieClip).getChildByName("Content") as MovieClip;
            this.lineText.setTextField(this.content.getChildByName("Text") as TextField);
            this.lineText.setText(param1);
         }
      }
   }
}

