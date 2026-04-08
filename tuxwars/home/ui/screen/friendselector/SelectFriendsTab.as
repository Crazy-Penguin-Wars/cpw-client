package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import com.dchoc.ui.groups.*;
   import com.dchoc.ui.text.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.utils.*;
   
   public class SelectFriendsTab extends UIComponent
   {
      private static const HEADER_TEXTFIELD:String = "Header";
      
      private static const DESCRIPTION_TEXTFIELD:String = "Text_Description";
      
      private static const ITEM_DESCRIPTION_TEXT:String = "Text_Message";
      
      private static const FRIEND_SELECTOR_ASSET_NAME:String = "Friend_List";
      
      private static const ICON_PLACEHOLDER:String = "Container_Icon";
      
      private static const BUTTON_ASSET:String = "Button_Ok";
      
      public static const CUSTOM_FRIENDS_SELECTOR_MAX_OUTPUT:int = 50;
      
      public static const TABS_CONTAINER:String = "Container_Subtabs";
      
      public static const BUTTON_PREFIX:String = "Tab_0";
      
      public static const DELIMITER:String = ",";
      
      public var mHeader:UIAutoTextField;
      
      public var mDescription:UIAutoTextField;
      
      public var mItemDescription:UIAutoTextField;
      
      public var mIconHolder:MovieClip;
      
      public var mSelector:FriendsSelectorComponent;
      
      public var mDefaultButtonText:String = "";
      
      public var mButton:UIButton;
      
      public var mButtonList:Array = [];
      
      public var mFilters:Array = [];
      
      private var mSelectorData:MultipleFriendSelectorData;
      
      public var mCallback:Function = null;
      
      public var mActiveTab:String = "";
      
      private var mGiftingInfo:GiftingInfo;
      
      public function SelectFriendsTab(param1:DisplayObject, param2:GiftingInfo)
      {
         super(param1);
         var _loc3_:MovieClip = getDesignMovieClip();
         this.mGiftingInfo = param2;
         _loc3_.visible = false;
         this.mHeader = new UIAutoTextField(TextField(_loc3_.getChildByName("Header")));
         this.mDescription = new UIAutoTextField(TextField(_loc3_.getChildByName("Text_Description")));
         this.mItemDescription = new UIAutoTextField(TextField(_loc3_.getChildByName("Text_Message")));
         this.mIconHolder = MovieClip(_loc3_.getChildByName("Container_Icon"));
         if(this.mIconHolder)
         {
            this.mIconHolder.visible = false;
         }
         this.mButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Ok",this.buttonClickHandler);
         this.mButton.setEnabled(false);
         this.mSelector = new FriendsSelectorComponent(_loc3_.getChildByName("Friend_List"));
         this.mSelector.addEventListener("ChangeEvent",this.listChangeHandler,false,0,true);
      }
      
      public static function handleFriendsList(param1:Vector.<Object>) : String
      {
         var _loc6_:* = undefined;
         var _loc2_:Array = [];
         var _loc3_:String = "";
         var _loc4_:uint = 50;
         var _loc5_:uint = 1;
         for each(_loc6_ in param1)
         {
            if(_loc5_ > _loc4_)
            {
               break;
            }
            _loc2_.unshift(MultipleFriendSelectorFriend(_loc6_).id);
            _loc5_++;
         }
         return _loc2_.join(",");
      }
      
      public function get selectedList() : Vector.<Object>
      {
         return this.mSelector.selectedList.dataList;
      }
      
      public function buttonClickHandler(param1:MouseEvent) : void
      {
         if(this.mSelector.selectedList.dataList.length > 0)
         {
            this.mCallback(this.mSelector.selectedList.dataList);
            if(Boolean(this.mSelector) && this.mSelector.selectedList.dataList.length > 50)
            {
               this.mSelector.deleteSent(50,this.mFilters);
            }
         }
      }
      
      public function parseFilters(param1:Array) : Array
      {
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc2_:UIToggleButton = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:Array = null;
         var _loc7_:* = undefined;
         var _loc8_:Object = null;
         var _loc9_:MultipleFriendSelectorFriend = null;
         var _loc10_:UIRadialGroup = new UIRadialGroup();
         var _loc11_:MovieClip = getDesignMovieClip().getChildByName("Container_Subtabs") as MovieClip;
         _loc4_ = 1;
         while(_loc4_ <= 3)
         {
            _loc3_ = "Tab_0" + _loc4_;
            if(_loc11_.getChildByName(_loc3_))
            {
               _loc2_ = TuxUiUtils.createButton(UIToggleButton,_loc11_,_loc3_);
               if(_loc2_ != null)
               {
                  _loc2_.setVisible(false);
                  this.mButtonList[_loc3_] = _loc2_;
               }
            }
            _loc4_++;
         }
         if(param1.length > 1)
         {
            _loc10_.addEventListener("selection_changed",this.switchTabHandler);
         }
         var _loc12_:Array = [];
         if(param1 != null)
         {
            if(param1.length > 0)
            {
               _loc5_ = 1;
               for each(_loc13_ in param1)
               {
                  _loc3_ = "Tab_0" + _loc5_;
                  _loc6_ = String(param1[_loc5_ - 1].user_ids).split(",");
                  _loc7_ = new Vector.<Object>();
                  if(param1.length > 0)
                  {
                     if(this.mButtonList[_loc3_] != null)
                     {
                        UIToggleButton(this.mButtonList[_loc3_]).setText(_loc13_.name);
                        UIToggleButton(this.mButtonList[_loc3_]).setVisible(true);
                        _loc10_.add(UIToggleButton(this.mButtonList[_loc3_]));
                     }
                  }
                  for each(_loc14_ in _loc6_)
                  {
                     _loc8_ = this.mGiftingInfo.getFriendInfoByPlatformUserId(_loc14_);
                     if(_loc8_ != null)
                     {
                        _loc9_ = new MultipleFriendSelectorFriend(_loc8_.firstName,_loc8_.lastName,_loc14_);
                        _loc7_.push(_loc9_);
                     }
                  }
                  _loc12_[_loc3_] = _loc7_;
                  _loc5_++;
               }
            }
         }
         return _loc12_;
      }
      
      public function setSelectorData(param1:MultipleFriendSelectorData) : void
      {
         this.mSelectorData = param1;
         this.mHeader.setText(this.checkText(this.mSelectorData.getHeader()));
         this.mDescription.setText(this.checkText(this.mSelectorData.getDescription()));
         this.mItemDescription.setText(this.checkText(this.mSelectorData.getImageDescription()));
         this.mDefaultButtonText = ProjectManager.getText("FS_NO_SELECTION");
         this.mButton.setText(this.mDefaultButtonText);
      }
      
      private function listChangeHandler(param1:Event) : void
      {
         if(this.mSelector.selectedList.currentLength <= 0)
         {
            if(this.mButton)
            {
               this.mButton.setEnabled(false);
               this.mButton.setText(this.mDefaultButtonText);
            }
         }
         else if(this.mButton)
         {
            this.mButton.setEnabled(true);
            this.mButton.setText(this.checkText(this.mSelectorData.getButtonText()));
         }
      }
      
      private function checkText(param1:String) : String
      {
         if(param1 == null || param1 == "")
         {
            return "";
         }
         return param1;
      }
      
      public function activateByTabName(param1:String) : void
      {
         this.mActiveTab = param1;
         this.mSelector.setData(this.mFilters[this.mActiveTab]);
      }
      
      public function switchTabHandler(param1:UIRadialGroupEvent) : void
      {
         var _loc2_:* = UIToggleButton(param1.getParameter());
         var _loc3_:MovieClip = _loc2_._design;
         if(this.mActiveTab == _loc3_.name)
         {
            return;
         }
         this.activateByTabName(_loc3_.name);
      }
      
      public function clean() : void
      {
         this.mSelector.removeEventListener("selection_changed",this.switchTabHandler);
         this.mSelectorData = null;
         this.mCallback = null;
         this.mFilters = [];
         this.mSelector.clean();
         this.mSelector = null;
      }
   }
}

