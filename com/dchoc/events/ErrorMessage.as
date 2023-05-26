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
      
      public function ErrorMessage(code:String, product:String, desc:String, productDetail:String = null, error:Error = null, popupDataID:String = null)
      {
         super("ErrorMessage");
         _code = code;
         _desc = desc;
         _product = product;
         _error = error;
         _productDetail = productDetail;
         _popupDataID = popupDataID;
         if(_desc == null)
         {
            _desc = "";
         }
      }
      
      public function get code() : String
      {
         return _code;
      }
      
      public function get description() : String
      {
         return _desc;
      }
      
      public function get error() : Error
      {
         return _error;
      }
      
      public function get product() : String
      {
         return _product;
      }
      
      public function get popupDataID() : String
      {
         return _popupDataID;
      }
      
      public function get productDetail() : String
      {
         return _productDetail;
      }
   }
}
