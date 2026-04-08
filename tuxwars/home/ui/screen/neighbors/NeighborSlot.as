package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.Message;
   import com.dchoc.resources.*;
   import com.dchoc.ui.text.*;
   import flash.display.*;
   import flash.text.*;
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
      
      public function NeighborSlot(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         this._design = param1;
         this._tuxWarsGame = param2;
         this.nameTextField = new UIAutoTextField(param1.getChildByName("Text_Header") as TextField);
         this.levelTextField = new UIAutoTextField((param1.getChildByName("Icon_Level") as MovieClip).getChildByName("Text_Level") as TextField);
         this.setFriend(null);
      }
      
      public function setFriend(param1:Friend) : void
      {
         if(!param1)
         {
            return;
         }
         this.design.visible = true;
         this.friend = param1;
         if(this.getResourceUrl())
         {
            this.loader = ResourceLoaderURL.getInstance().load(this,null);
            this.getTargetMovieClip().visible = true;
         }
         else
         {
            this.getTargetMovieClip().visible = false;
         }
         this.nameTextField.setText(this.friend.name);
         this.levelTextField.setText(this.friend.level.toString());
      }
      
      public function getResourceUrl() : String
      {
         return !!this.friend ? this.friend.picUrl : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return this.design.getChildByName("Container_Profile_Picture") as MovieClip;
      }
      
      public function getFriend() : Friend
      {
         return this.friend;
      }
      
      public function refresh() : void
      {
         if(this.friend)
         {
            this.setFriend(this.friend);
         }
      }
      
      public function set serverMessage(param1:Message) : void
      {
         this._serverMessage = param1;
      }
      
      public function get serverMessage() : Message
      {
         return this._serverMessage;
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      public function get tuxWarsGame() : TuxWarsGame
      {
         return this._tuxWarsGame;
      }
   }
}

