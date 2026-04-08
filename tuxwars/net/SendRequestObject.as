package tuxwars.net
{
   import com.dchoc.projectdata.*;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.home.ui.screen.friendselector.MultipleFriendSelectorData;
   
   public class SendRequestObject
   {
      public var _fromWhereInClient:String;
      
      public var _message:String;
      
      public var _title:String = null;
      
      public var _type:String;
      
      public var _callback:Function = null;
      
      public var _giftReference:GiftReference = null;
      
      public var _selectorData:MultipleFriendSelectorData = null;
      
      public function SendRequestObject(param1:String, param2:Function, param3:String, param4:String, param5:String, param6:Array = null, param7:Array = null)
      {
         super();
         this._title = ProjectManager.getText(param3,param6);
         this._message = ProjectManager.getText(param4,param7);
         this._fromWhereInClient = param5;
         this._type = param1;
         this._callback = param2;
      }
      
      public function get giftReference() : GiftReference
      {
         return this._giftReference;
      }
      
      public function set giftReference(param1:GiftReference) : void
      {
         this._giftReference = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get callback() : Function
      {
         return this._callback;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function get fromWhereInClient() : String
      {
         return this._fromWhereInClient;
      }
   }
}

