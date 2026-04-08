package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.friends.Friend;
   import com.dchoc.resources.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.utils.*;
   
   public class InboxCore extends UIContainer implements IResourceLoaderURL
   {
      private static const PICTURE_CONTAINER:String = "Container_Profile_Picture";
      
      private var data:RequestData;
      
      private var _title:UIAutoTextField;
      
      private var _description:UIAutoTextField;
      
      private var _requestData:RequestData;
      
      private var friend:Friend;
      
      private var loader:URLResourceLoader;
      
      private var playerId:String;
      
      public function InboxCore(param1:RequestData, param2:MovieClip, param3:String, param4:String, param5:Array = null, param6:Array = null, param7:UIComponent = null)
      {
         super(param2,param7);
         this._requestData = param1;
         this._title = TuxUiUtils.createAutoTextField(param2.getChildByName("Text_Header") as TextField,param3,param5);
         this._description = TuxUiUtils.createAutoTextField(param2.getChildByName("Text_Description") as TextField,param4,param6);
      }
      
      public function setFriend(param1:Friend, param2:String) : void
      {
         this.friend = param1;
         this.playerId = param2;
         if(param1)
         {
            if(this.getResourceUrl())
            {
               this.loader = ResourceLoaderURL.getInstance().load(this,null);
               this.getTargetMovieClip().visible = true;
            }
            else
            {
               this.getTargetMovieClip().visible = false;
            }
         }
      }
      
      public function set title(param1:String) : void
      {
         this._title.setText(param1);
      }
      
      public function set description(param1:String) : void
      {
         this._description.setText(param1);
      }
      
      public function get requestData() : RequestData
      {
         return this._requestData;
      }
      
      public function getResourceUrl() : String
      {
         return !!this.friend ? this.friend.picUrl : null;
      }
      
      public function getFriend() : Friend
      {
         return this.friend;
      }
      
      public function getPlayerID() : String
      {
         return this.playerId;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return this._design.getChildByName("Container_Profile_Picture") as MovieClip;
      }
   }
}

