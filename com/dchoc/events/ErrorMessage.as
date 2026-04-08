package com.dchoc.events
{
   import com.dchoc.messages.Message;
   
   public class ErrorMessage extends Message
   {
      private var _code:String;
      
      private var _desc:String;
      
      private var _product:String;
      
      private var _error:Error;
      
      private var _productDetail:String;
      
      private var _popupDataID:String;
      
      public function ErrorMessage(param1:String, param2:String, param3:String, param4:String = null, param5:Error = null, param6:String = null)
      {
         super("ErrorMessage");
         this._code = param1;
         this._desc = param3;
         this._product = param2;
         this._error = param5;
         this._productDetail = param4;
         this._popupDataID = param6;
         if(this._desc == null)
         {
            this._desc = "";
         }
      }
      
      public function get code() : String
      {
         return this._code;
      }
      
      public function get description() : String
      {
         return this._desc;
      }
      
      public function get error() : Error
      {
         return this._error;
      }
      
      public function get product() : String
      {
         return this._product;
      }
      
      public function get popupDataID() : String
      {
         return this._popupDataID;
      }
      
      public function get productDetail() : String
      {
         return this._productDetail;
      }
   }
}

