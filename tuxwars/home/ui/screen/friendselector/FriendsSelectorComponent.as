package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.scroll.ScrollBar;
   import com.dchoc.ui.text.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import tuxwars.utils.*;
   
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
      
      public function FriendsSelectorComponent(param1:DisplayObject)
      {
         if(param1 != null)
         {
            super(param1);
            this.initSearch();
            this.initFriendsList();
            this.initSelectedList();
            this.initSelectAll();
            this.initScrollBar();
            this.initDescTexts();
         }
      }
      
      public function setData(param1:Vector.<Object>) : void
      {
         this.mFriendsList.cancelSearch();
         this.mFriendsList.setDataList = param1;
         this.mFriendsList.listIndex = 0;
         this.mFriendsList.sortByFirstName();
         if(this.mSearchBar)
         {
            this.mSearchBar.activate();
         }
         this.mFriendsList.updateFromIndex(this.mFriendsList.listIndex,this.mSelectedFriendsList.dataList);
         this.updateButtonsAndSliders();
      }
      
      public function get selectedList() : CellList
      {
         return this.mSelectedFriendsList;
      }
      
      public function clean() : void
      {
         var _loc1_:CellPanel = null;
         if(this.mSearchBar)
         {
            this.mSearchBar.clean();
         }
         this.mScrollBarFriends.clean();
         this.mScrollBarFriends = null;
         this.mScrollBarSelected.clean();
         this.mScrollBarFriends = null;
         for each(_loc1_ in this.mSelectedFriendsList.panelList)
         {
            _loc1_.removeEventListener("ClickEvent",this.selectedPanelClickHandler);
         }
         this.mSelectedFriendsList.clean();
         for each(_loc1_ in this.mFriendsList.panelList)
         {
            _loc1_.removeEventListener("ClickEvent",this.friendsPanelClickHandler);
         }
         this.mFriendsList.clean();
         _loc1_ = null;
      }
      
      private function initScrollBar() : void
      {
         var _loc1_:MovieClip = getDesignMovieClip().getChildByName("Container_Slots") as MovieClip;
         var _loc2_:* = _loc1_;
         this.mScrollBarDesign = _loc2_.getChildByName("Scroll_Bar") as MovieClip;
         var _loc3_:MovieClip = this.mScrollBarDesign.getChildByName("hitarea") as MovieClip;
         var _loc4_:UIButton = TuxUiUtils.createButton(UIButton,this.mScrollBarDesign,"Button_Scroll");
         this.mScrollBarFriends = createScrollBar(_loc4_,_loc3_,this.scrollBarFriendsMove);
         this.mScrollBarFriends.setUpButton(_loc1_,"Button_Up",this.upFriendsClickHandler);
         this.mScrollBarFriends.setDownButton(_loc1_,"Button_Down",this.downFriendsClickHandler);
         _loc2_ = getDesignMovieClip().getChildByName("Friend_List_Selected") as MovieClip;
         this.mScrollBarSelectedDesign = _loc2_.getChildByName("Scroll_Bar") as MovieClip;
         _loc3_ = this.mScrollBarSelectedDesign.getChildByName("hitarea") as MovieClip;
         _loc4_ = TuxUiUtils.createButton(UIButton,this.mScrollBarSelectedDesign,"Button_Scroll");
         this.mScrollBarSelectedDesign.visible = false;
         this.mScrollBarSelected = createScrollBar(_loc4_,_loc3_,this.scrollBarSelectedMove);
         this.mScrollBarSelected.setUpButton(_loc2_,"Button_Up",this.upSelectedClickHandler);
         this.mScrollBarSelected.setDownButton(_loc2_,"Button_Down",this.downSelectedClickHandler);
      }
      
      private function upFriendsClickHandler(param1:MouseEvent) : void
      {
         if(this.mFriendsList.dataList.length > 0)
         {
            --this.mFriendsList.listIndex;
            this.mFriendsList.updateFromIndex(this.mFriendsList.listIndex,this.mSelectedFriendsList.dataList);
            this.updateButtonsAndSliders();
         }
      }
      
      private function downFriendsClickHandler(param1:MouseEvent) : void
      {
         if(this.mFriendsList.dataList.length > 0)
         {
            ++this.mFriendsList.listIndex;
            this.mFriendsList.updateFromIndex(this.mFriendsList.listIndex,this.mSelectedFriendsList.dataList);
            this.updateButtonsAndSliders();
         }
      }
      
      private function upSelectedClickHandler(param1:MouseEvent) : void
      {
         if(this.mSelectedFriendsList.dataList.length > 0)
         {
            --this.mSelectedFriendsList.listIndex;
            this.mSelectedFriendsList.updateFromIndex(this.mSelectedFriendsList.listIndex);
            this.updateButtonsAndSliders();
         }
      }
      
      private function downSelectedClickHandler(param1:MouseEvent) : void
      {
         if(this.mSelectedFriendsList.dataList.length > 0)
         {
            ++this.mSelectedFriendsList.listIndex;
            this.mSelectedFriendsList.updateFromIndex(this.mSelectedFriendsList.listIndex);
            this.updateButtonsAndSliders();
         }
      }
      
      private function initSearch() : void
      {
         var _loc1_:TextField = getDesignMovieClip().getChildByName("Text_Search") as TextField;
         if(_loc1_)
         {
            this.mSearchBar = new InputTextField(_loc1_,ProjectManager.getText("FS_SEARCH_DEFAULT"));
            this.mSearchBar.keyboardChangeCallback = this.doSearch;
         }
      }
      
      private function initDescTexts() : void
      {
         var _loc1_:MovieClip = getDesignMovieClip().getChildByName("Container_Nobody") as MovieClip;
         var _loc2_:TextField = _loc1_.getChildByName("Text") as TextField;
         this.mEmptyTextfield = new UIAutoTextField(_loc2_);
         this.mEmptyTextfield.setText(ProjectManager.getText("FS_NO_SELECTION"));
         this.mEmptyTextfield.setVisible(false);
      }
      
      private function initFriendsList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:FriendsSelectPanel = null;
         var _loc4_:MovieClip = getDesignMovieClip().getChildByName("Container_Slots") as MovieClip;
         this.mFriendsList = new MultipleFriendSelectorFriendsCollection();
         _loc1_ = 1;
         while(_loc1_ <= this.mPanelCount)
         {
            _loc2_ = "Slot_0" + _loc1_;
            if(_loc4_)
            {
               _loc3_ = new FriendsSelectPanel(_loc4_,_loc2_);
               _loc3_.addEventListener("ClickEvent",this.friendsPanelClickHandler,false,0,true);
               this.mFriendsList.addPanel(_loc3_);
            }
            else
            {
               LogUtils.log("Could not find asset: " + _loc2_);
            }
            _loc1_++;
         }
      }
      
      private function initSelectedList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         var _loc4_:FriendsSelectPanel = null;
         var _loc5_:MovieClip = getDesignMovieClip();
         this.mSelectedFriendsList = new MultipleFriendSelectorFriendsCollection();
         _loc1_ = 1;
         while(_loc1_ <= this.mSelectedPanelCount)
         {
            _loc2_ = "Slot_0" + _loc1_;
            _loc3_ = MovieClip(_loc5_.getChildByName("Friend_List_Selected"));
            if(_loc3_)
            {
               _loc4_ = new FriendsSelectPanel(_loc3_,_loc2_);
               _loc4_.addEventListener("ClickEvent",this.selectedPanelClickHandler,false,0,true);
               this.mSelectedFriendsList.addPanel(_loc4_);
            }
            _loc1_++;
         }
      }
      
      private function initSelectAll() : void
      {
         this.mSelectAllButton = TuxUiUtils.createButton(UIToggleButton,getDesignMovieClip(),"Select_All",this.selectAllHandler);
         this.mSelectAllButton.setText(ProjectManager.getText("FS_SELECT_ALL"));
      }
      
      private function selectAllHandler(param1:MouseEvent) : void
      {
         this.mFriendsList.cancelSearch();
         if(!this.mSelectAllButton.getSelected())
         {
            if(this.mSearchBar)
            {
               this.mSearchBar.activate();
            }
            this.mSelectedFriendsList.empty();
         }
         else
         {
            if(this.mSearchBar)
            {
               this.mSearchBar.deactivate();
            }
            this.mSelectedFriendsList.dataList = this.mFriendsList.dataList.concat();
         }
         this.mSelectedFriendsList.updateFromIndex(0);
         this.mFriendsList.updateFromIndex(0,this.mSelectedFriendsList.dataList);
         this.updateButtonsAndSliders(true,true,false);
         dispatchEvent(new Event("ChangeEvent"));
      }
      
      private function scrollBarFriendsMove(param1:uint) : void
      {
         scrollBarMoveHandler(param1,this.mFriendsList,this.mSelectedFriendsList);
         this.updateButtonsAndSliders(false,true,false);
      }
      
      private function scrollBarSelectedMove(param1:uint) : void
      {
         scrollBarMoveHandler(param1,this.mSelectedFriendsList);
      }
      
      private function updateScrollBarSlider(param1:uint) : void
      {
         if(this.mFriendsList.currentLength <= this.mPanelCount)
         {
            this.mScrollBarFriends.enabled = false;
         }
         else
         {
            this.mScrollBarFriends.enabled = true;
         }
         var _loc2_:uint = uint(this.mFriendsList.currentLength - this.mPanelCount);
         var _loc3_:uint = param1 / _loc2_ * 100;
         this.mScrollBarFriends.setProcentage(_loc3_);
      }
      
      private function friendsPanelClickHandler(param1:Event) : void
      {
         var _loc2_:Object = getFromListWithId(FriendsSelectPanel(param1.target).id,this.mFriendsList.dataList);
         ifNotExistWithIdUnshift(_loc2_,this.mSelectedFriendsList.dataList);
         this.mSelectedFriendsList.updateFromIndex(this.mSelectedFriendsList.listIndex);
         if(this.mFriendsList.currentLength <= this.mPanelCount + 1)
         {
            this.mFriendsList.listIndex = 0;
         }
         if(this.mFriendsList.currentLength <= 1)
         {
            this.mFriendsList.cancelSearch();
            if(this.mSearchBar)
            {
               this.mSearchBar.triggerDefaultOut();
            }
         }
         this.mFriendsList.updateFromIndex(this.mFriendsList.listIndex,this.mSelectedFriendsList.dataList);
         this.updateButtonsAndSliders();
         dispatchEvent(new Event("ChangeEvent"));
      }
      
      private function selectedPanelClickHandler(param1:Event) : void
      {
         removeFromList(FriendsSelectPanel(param1.target).id,this.mSelectedFriendsList.dataList);
         this.mFriendsList.sortByFirstName();
         this.mSelectedFriendsList.updateFromIndex(this.mSelectedFriendsList.listIndex);
         this.mFriendsList.updateFromIndex(this.mFriendsList.listIndex,this.mSelectedFriendsList.dataList);
         this.updateButtonsAndSliders();
         dispatchEvent(new Event("ChangeEvent"));
      }
      
      public function deleteSent(param1:int, param2:Array) : void
      {
         var _loc5_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = this.mSelectedFriendsList.dataList.shift();
            for each(_loc5_ in param2)
            {
               removeFromList(_loc4_.id,_loc5_);
            }
            removeFromList(_loc4_.id,this.mFriendsList.dataList);
            _loc3_++;
         }
         this.mFriendsList.sortByFirstName();
         this.mSelectedFriendsList.updateFromIndex(this.mSelectedFriendsList.listIndex);
         this.mFriendsList.updateFromIndex(this.mFriendsList.listIndex,this.mSelectedFriendsList.dataList);
         this.updateButtonsAndSliders();
         dispatchEvent(new Event("ChangeEvent"));
      }
      
      private function updateButtonsAndSliders(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param1)
         {
            this.updateScrollBarSlider(this.mFriendsList.listIndex);
         }
         if(param2)
         {
            this.updateScrollBarButtons(this.mScrollBarFriends,this.mScrollBarDesign,this.mFriendsList,this.mPanelCount);
            this.updateScrollBarButtons(this.mScrollBarSelected,this.mScrollBarSelectedDesign,this.mSelectedFriendsList,this.mSelectedPanelCount);
         }
         if(param3)
         {
            this.updateSelectAllButton();
         }
         if(this.mSelectedFriendsList.currentLength > 0)
         {
            this.mEmptyTextfield.setVisible(false);
         }
         else
         {
            this.mEmptyTextfield.setVisible(true);
         }
      }
      
      private function updateScrollBarButtons(param1:ScrollBar, param2:MovieClip, param3:CellList, param4:uint) : void
      {
         var _loc5_:int = param3.currentLength - param3.panelList.length;
         var _loc6_:int = 0;
         if(param3.currentLength <= param3.panelList.length)
         {
            param2.visible = false;
         }
         else
         {
            param2.visible = true;
         }
         if(param3.listIndex == _loc6_)
         {
            if(param1.buttonUp)
            {
               param1.buttonUp.setEnabled(false);
            }
         }
         else if(param1.buttonUp)
         {
            param1.buttonUp.setEnabled(true);
         }
         if(param3.listIndex >= _loc5_)
         {
            if(param1.buttonDown)
            {
               param1.buttonDown.setEnabled(false);
            }
         }
         else if(param1.buttonDown)
         {
            param1.buttonDown.setEnabled(true);
         }
      }
      
      private function updateSelectAllButton() : void
      {
         if(this.mFriendsList.currentLength < 1)
         {
            this.mSelectAllButton.setSelected(true);
            this.mSelectAllButton.setState("Selected");
            if(this.mSearchBar)
            {
               this.mSearchBar.deactivate();
            }
         }
         else
         {
            this.mSelectAllButton.setSelected(false);
            this.mSelectAllButton.setState("Visible");
         }
      }
      
      private function doSearch() : void
      {
         this.mFriendsList.sortByFirstName();
         this.mFriendsList.search(this.mSearchBar.searchValue,this.mSelectedFriendsList.dataList);
         this.updateButtonsAndSliders(true,true,false);
      }
   }
}

