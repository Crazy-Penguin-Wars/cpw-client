package com.dchoc.ui.text
{
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.text.TextField;
   
   public class InputTextField extends TextField
   {
      private static const MAX_CHARS_NUM:int = 40;
      
      private var mEmptyText:String = "";
      
      private var mTextfield:TextField;
      
      private var mActive:Boolean = false;
      
      private var mChangeHandlerCallback:Function;
      
      public function InputTextField(param1:TextField, param2:String = "")
      {
         super();
         this.mTextfield = param1;
         this.description = param2;
         this.mTextfield.maxChars = 40;
         this.mTextfield.multiline = false;
         this.mTextfield.selectable = true;
         this.mTextfield.type = "input";
         this.mTextfield.alwaysShowSelection = true;
         this.mTextfield.text = this.mEmptyText;
         this.activate();
      }
      
      public function set keyboardChangeCallback(param1:Function) : void
      {
         if(param1 != null)
         {
            this.mChangeHandlerCallback = param1;
         }
      }
      
      public function set description(param1:String) : void
      {
         this.mEmptyText = param1;
      }
      
      public function get searchValue() : String
      {
         return this.mTextfield.text;
      }
      
      public function deactivate() : void
      {
         this.mActive = false;
         this.activateIntenal();
      }
      
      public function activate() : void
      {
         this.mActive = true;
         this.activateIntenal();
      }
      
      public function triggerDefaultOut() : void
      {
         this.mTextfield.text = this.mEmptyText;
      }
      
      public function clean() : void
      {
         this.mActive = false;
         this.mChangeHandlerCallback = null;
         this.mTextfield.removeEventListener("change",this.changeHandler);
         this.mTextfield.removeEventListener("focusIn",this.focusIN);
         this.mTextfield.removeEventListener("focusOut",this.focusOUT);
      }
      
      protected function focusIN(param1:FocusEvent) : void
      {
         if(this.mTextfield.text == this.mEmptyText)
         {
            this.mTextfield.text = "";
         }
      }
      
      protected function focusOUT(param1:FocusEvent) : void
      {
         if(this.mTextfield.text == "")
         {
            this.mTextfield.text = this.mEmptyText;
         }
      }
      
      protected function changeHandler(param1:Event) : void
      {
         if(this.mChangeHandlerCallback != null)
         {
            this.mChangeHandlerCallback();
         }
      }
      
      protected function activateIntenal() : void
      {
         if(this.mActive)
         {
            this.mTextfield.text = this.mEmptyText;
            this.mTextfield.addEventListener("change",this.changeHandler,false,0,true);
            this.mTextfield.addEventListener("focusIn",this.focusIN,false,0,true);
            this.mTextfield.addEventListener("focusOut",this.focusOUT,false,0,true);
            this.mTextfield.selectable = true;
         }
         else
         {
            this.mTextfield.text = this.mEmptyText;
            this.mTextfield.removeEventListener("change",this.changeHandler);
            this.mTextfield.removeEventListener("focusIn",this.focusIN);
            this.mTextfield.removeEventListener("focusOut",this.focusOUT);
            this.mTextfield.selectable = false;
         }
      }
   }
}

