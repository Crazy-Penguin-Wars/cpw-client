package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.scroll.ScrollBar;
   import com.dchoc.ui.text.InputTextField;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.utils.TuxUiUtils;
   
   public class FriendsSelectorComponent extends FriendsSelectorBase
   {
      
      public static const CHANGE_EVENT:String = "ChangeEvent";
      
      private static const SEARCH_DEFAULT_TID:String = "FS_SEARCH_DEFAULT";
      
      private static const SELECT_ALL_TID:String = "FS_SELECT_ALL";
      
      private static const NO_SELECTED_TID:String = "FS_NO_SELECTION";
      
      private static const SEARCH_TEXTFIELD:String = "Text_Search";
      
      private static const CELL_TEXTFIELD:String = "search";
      
      private static const SCROLL_BAR:String = "Scroll_Bar";
      
      private static const BUTTON_SCROLL:String = "Button_Scroll";
      
      private static const HITAREA:String = "hitarea";
      
      private static const BUTTON_UP:String = "Button_Up";
      
      private static const BUTTON_DOWN:String = "Button_Down";
      
      private static const SELECT_ALL:String = "Select_All";
      
      private static const SELECTED_FRIENDS:String = "Friend_List_Selected";
      
      private static const FRIENDS_CONTAINER_CLIP_NAME:String = "Container_Slots";
      
      private static const NOBODY_SELECTED_CONTAINER:String = "Container_Nobody";
      
      private static const NOBODY_SELECTED_TEXT:String = "Text";
      
      private static const FRIENDS_PANEL_PREFIX:String = "Slot_";
      
      private static const SELECTED_FRIENDS_PANEL_PREFIX:String = "Slot_";
       
      
      private var mEmptyTextfield:UIAutoTextField;
      
      private var mSearchBar:InputTextField;
      
      private var mFriendsList:MultipleFriendSelectorFriendsCollection;
      
      private var mScrollBarFriends:ScrollBar;
      
      private var mScrollBarSelected:ScrollBar;
      
      private var mSelectAllButton:UIToggleButton;
      
      private var mScrollBarDesign:MovieClip;
      
      private var mScrollBarSelectedDesign:MovieClip;
      
      private var mSelectedFriendsList:CellList;
      
      private var mPanelCount:int = 6;
      
      private var mSelectedPanelCount:int = 3;
      
      public function FriendsSelectorComponent(newDesign:DisplayObject)
      {
         if(newDesign != null)
         {
            super(newDesign);
            initSearch();
            initFriendsList();
            initSelectedList();
            initSelectAll();
            initScrollBar();
            initDescTexts();
         }
      }
      
      public function setData(friendsList:Vector.<Object>) : void
      {
         mFriendsList.cancelSearch();
         mFriendsList.setDataList = friendsList;
         mFriendsList.listIndex = 0;
         mFriendsList.sortByFirstName();
         if(mSearchBar)
         {
            mSearchBar.activate();
         }
         mFriendsList.updateFromIndex(mFriendsList.listIndex,mSelectedFriendsList.dataList);
         updateButtonsAndSliders();
      }
      
      public function get selectedList() : CellList
      {
         return mSelectedFriendsList;
      }
      
      public function clean() : void
      {
         var panel:* = null;
         if(mSearchBar)
         {
            mSearchBar.clean();
         }
         mScrollBarFriends.clean();
         mScrollBarFriends = null;
         mScrollBarSelected.clean();
         mScrollBarFriends = null;
         for each(panel in mSelectedFriendsList.panelList)
         {
            panel.removeEventListener("ClickEvent",selectedPanelClickHandler);
         }
         mSelectedFriendsList.clean();
         for each(panel in mFriendsList.panelList)
         {
            panel.removeEventListener("ClickEvent",friendsPanelClickHandler);
         }
         mFriendsList.clean();
         panel = null;
      }
      
      private function initScrollBar() : void
      {
         var _loc2_:MovieClip = getDesignMovieClip().getChildByName("Container_Slots") as MovieClip;
         var parentMovie:* = _loc2_;
         mScrollBarDesign = parentMovie.getChildByName("Scroll_Bar") as MovieClip;
         var hitArea:MovieClip = mScrollBarDesign.getChildByName("hitarea") as MovieClip;
         var scrollBar:UIButton = TuxUiUtils.createButton(UIButton,mScrollBarDesign,"Button_Scroll");
         mScrollBarFriends = createScrollBar(scrollBar,hitArea,scrollBarFriendsMove);
         mScrollBarFriends.setUpButton(_loc2_,"Button_Up",upFriendsClickHandler);
         mScrollBarFriends.setDownButton(_loc2_,"Button_Down",downFriendsClickHandler);
         parentMovie = getDesignMovieClip().getChildByName("Friend_List_Selected") as MovieClip;
         mScrollBarSelectedDesign = parentMovie.getChildByName("Scroll_Bar") as MovieClip;
         hitArea = mScrollBarSelectedDesign.getChildByName("hitarea") as MovieClip;
         scrollBar = TuxUiUtils.createButton(UIButton,mScrollBarSelectedDesign,"Button_Scroll");
         mScrollBarSelectedDesign.visible = false;
         mScrollBarSelected = createScrollBar(scrollBar,hitArea,scrollBarSelectedMove);
         mScrollBarSelected.setUpButton(parentMovie,"Button_Up",upSelectedClickHandler);
         mScrollBarSelected.setDownButton(parentMovie,"Button_Down",downSelectedClickHandler);
      }
      
      private function upFriendsClickHandler(event:MouseEvent) : void
      {
         if(mFriendsList.dataList.length > 0)
         {
            mFriendsList.listIndex--;
            mFriendsList.updateFromIndex(mFriendsList.listIndex,mSelectedFriendsList.dataList);
            updateButtonsAndSliders();
         }
      }
      
      private function downFriendsClickHandler(event:MouseEvent) : void
      {
         if(mFriendsList.dataList.length > 0)
         {
            mFriendsList.listIndex++;
            mFriendsList.updateFromIndex(mFriendsList.listIndex,mSelectedFriendsList.dataList);
            updateButtonsAndSliders();
         }
      }
      
      private function upSelectedClickHandler(event:MouseEvent) : void
      {
         if(mSelectedFriendsList.dataList.length > 0)
         {
            mSelectedFriendsList.listIndex--;
            mSelectedFriendsList.updateFromIndex(mSelectedFriendsList.listIndex);
            updateButtonsAndSliders();
         }
      }
      
      private function downSelectedClickHandler(event:MouseEvent) : void
      {
         if(mSelectedFriendsList.dataList.length > 0)
         {
            mSelectedFriendsList.listIndex++;
            mSelectedFriendsList.updateFromIndex(mSelectedFriendsList.listIndex);
            updateButtonsAndSliders();
         }
      }
      
      private function initSearch() : void
      {
         var textfieldAsset:TextField = getDesignMovieClip().getChildByName("Text_Search") as TextField;
         if(textfieldAsset)
         {
            mSearchBar = new InputTextField(textfieldAsset,ProjectManager.getText("FS_SEARCH_DEFAULT"));
            mSearchBar.keyboardChangeCallback = doSearch;
         }
      }
      
      private function initDescTexts() : void
      {
         var container:MovieClip = getDesignMovieClip().getChildByName("Container_Nobody") as MovieClip;
         var t:TextField = container.getChildByName("Text") as TextField;
         mEmptyTextfield = new UIAutoTextField(t);
         mEmptyTextfield.setText(ProjectManager.getText("FS_NO_SELECTION"));
         mEmptyTextfield.setVisible(false);
      }
      
      private function initFriendsList() : void
      {
         var i:int = 0;
         var panelName:* = null;
         var panel:* = null;
         var _loc3_:MovieClip = getDesignMovieClip().getChildByName("Container_Slots") as MovieClip;
         mFriendsList = new MultipleFriendSelectorFriendsCollection();
         for(i = 1; i <= mPanelCount; )
         {
            panelName = "Slot_0" + i;
            if(_loc3_)
            {
               panel = new FriendsSelectPanel(_loc3_,panelName);
               panel.addEventListener("ClickEvent",friendsPanelClickHandler,false,0,true);
               mFriendsList.addPanel(panel);
            }
            else
            {
               LogUtils.log("Could not find asset: " + panelName);
            }
            i++;
         }
      }
      
      private function initSelectedList() : void
      {
         var i:int = 0;
         var panelName:* = null;
         var movieAsset:* = null;
         var panel:* = null;
         var _loc4_:MovieClip = getDesignMovieClip();
         mSelectedFriendsList = new MultipleFriendSelectorFriendsCollection();
         for(i = 1; i <= mSelectedPanelCount; )
         {
            panelName = "Slot_0" + i;
            movieAsset = MovieClip(_loc4_.getChildByName("Friend_List_Selected"));
            if(movieAsset)
            {
               panel = new FriendsSelectPanel(movieAsset,panelName);
               panel.addEventListener("ClickEvent",selectedPanelClickHandler,false,0,true);
               mSelectedFriendsList.addPanel(panel);
            }
            i++;
         }
      }
      
      private function initSelectAll() : void
      {
         mSelectAllButton = TuxUiUtils.createButton(UIToggleButton,getDesignMovieClip(),"Select_All",selectAllHandler);
         mSelectAllButton.setText(ProjectManager.getText("FS_SELECT_ALL"));
      }
      
      private function selectAllHandler(event:MouseEvent) : void
      {
         mFriendsList.cancelSearch();
         if(!mSelectAllButton.getSelected())
         {
            if(mSearchBar)
            {
               mSearchBar.activate();
            }
            mSelectedFriendsList.empty();
         }
         else
         {
            if(mSearchBar)
            {
               mSearchBar.deactivate();
            }
            mSelectedFriendsList.dataList = mFriendsList.dataList.concat();
         }
         mSelectedFriendsList.updateFromIndex(0);
         mFriendsList.updateFromIndex(0,mSelectedFriendsList.dataList);
         updateButtonsAndSliders(true,true,false);
         dispatchEvent(new Event("ChangeEvent"));
      }
      
      private function scrollBarFriendsMove(percentage:uint) : void
      {
         scrollBarMoveHandler(percentage,mFriendsList,mSelectedFriendsList);
         updateButtonsAndSliders(false,true,false);
      }
      
      private function scrollBarSelectedMove(percentage:uint) : void
      {
         scrollBarMoveHandler(percentage,mSelectedFriendsList);
      }
      
      private function updateScrollBarSlider(index:uint) : void
      {
         if(mFriendsList.currentLength <= mPanelCount)
         {
            mScrollBarFriends.enabled = false;
         }
         else
         {
            mScrollBarFriends.enabled = true;
         }
         var length:uint = mFriendsList.currentLength - mPanelCount;
         var percentage:uint = index / length * 100;
         mScrollBarFriends.setProcentage(percentage);
      }
      
      private function friendsPanelClickHandler(event:Event) : void
      {
         var obj:Object = getFromListWithId(FriendsSelectPanel(event.target).id,mFriendsList.dataList);
         ifNotExistWithIdUnshift(obj,mSelectedFriendsList.dataList);
         mSelectedFriendsList.updateFromIndex(mSelectedFriendsList.listIndex);
         if(mFriendsList.currentLength <= mPanelCount + 1)
         {
            mFriendsList.listIndex = 0;
         }
         if(mFriendsList.currentLength <= 1)
         {
            mFriendsList.cancelSearch();
            if(mSearchBar)
            {
               mSearchBar.triggerDefaultOut();
            }
         }
         mFriendsList.updateFromIndex(mFriendsList.listIndex,mSelectedFriendsList.dataList);
         updateButtonsAndSliders();
         dispatchEvent(new Event("ChangeEvent"));
      }
      
      private function selectedPanelClickHandler(event:Event) : void
      {
         removeFromList(FriendsSelectPanel(event.target).id,mSelectedFriendsList.dataList);
         mFriendsList.sortByFirstName();
         mSelectedFriendsList.updateFromIndex(mSelectedFriendsList.listIndex);
         mFriendsList.updateFromIndex(mFriendsList.listIndex,mSelectedFriendsList.dataList);
         updateButtonsAndSliders();
         dispatchEvent(new Event("ChangeEvent"));
      }
      
      public function deleteSent(num:int, allTabs:Array) : void
      {
         var i:int = 0;
         var friend:* = null;
         for(i = 0; i < num; )
         {
            friend = mSelectedFriendsList.dataList.shift();
            for each(var tab in allTabs)
            {
               removeFromList(friend.id,tab);
            }
            removeFromList(friend.id,mFriendsList.dataList);
            i++;
         }
         mFriendsList.sortByFirstName();
         mSelectedFriendsList.updateFromIndex(mSelectedFriendsList.listIndex);
         mFriendsList.updateFromIndex(mFriendsList.listIndex,mSelectedFriendsList.dataList);
         updateButtonsAndSliders();
         dispatchEvent(new Event("ChangeEvent"));
      }
      
      private function updateButtonsAndSliders(updateSlider:Boolean = true, updateButtons:Boolean = true, updateSelectAll:Boolean = true) : void
      {
         if(updateSlider)
         {
            updateScrollBarSlider(mFriendsList.listIndex);
         }
         if(updateButtons)
         {
            updateScrollBarButtons(mScrollBarFriends,mScrollBarDesign,mFriendsList,mPanelCount);
            updateScrollBarButtons(mScrollBarSelected,mScrollBarSelectedDesign,mSelectedFriendsList,mSelectedPanelCount);
         }
         if(updateSelectAll)
         {
            updateSelectAllButton();
         }
         if(mSelectedFriendsList.currentLength > 0)
         {
            mEmptyTextfield.setVisible(false);
         }
         else
         {
            mEmptyTextfield.setVisible(true);
         }
      }
      
      private function updateScrollBarButtons(bar:ScrollBar, clip:MovieClip, list:CellList, panelCount:uint) : void
      {
         var max:int = list.currentLength - list.panelList.length;
         if(list.currentLength <= list.panelList.length)
         {
            clip.visible = false;
         }
         else
         {
            clip.visible = true;
         }
         if(list.listIndex == 0)
         {
            if(bar.buttonUp)
            {
               bar.buttonUp.setEnabled(false);
            }
         }
         else if(bar.buttonUp)
         {
            bar.buttonUp.setEnabled(true);
         }
         if(list.listIndex >= max)
         {
            if(bar.buttonDown)
            {
               bar.buttonDown.setEnabled(false);
            }
         }
         else if(bar.buttonDown)
         {
            bar.buttonDown.setEnabled(true);
         }
      }
      
      private function updateSelectAllButton() : void
      {
         if(mFriendsList.currentLength < 1)
         {
            mSelectAllButton.setSelected(true);
            mSelectAllButton.setState("Selected");
            if(mSearchBar)
            {
               mSearchBar.deactivate();
            }
         }
         else
         {
            mSelectAllButton.setSelected(false);
            mSelectAllButton.setState("Visible");
         }
      }
      
      private function doSearch() : void
      {
         mFriendsList.sortByFirstName();
         mFriendsList.search(mSearchBar.searchValue,mSelectedFriendsList.dataList);
         updateButtonsAndSliders(true,true,false);
      }
   }
}
