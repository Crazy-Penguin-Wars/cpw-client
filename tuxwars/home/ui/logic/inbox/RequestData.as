package tuxwars.home.ui.logic.inbox
{
   import org.as3commons.lang.StringUtils;
   
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
      
      public function RequestData(type:String, data:Object)
      {
         super();
         _type = type;
         _data = data;
         _state = "New";
         if(_data != null)
         {
            if(_type == "Gifts_Default")
            {
               _giftID = data.gift_id;
            }
            _senderID = data.sender_dcg_id;
            _requestPlatfrm = data.request_platform;
            _requestID = data.request_id;
         }
      }
      
      public function get feedRewardGift() : Boolean
      {
         return StringUtils.startsWith(_requestID,"reward_");
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get giftID() : String
      {
         return _giftID;
      }
      
      public function get senderID() : String
      {
         return _senderID;
      }
      
      public function get requestPlatfrm() : String
      {
         return _requestPlatfrm;
      }
      
      public function get requestID() : String
      {
         return _requestID;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function set state(value:String) : void
      {
         _state = value;
      }
   }
}
