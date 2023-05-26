package tuxwars.home.ui.screen.home
{
   import com.dchoc.friends.Friend;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.net.CRMService;
   import tuxwars.net.NeighborService;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function FriendSlot(design:MovieClip)
      {
         var _loc2_:* = null;
         super();
         _design = design;
         slotDefault = MovieClip(design.getChildByName("Slot_Default"));
         addFriendButton = TuxUiUtils.createButton(UIButton,design,"Slot_Disabled",addFriendCallback,"BUTTON_ADD","TOOLTIP_ADD_FRIEND");
         addFriendButton.addEventListener("out",mouseOut,false,0,true);
         addFriendButton.addEventListener("over",mouseOver,false,0,true);
         nameTextField = new UIAutoTextField(slotDefault.getChildByName("Text_Name") as TextField);
         var _loc3_:MovieClip = slotDefault.getChildByName("Icon_Level") as MovieClip;
         if(_loc3_)
         {
            _loc2_ = _loc3_.getChildByName("Text_Level") as TextField;
            if(_loc2_)
            {
               levelTextField = new UIAutoTextField(_loc2_);
            }
         }
         setFriend(null);
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      public function setFriend(f:Friend) : void
      {
         if(f)
         {
            slotDefault.visible = true;
            nameTextField.setVisible(true);
            if(levelTextField)
            {
               levelTextField.setVisible(true);
            }
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
            nameTextField.setText(friend.firstName);
            if(levelTextField)
            {
               levelTextField.setText(friend.level.toString());
            }
            addFriendButton.setEnabled(false);
            addFriendButton.setVisible(false);
         }
         else
         {
            slotDefault.visible = false;
            nameTextField.setVisible(false);
            if(levelTextField)
            {
               levelTextField.setVisible(false);
            }
            addFriendButton.setEnabled(true);
            addFriendButton.setVisible(true);
         }
      }
      
      public function getResourceUrl() : String
      {
         return !!friend ? friend.picUrl : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return slotDefault.getChildByName("Container_Profile_Picture") as MovieClip;
      }
      
      private function addFriendCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","CharacterMenu","Clicked","Invite",null,0,null,true);
         NeighborService.sendNeighborRequestSelectFriends("INVITE_NEIGHBOR_TITLE","INVITE_NEIGHBOR_MESSAGE","FriendsBarSlot");
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
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
