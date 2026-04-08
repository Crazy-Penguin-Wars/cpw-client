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
      
      public function UIAutoTextField(param1:TextField = null)
      {
         super();
         if(param1)
         {
            this.setTextField(param1);
            this.setText(param1.text);
         }
      }
      
      public function setTextField(param1:TextField) : void
      {
         if(!param1)
         {
            return;
         }
         this.originalFieldX = param1.x;
         this.originalFieldY = param1.y;
         this.originalFieldHeight = param1.height;
         this.originalFieldWidth = param1.width;
         this.textField = param1;
         this.textField.selectable = false;
         this.textField.mouseEnabled = false;
         this.applyCommands();
         var _loc2_:String = this.textField.defaultTextFormat.align;
         if(_loc2_ == "left")
         {
            this.horizontalAlignment = 4;
         }
         else if(_loc2_ == "right")
         {
            this.horizontalAlignment = 5;
         }
         else if(_loc2_ == "center")
         {
            this.horizontalAlignment = 3;
         }
         else
         {
            this.horizontalAlignment = 3;
         }
      }
      
      public function applyCommands() : void
      {
         this.capitalize = this.textField.text.indexOf("@CAPS") != -1;
         this.textField.text = this.textField.text.replace("@CAPS","");
         this.verticalAlignment = this.textField.text.indexOf("@VC") != -1 ? 1 : 0;
         this.textField.text = this.textField.text.replace("@VC","");
      }
      
      public function setVerticalAlignment(param1:int, param2:Boolean = true) : void
      {
         this.verticalAlignment = param1;
         if(param2)
         {
            this.setText(this.getText());
         }
      }
      
      public function setMutliline(param1:Boolean) : void
      {
         this.textField.multiline = param1;
      }
      
      public function getMultiline() : Boolean
      {
         return this.textField.multiline;
      }
      
      public function getTextField() : TextField
      {
         return this.textField;
      }
      
      public function getHorizontalAlignment() : int
      {
         return this.horizontalAlignment;
      }
      
      public function setHorizontalAlignment(param1:int, param2:Boolean = true) : void
      {
         this.horizontalAlignment = param1;
         if(param2)
         {
            this.setText(this.getText());
         }
      }
      
      public function setText(param1:String) : void
      {
         var _loc2_:Number = Number(NaN);
         if(this.textField == null || param1 == null)
         {
            return;
         }
         if(this.capitalize)
         {
            this.textField.text = param1.toUpperCase();
         }
         else
         {
            this.textField.text = param1;
         }
         var _loc3_:Number = 1;
         this.textField.scaleX = 1;
         this.textField.scaleY = 1;
         if(this.textField.rotation == 0 || this.originalFieldWidth == 0)
         {
            this.textField.width = this.originalFieldWidth;
         }
         if(this.textField.rotation == 0 || this.originalFieldHeight == 0)
         {
            this.textField.height = this.originalFieldHeight;
         }
         if(this.textField.rotation == 0 || this.originalFieldHeight == 0)
         {
            this.textField.x = this.originalFieldX;
         }
         if(this.textField.rotation == 0 || this.originalFieldHeight == 0)
         {
            this.textField.y = this.originalFieldY;
         }
         if(this.getMultiline())
         {
            while(this.textField.textHeight * _loc3_ > this.originalFieldHeight && _loc3_ >= this.minimumScale)
            {
               _loc3_ -= this.scalingStep;
               _loc2_ = this.originalFieldWidth * (1 / _loc3_);
               this.textField.scaleX = _loc3_;
               this.textField.scaleY = _loc3_;
               this.textField.width = _loc2_;
            }
            this.textField.height = this.textField.textHeight + 4;
         }
         else
         {
            while(this.textField.textWidth * _loc3_ > this.originalFieldWidth && _loc3_ >= this.minimumScale)
            {
               _loc3_ -= this.scalingStep;
               _loc2_ = this.originalFieldWidth * (1 / _loc3_);
               this.textField.scaleX = _loc3_;
               this.textField.scaleY = _loc3_;
               this.textField.width = _loc2_;
               this.textField.height = this.originalFieldHeight * (1 / _loc3_);
            }
            if(this.horizontalAlignment == 3)
            {
               this.textField.x = this.originalFieldX + 0.5 * (this.originalFieldWidth - this.textField.width);
            }
         }
         if(this.verticalAlignment == 1)
         {
            this.textField.y = this.originalFieldY + 0.5 * (this.originalFieldHeight - this.textField.height);
         }
         else if(this.verticalAlignment == 2)
         {
            this.textField.y = this.originalFieldY + (this.originalFieldHeight - this.textField.height);
         }
         else
         {
            this.textField.y = this.originalFieldY;
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.textField.visible = param1;
      }
      
      public function getText() : String
      {
         return this.textField.text;
      }
      
      public function getOriginalBoxHeight() : Number
      {
         return this.originalFieldHeight;
      }
      
      public function getOriginalBoxWidth() : Number
      {
         return this.originalFieldWidth;
      }
   }
}

