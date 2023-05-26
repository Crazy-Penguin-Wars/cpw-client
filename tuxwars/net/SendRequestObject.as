package tuxwars.net
{
   import com.dchoc.projectdata.ProjectManager;
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
      
      public function SendRequestObject(type:String, callback:Function, titleTID:String, messageTID:String, fromWhereInClient:String, titleTIDParam:Array = null, messageTIDParam:Array = null)
      {
         super();
         this._title = ProjectManager.getText(titleTID,titleTIDParam);
         this._message = ProjectManager.getText(messageTID,messageTIDParam);
         this._fromWhereInClient = fromWhereInClient;
         this._type = type;
         this._callback = callback;
      }
      
      public function get giftReference() : GiftReference
      {
         return _giftReference;
      }
      
      public function set giftReference(gift:GiftReference) : void
      {
         _giftReference = gift;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get fromWhereInClient() : String
      {
         return _fromWhereInClient;
      }
   }
}
