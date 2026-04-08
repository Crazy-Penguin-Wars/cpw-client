package no.olog
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   internal class OpwPrompt extends Sprite
   {
      private var _tf:TextField;
      
      public function OpwPrompt()
      {
         super();
         this._init();
      }
      
      private function _init() : void
      {
         var _loc1_:int = int(Oplist.PW_BOX_WIDTH);
         var _loc2_:int = int(Oplist.PW_BOX_HEIGHT);
         var _loc3_:int = int(Oplist.PADDING);
         var _loc4_:int = int(Oplist.CORNER_RADIUS);
         var _loc5_:Matrix = new Matrix();
         _loc5_.createGradientBox(_loc1_,_loc2_,Math.PI / 180 * 90);
         var _loc6_:Shape = new Shape();
         var _loc7_:Graphics = _loc6_.graphics;
         _loc7_.beginGradientFill(GradientType.LINEAR,Oplist.TB_COLORS,Oplist.TB_ALPHAS,Oplist.TB_RATIOS,_loc5_);
         _loc7_.drawRoundRect(0,0,_loc1_,_loc2_,_loc4_,_loc4_);
         _loc7_.endFill();
         addChild(_loc6_);
         var _loc8_:TextField = new TextField();
         _loc8_.autoSize = TextFieldAutoSize.LEFT;
         _loc8_.defaultTextFormat = new TextFormat(Oplist.TB_FONT,Oplist.TB_FONT_SIZE,16777215);
         _loc8_.text = Oplist.PWPROMPT_LABEL;
         _loc8_.x = _loc3_;
         _loc8_.y = (_loc2_ - _loc8_.height) * 0.5;
         addChild(_loc8_);
         this._tf = new TextField();
         this._tf.defaultTextFormat = new TextFormat(Oplist.FONT,12,16777215);
         this._tf.type = TextFieldType.INPUT;
         this._tf.border = true;
         this._tf.borderColor = Oplist.BTN_LINE_COLOR;
         this._tf.backgroundColor = 0;
         this._tf.background = true;
         this._tf.displayAsPassword = true;
         this._tf.width = _loc1_ - _loc3_ * 3 - _loc8_.width;
         this._tf.height = _loc2_ - _loc3_ * 2;
         this._tf.x = _loc8_.x + _loc8_.width + _loc3_;
         this._tf.y = (_loc2_ - this._tf.height) * 0.5 - 1;
         this._tf.addEventListener(Event.CHANGE,Ocore.validatePassword);
         this._tf.setSelection(0,this._tf.text.length - 1);
         addChild(this._tf);
      }
      
      internal function get field() : TextField
      {
         return this._tf;
      }
   }
}

