package com.dchoc.ui.text
{
   import flash.text.TextField;
   
   public class UIAutoTextField
   {
      
      public static const ALIGNMENT_TOP:int = 0;
      
      public static const ALIGNMENT_VCENTER:int = 1;
      
      public static const ALIGNMENT_BOTTOM:int = 2;
      
      public static const ALIGNMENT_HCENTER:int = 3;
      
      public static const ALIGNMENT_HLEFT:int = 4;
      
      public static const ALIGNMENT_HRIGHT:int = 5;
      
      public static const COMMAND_CAPS:String = "@CAPS";
      
      public static const COMMAND_VERTICAL_CENTER:String = "@VC";
       
      
      private var textField:TextField;
      
      private var originalFieldHeight:Number;
      
      private var originalFieldWidth:Number;
      
      private var originalFieldX:Number;
      
      private var originalFieldY:Number;
      
      private var minimumScale:Number = 0.3;
      
      private var scalingStep:Number = 0.05;
      
      private var o:Number = 0.05;
      
      private var verticalAlignment:int;
      
      private var horizontalAlignment:int;
      
      private var capitalize:Boolean;
      
      public function UIAutoTextField(tf:TextField = null)
      {
         super();
         if(tf)
         {
            setTextField(tf);
            setText(tf.text);
         }
      }
      
      public function setTextField(tf:TextField) : void
      {
         if(!tf)
         {
            return;
         }
         originalFieldX = tf.x;
         originalFieldY = tf.y;
         originalFieldHeight = tf.height;
         originalFieldWidth = tf.width;
         textField = tf;
         textField.selectable = false;
         textField.mouseEnabled = false;
         applyCommands();
         var align:String = textField.defaultTextFormat.align;
         if(align == "left")
         {
            horizontalAlignment = 4;
         }
         else if(align == "right")
         {
            horizontalAlignment = 5;
         }
         else if(align == "center")
         {
            horizontalAlignment = 3;
         }
         else
         {
            horizontalAlignment = 3;
         }
      }
      
      public function applyCommands() : void
      {
         capitalize = textField.text.indexOf("@CAPS") != -1;
         textField.text = textField.text.replace("@CAPS","");
         verticalAlignment = textField.text.indexOf("@VC") != -1 ? 1 : 0;
         textField.text = textField.text.replace("@VC","");
      }
      
      public function setVerticalAlignment(verticalAlignment:int, updateText:Boolean = true) : void
      {
         this.verticalAlignment = verticalAlignment;
         if(updateText)
         {
            setText(getText());
         }
      }
      
      public function setMutliline(on:Boolean) : void
      {
         textField.multiline = on;
      }
      
      public function getMultiline() : Boolean
      {
         return textField.multiline;
      }
      
      public function getTextField() : TextField
      {
         return textField;
      }
      
      public function getHorizontalAlignment() : int
      {
         return horizontalAlignment;
      }
      
      public function setHorizontalAlignment(horizontalAlignment:int, updateText:Boolean = true) : void
      {
         this.horizontalAlignment = horizontalAlignment;
         if(updateText)
         {
            setText(getText());
         }
      }
      
      public function setText(text:String) : void
      {
         var oldW:Number = NaN;
         if(textField == null || text == null)
         {
            return;
         }
         if(capitalize)
         {
            textField.text = text.toUpperCase();
         }
         else
         {
            textField.text = text;
         }
         var scale:Number = 1;
         textField.scaleX = 1;
         textField.scaleY = 1;
         if(textField.rotation == 0 || originalFieldWidth == 0)
         {
            textField.width = originalFieldWidth;
         }
         if(textField.rotation == 0 || originalFieldHeight == 0)
         {
            textField.height = originalFieldHeight;
         }
         if(textField.rotation == 0 || originalFieldHeight == 0)
         {
            textField.x = originalFieldX;
         }
         if(textField.rotation == 0 || originalFieldHeight == 0)
         {
            textField.y = originalFieldY;
         }
         if(getMultiline())
         {
            while(textField.textHeight * scale > originalFieldHeight && scale >= minimumScale)
            {
               scale -= scalingStep;
               oldW = originalFieldWidth * (1 / scale);
               textField.scaleX = scale;
               textField.scaleY = scale;
               textField.width = oldW;
            }
            textField.height = textField.textHeight + 4;
         }
         else
         {
            while(textField.textWidth * scale > originalFieldWidth && scale >= minimumScale)
            {
               scale -= scalingStep;
               oldW = originalFieldWidth * (1 / scale);
               textField.scaleX = scale;
               textField.scaleY = scale;
               textField.width = oldW;
               textField.height = originalFieldHeight * (1 / scale);
            }
            if(horizontalAlignment == 3)
            {
               textField.x = originalFieldX + 0.5 * (originalFieldWidth - textField.width);
            }
         }
         if(verticalAlignment == 1)
         {
            textField.y = originalFieldY + 0.5 * (originalFieldHeight - textField.height);
         }
         else if(verticalAlignment == 2)
         {
            textField.y = originalFieldY + (originalFieldHeight - textField.height);
         }
         else
         {
            textField.y = originalFieldY;
         }
      }
      
      public function setVisible(visible:Boolean) : void
      {
         textField.visible = visible;
      }
      
      public function getText() : String
      {
         return textField.text;
      }
      
      public function getOriginalBoxHeight() : Number
      {
         return originalFieldHeight;
      }
      
      public function getOriginalBoxWidth() : Number
      {
         return originalFieldWidth;
      }
   }
}
