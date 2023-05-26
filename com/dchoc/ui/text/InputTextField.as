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
      
      public function InputTextField(textfield:TextField, emptyDescription:String = "")
      {
         super();
         mTextfield = textfield;
         description = emptyDescription;
         mTextfield.maxChars = 40;
         mTextfield.multiline = false;
         mTextfield.selectable = true;
         mTextfield.type = "input";
         mTextfield.alwaysShowSelection = true;
         mTextfield.text = mEmptyText;
         activate();
      }
      
      public function set keyboardChangeCallback(value:Function) : void
      {
         if(value != null)
         {
            mChangeHandlerCallback = value;
         }
      }
      
      public function set description(value:String) : void
      {
         mEmptyText = value;
      }
      
      public function get searchValue() : String
      {
         return mTextfield.text;
      }
      
      public function deactivate() : void
      {
         mActive = false;
         activateIntenal();
      }
      
      public function activate() : void
      {
         mActive = true;
         activateIntenal();
      }
      
      public function triggerDefaultOut() : void
      {
         mTextfield.text = mEmptyText;
      }
      
      public function clean() : void
      {
         mActive = false;
         mChangeHandlerCallback = null;
         mTextfield.removeEventListener("change",changeHandler);
         mTextfield.removeEventListener("focusIn",focusIN);
         mTextfield.removeEventListener("focusOut",focusOUT);
      }
      
      protected function focusIN(event:FocusEvent) : void
      {
         if(mTextfield.text == mEmptyText)
         {
            mTextfield.text = "";
         }
      }
      
      protected function focusOUT(event:FocusEvent) : void
      {
         if(mTextfield.text == "")
         {
            mTextfield.text = mEmptyText;
         }
      }
      
      protected function changeHandler(event:Event) : void
      {
         if(mChangeHandlerCallback != null)
         {
            mChangeHandlerCallback();
         }
      }
      
      protected function activateIntenal() : void
      {
         if(mActive)
         {
            mTextfield.text = mEmptyText;
            mTextfield.addEventListener("change",changeHandler,false,0,true);
            mTextfield.addEventListener("focusIn",focusIN,false,0,true);
            mTextfield.addEventListener("focusOut",focusOUT,false,0,true);
            mTextfield.selectable = true;
         }
         else
         {
            mTextfield.text = mEmptyText;
            mTextfield.removeEventListener("change",changeHandler);
            mTextfield.removeEventListener("focusIn",focusIN);
            mTextfield.removeEventListener("focusOut",focusOUT);
            mTextfield.selectable = false;
         }
      }
   }
}
