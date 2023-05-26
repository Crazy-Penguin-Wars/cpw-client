package no.olog
{
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   internal class OpwPrompt extends Sprite
   {
       
      
      private var _tf:TextField;
      
      public function OpwPrompt()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         var matrix:Matrix = new Matrix();
         matrix.createGradientBox(200,30,1.5707963267948966);
         var bg:Shape = new Shape();
         var g:Graphics = bg.graphics;
         g.beginGradientFill("linear",Oplist.TB_COLORS,Oplist.TB_ALPHAS,Oplist.TB_RATIOS,matrix);
         g.drawRoundRect(0,0,200,30,5,5);
         g.endFill();
         addChild(bg);
         var label:TextField = new TextField();
         label.autoSize = "left";
         label.defaultTextFormat = new TextFormat("_sans",10,16777215);
         label.text = "Password:";
         label.x = 5;
         label.y = (30 - label.height) * 0.5;
         addChild(label);
         _tf = new TextField();
         _tf.defaultTextFormat = new TextFormat("_typewriter",12,16777215);
         _tf.type = "input";
         _tf.border = true;
         _tf.borderColor = 10066329;
         _tf.backgroundColor = 0;
         _tf.background = true;
         _tf.displayAsPassword = true;
         _tf.width = 200 - 5 * 3 - label.width;
         _tf.height = 30 - 5 * 2;
         _tf.x = label.x + label.width + 5;
         _tf.y = (30 - _tf.height) * 0.5 - 1;
         _tf.addEventListener("change",Ocore.validatePassword);
         _tf.setSelection(0,_tf.text.length - 1);
         addChild(_tf);
      }
      
      internal function get field() : TextField
      {
         return _tf;
      }
   }
}
