package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import com.dchoc.ui.groups.UIRadialGroup;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public var mButtonList:Array;
      
      public var mFilters:Array;
      
      private var mSelectorData:MultipleFriendSelectorData;
      
      public var mCallback:Function = null;
      
      public var mActiveTab:String = "";
      
      private var mGiftingInfo:GiftingInfo;
      
      public function SelectFriendsTab(newDesign:DisplayObject, giftingInfo:GiftingInfo)
      {
         mButtonList = [];
         mFilters = [];
         super(newDesign);
         var _loc3_:MovieClip = getDesignMovieClip();
         mGiftingInfo = giftingInfo;
         _loc3_.visible = false;
         mHeader = new UIAutoTextField(TextField(_loc3_.getChildByName("Header")));
         mDescription = new UIAutoTextField(TextField(_loc3_.getChildByName("Text_Description")));
         mItemDescription = new UIAutoTextField(TextField(_loc3_.getChildByName("Text_Message")));
         mIconHolder = MovieClip(_loc3_.getChildByName("Container_Icon"));
         if(mIconHolder)
         {
            mIconHolder.visible = false;
         }
         mButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Ok",buttonClickHandler);
         mButton.setEnabled(false);
         mSelector = new FriendsSelectorComponent(_loc3_.getChildByName("Friend_List"));
         mSelector.addEventListener("ChangeEvent",listChangeHandler,false,0,true);
      }
      
      public static function handleFriendsList(list:Vector.<Object>) : String
      {
         var returnArray:Array = [];
         var returnString:String = "";
         var i:uint = 1;
         for each(var obj in list)
         {
            if(i > 50)
            {
               break;
            }
            returnArray.unshift(MultipleFriendSelectorFriend(obj).id);
            i++;
         }
         return returnArray.join(",");
      }
      
      public function get selectedList() : Vector.<Object>
      {
         return mSelector.selectedList.dataList;
      }
      
      public function buttonClickHandler(event:MouseEvent) : void
      {
         if(mSelector.selectedList.dataList.length > 0)
         {
            mCallback(mSelector.selectedList.dataList);
            if(mSelector && mSelector.selectedList.dataList.length > 50)
            {
               mSelector.deleteSent(50,mFilters);
            }
         }
      }
      
      public function parseFilters(filter:Array) : Array
      {
         var mTabButton:* = null;
         var tabName:* = null;
         var x:int = 0;
         var i:* = 0;
         var parseArray:* = null;
         var friendsDataList:* = undefined;
         var friendsInfo:* = null;
         var friend:* = null;
         var mTabRadialGroup:UIRadialGroup = new UIRadialGroup();
         var tabsContainerClip:MovieClip = getDesignMovieClip().getChildByName("Container_Subtabs") as MovieClip;
         for(x = 1; x <= 3; )
         {
            tabName = "Tab_0" + x;
            if(tabsContainerClip.getChildByName(tabName))
            {
               mTabButton = TuxUiUtils.createButton(UIToggleButton,tabsContainerClip,tabName);
               if(mTabButton != null)
               {
                  mTabButton.setVisible(false);
                  mButtonList[tabName] = mTabButton;
               }
            }
            x++;
         }
         if(filter.length > 1)
         {
            mTabRadialGroup.addEventListener("selection_changed",switchTabHandler);
         }
         var returnFilter:Array = [];
         if(filter != null)
         {
            if(filter.length > 0)
            {
               i = 1;
               for each(var obj in filter)
               {
                  tabName = "Tab_0" + i;
                  parseArray = String(filter[i - 1].user_ids).split(",");
                  friendsDataList = new Vector.<Object>();
                  if(filter.length > 0)
                  {
                     if(mButtonList[tabName] != null)
                     {
                        UIToggleButton(mButtonList[tabName]).setText(obj.name);
                        UIToggleButton(mButtonList[tabName]).setVisible(true);
                        mTabRadialGroup.add(UIToggleButton(mButtonList[tabName]));
                     }
                  }
                  for each(var id in parseArray)
                  {
                     friendsInfo = mGiftingInfo.getFriendInfoByPlatformUserId(id);
                     if(friendsInfo != null)
                     {
                        friend = new MultipleFriendSelectorFriend(friendsInfo.firstName,friendsInfo.lastName,id);
                        friendsDataList.push(friend);
                     }
                  }
                  returnFilter[tabName] = friendsDataList;
                  i++;
               }
            }
         }
         return returnFilter;
      }
      
      public function setSelectorData(selectorData:MultipleFriendSelectorData) : void
      {
         mSelectorData = selectorData;
         mHeader.setText(checkText(mSelectorData.getHeader()));
         mDescription.setText(checkText(mSelectorData.getDescription()));
         mItemDescription.setText(checkText(mSelectorData.getImageDescription()));
         mDefaultButtonText = ProjectManager.getText("FS_NO_SELECTION");
         mButton.setText(mDefaultButtonText);
      }
      
      private function listChangeHandler(event:Event) : void
      {
         if(mSelector.selectedList.currentLength <= 0)
         {
            if(mButton)
            {
               mButton.setEnabled(false);
               mButton.setText(mDefaultButtonText);
            }
         }
         else if(mButton)
         {
            mButton.setEnabled(true);
            mButton.setText(checkText(mSelectorData.getButtonText()));
         }
      }
      
      private function checkText(value:String) : String
      {
         if(value == null || value == "")
         {
            return "";
         }
         return value;
      }
      
      public function activateByTabName(name:String) : void
      {
         mActiveTab = name;
         mSelector.setData(mFilters[mActiveTab]);
      }
      
      public function switchTabHandler(event:UIRadialGroupEvent) : void
      {
         var _loc3_:* = UIToggleButton(event.getParameter());
         var tabClip:MovieClip = _loc3_._design;
         if(mActiveTab == tabClip.name)
         {
            return;
         }
         activateByTabName(tabClip.name);
      }
      
      public function clean() : void
      {
         mSelector.removeEventListener("selection_changed",switchTabHandler);
         mSelectorData = null;
         mCallback = null;
         mFilters = [];
         mSelector.clean();
         mSelector = null;
      }
   }
}
