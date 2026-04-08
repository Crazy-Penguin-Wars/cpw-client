package tuxwars.home.ui.logic.inbox
{
   import org.as3commons.lang.*;
   
   public class RequestData
   {
      public static const STATE_NEW:String = "New";
      
      public static const STATE_ACCEPTED:String = "Accepted";
      
      public static const STATE_DONE:String = "Done";
      
      public static const STATE_HIDE_MANUALLY:String = "HideManually";
      
      public static const REWARD_PREFIX:String = "reward_";
      
      private var _type:String;
      
      private var _data:Object;
      
      private var _giftID:String;
      
      private var _senderID:String;
      
      private var _requestPlatfrm:String;
      
      private var _requestID:String;
      
      private var _state:String;
      
      public function RequestData(param1:String, param2:Object)
      {
         super();
         this._type = param1;
         this._data = param2;
         this._state = "New";
         if(this._data != null)
         {
            if(this._type == "Gifts_Default")
            {
               this._giftID = param2.gift_id;
            }
            this._senderID = param2.sender_dcg_id;
            this._requestPlatfrm = param2.request_platform;
            this._requestID = param2.request_id;
         }
      }
      
      public function get feedRewardGift() : Boolean
      {
         return StringUtils.startsWith(this._requestID,"reward_");
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function get giftID() : String
      {
         return this._giftID;
      }
      
      public function get senderID() : String
      {
         return this._senderID;
      }
      
      public function get requestPlatfrm() : String
      {
         return this._requestPlatfrm;
      }
      
      public function get requestID() : String
      {
         return this._requestID;
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         this._state = param1;
      }
   }
}

