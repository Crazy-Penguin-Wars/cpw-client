package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.utils.TuxUiUtils;
   
   public class SlotMachineLine
   {
       
      
      private var _design:MovieClip;
      
      private var _lineNumber:int;
      
      private var content:MovieClip;
      
      private var lineText:UIAutoTextField;
      
      private var _value:String;
      
      public function SlotMachineLine(design:MovieClip, lineNumber:int, value:String)
      {
         super();
         _design = design;
         _lineNumber = lineNumber;
         _value = value;
         design.gotoAndStop("Disabled");
         content = (_design as MovieClip).getChildByName("Content") as MovieClip;
         lineText = TuxUiUtils.createAutoTextFieldWithText(content.getChildByName("Text") as TextField,_value);
      }
      
      public function setActiveState() : void
      {
         var index:int = 0;
         if(_design != null)
         {
            _design.gotoAndStop("Active");
            content = (_design as MovieClip).getChildByName("Content") as MovieClip;
            index = DCUtils.indexOfLabel(content,"Stop");
            content.addFrameScript(index,null);
            content.gotoAndStop("Default");
            setText(_value);
         }
      }
      
      public function setWinState() : void
      {
         var index:int = 0;
         if(_design != null)
         {
            _design.gotoAndStop("Active");
            content = (_design as MovieClip).getChildByName("Content") as MovieClip;
            index = DCUtils.indexOfLabel(content,"Stop");
            content.addFrameScript(index,setActiveState);
            content.gotoAndPlay("Win");
         }
      }
      
      public function setDefaultState() : void
      {
         if(_design != null)
         {
            _design.gotoAndStop("Default");
            setText(_value);
         }
      }
      
      public function setDisabledState() : void
      {
         if(_design != null)
         {
            _design.gotoAndStop("Disabled");
            setText(_value);
         }
      }
      
      public function dispose() : void
      {
         _design = null;
         lineText = null;
      }
      
      public function setText(value:String) : void
      {
         if(_design != null)
         {
            content = (_design as MovieClip).getChildByName("Content") as MovieClip;
            lineText.setTextField(content.getChildByName("Text") as TextField);
            lineText.setText(value);
         }
      }
   }
}
