package tuxwars.home.ui.screen.home
{
   import com.dchoc.friends.Friend;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.text.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.net.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class FriendSlot implements IResourceLoaderURL
   {
      private static const SLOT_DISABLED:String = "Slot_Disabled";
      
      private static const SLOT_DEFAULT:String = "Slot_Default";
      
      private static const NAME_FIELD:String = "Text_Name";
      
      private static const LEVEL_ICON:String = "Icon_Level";
      
      private static const LEVEL_FIELD:String = "Text_Level";
      
      private static const PICTURE_CONTAINER:String = "Container_Profile_Picture";
      
      private var slotDefault:MovieClip;
      
      private var addFriendButton:UIButton;
      
      private var nameTextField:UIAutoTextField;
      
      private var levelTextField:UIAutoTextField;
      
      private var loader:URLResourceLoader;
      
      private var friend:Friend;
      
      private var _design:MovieClip;
      
      public function FriendSlot(param1:MovieClip)
      {
         var _loc2_:TextField = null;
         super();
         this._design = param1;
         this.slotDefault = MovieClip(param1.getChildByName("Slot_Default"));
         this.addFriendButton = TuxUiUtils.createButton(UIButton,param1,"Slot_Disabled",this.addFriendCallback,"BUTTON_ADD","TOOLTIP_ADD_FRIEND");
         this.addFriendButton.addEventListener("out",this.mouseOut,false,0,true);
         this.addFriendButton.addEventListener("over",this.mouseOver,false,0,true);
         this.nameTextField = new UIAutoTextField(this.slotDefault.getChildByName("Text_Name") as TextField);
         var _loc3_:MovieClip = this.slotDefault.getChildByName("Icon_Level") as MovieClip;
         if(_loc3_)
         {
            _loc2_ = _loc3_.getChildByName("Text_Level") as TextField;
            if(_loc2_)
            {
               this.levelTextField = new UIAutoTextField(_loc2_);
            }
         }
         this.setFriend(null);
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      public function setFriend(param1:Friend) : void
      {
         if(param1)
         {
            this.slotDefault.visible = true;
            this.nameTextField.setVisible(true);
            if(this.levelTextField)
            {
               this.levelTextField.setVisible(true);
            }
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
            this.nameTextField.setText(this.friend.firstName);
            if(this.levelTextField)
            {
               this.levelTextField.setText(this.friend.level.toString());
            }
            this.addFriendButton.setEnabled(false);
            this.addFriendButton.setVisible(false);
         }
         else
         {
            this.slotDefault.visible = false;
            this.nameTextField.setVisible(false);
            if(this.levelTextField)
            {
               this.levelTextField.setVisible(false);
            }
            this.addFriendButton.setEnabled(true);
            this.addFriendButton.setVisible(true);
         }
      }
      
      public function getResourceUrl() : String
      {
         return !!this.friend ? this.friend.picUrl : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return this.slotDefault.getChildByName("Container_Profile_Picture") as MovieClip;
      }
      
      private function addFriendCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","CharacterMenu","Clicked","Invite",null,0,null,true);
         NeighborService.sendNeighborRequestSelectFriends("INVITE_NEIGHBOR_TITLE","INVITE_NEIGHBOR_MESSAGE","FriendsBarSlot");
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
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

