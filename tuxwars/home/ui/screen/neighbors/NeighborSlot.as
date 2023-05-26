package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.Message;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   
   public class NeighborSlot implements IResourceLoaderURL
   {
      
      private static const NAME_FIELD:String = "Text_Header";
      
      private static const LEVEL_ICON:String = "Icon_Level";
      
      private static const LEVEL_FIELD:String = "Text_Level";
      
      private static const PICTURE_CONTAINER:String = "Container_Profile_Picture";
       
      
      private var _design:MovieClip;
      
      private var _tuxWarsGame:TuxWarsGame;
      
      private var nameTextField:UIAutoTextField;
      
      private var levelTextField:UIAutoTextField;
      
      private var loader:URLResourceLoader;
      
      private var friend:Friend;
      
      private var _serverMessage:Message;
      
      public function NeighborSlot(design:MovieClip, tuxWars:TuxWarsGame)
      {
         super();
         _design = design;
         _tuxWarsGame = tuxWars;
         nameTextField = new UIAutoTextField(design.getChildByName("Text_Header") as TextField);
         levelTextField = new UIAutoTextField((design.getChildByName("Icon_Level") as MovieClip).getChildByName("Text_Level") as TextField);
         setFriend(null);
      }
      
      public function setFriend(f:Friend) : void
      {
         if(!f)
         {
            return;
         }
         design.visible = true;
         friend = f;
         if(getResourceUrl())
         {
            loader = ResourceLoaderURL.getInstance().load(this,null);
            getTargetMovieClip().visible = true;
         }
         else
         {
            getTargetMovieClip().visible = false;
         }
         nameTextField.setText(friend.name);
         levelTextField.setText(friend.level.toString());
      }
      
      public function getResourceUrl() : String
      {
         return !!friend ? friend.picUrl : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return design.getChildByName("Container_Profile_Picture") as MovieClip;
      }
      
      public function getFriend() : Friend
      {
         return friend;
      }
      
      public function refresh() : void
      {
         if(friend)
         {
            setFriend(friend);
         }
      }
      
      public function set serverMessage(message:Message) : void
      {
         _serverMessage = message;
      }
      
      public function get serverMessage() : Message
      {
         return _serverMessage;
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      public function get tuxWarsGame() : TuxWarsGame
      {
         return _tuxWarsGame;
      }
   }
}
