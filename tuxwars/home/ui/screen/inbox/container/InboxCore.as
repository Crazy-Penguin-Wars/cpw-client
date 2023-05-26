package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.friends.Friend;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function InboxCore(requestDataObj:RequestData, design:MovieClip, titleTID:String, descriptionTID:String, titleTIDParams:Array = null, descriptionTIDParams:Array = null, parent:UIComponent = null)
      {
         super(design,parent);
         _requestData = requestDataObj;
         _title = TuxUiUtils.createAutoTextField(design.getChildByName("Text_Header") as TextField,titleTID,titleTIDParams);
         _description = TuxUiUtils.createAutoTextField(design.getChildByName("Text_Description") as TextField,descriptionTID,descriptionTIDParams);
      }
      
      public function setFriend(friend:Friend, playerId:String) : void
      {
         this.friend = friend;
         this.playerId = playerId;
         if(friend)
         {
            if(getResourceUrl())
            {
               loader = ResourceLoaderURL.getInstance().load(this,null);
               getTargetMovieClip().visible = true;
            }
            else
            {
               getTargetMovieClip().visible = false;
            }
         }
      }
      
      public function set title(title:String) : void
      {
         _title.setText(title);
      }
      
      public function set description(description:String) : void
      {
         _description.setText(description);
      }
      
      public function get requestData() : RequestData
      {
         return _requestData;
      }
      
      public function getResourceUrl() : String
      {
         return !!friend ? friend.picUrl : null;
      }
      
      public function getFriend() : Friend
      {
         return friend;
      }
      
      public function getPlayerID() : String
      {
         return playerId;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return this._design.getChildByName("Container_Profile_Picture") as MovieClip;
      }
   }
}
