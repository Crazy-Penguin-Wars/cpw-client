package tuxwars.home.ui.screen
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.groups.UIRadialGroup;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.as3commons.lang.StringUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.logic.home.MoneyResourceElementLogic;
   import tuxwars.home.ui.screen.home.MoneyResourceElementScreen;
   import tuxwars.ui.components.IconToggleTooltipButton;
   import tuxwars.utils.TuxUiUtils;
   
   public class TuxPageSubTabScreen extends TuxPageContentScreen
   {
      
      private static const SUB_TABS_CONTAINER:String = "Container_Subtabs";
      
      private static const SUB_TAB:String = "Tab_0";
      
      private static const NAME:String = "Name";
      
      private static const CONTAINER_SORT_TABS:String = "Container_Sort_Tabs";
      
      private static const ICON:String = "Icon";
       
      
      private var _radialGroup:UIRadialGroup;
      
      private var _radialSortingGroup:UIRadialGroup;
      
      private var _moneyResourceElementScreen:MoneyResourceElementScreen;
      
      private var _contentSort:MovieClip;
      
      private var _sortText:UIAutoTextField;
      
      public function TuxPageSubTabScreen(game:TuxWarsGame, screen:MovieClip, screenData:Row)
      {
         super(game,screen,screenData);
      }
      
      public function initMoneyResourceElemenet() : void
      {
         var _loc1_:* = null;
         if(contentMoveClip && contentMoveClip.Saldo || this._design && this._design.Saldo)
         {
            if(_moneyResourceElementScreen)
            {
               _moneyResourceElementScreen.dispose();
               _moneyResourceElementScreen = null;
            }
            _loc1_ = !!contentMoveClip.Saldo ? contentMoveClip : this._design;
            _moneyResourceElementScreen = new MoneyResourceElementScreen(_loc1_,_game);
            _moneyResourceElementScreen.logic = getPageSubTabLogic().getMoneyResourceElementLogic();
            (_moneyResourceElementScreen.logic as MoneyResourceElementLogic).screen = _moneyResourceElementScreen;
         }
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(_moneyResourceElementScreen)
         {
            _moneyResourceElementScreen.logicUpdate(deltaTime);
         }
      }
      
      override public function dispose() : void
      {
         cleanUp();
         if(_radialSortingGroup)
         {
            _radialSortingGroup.dispose();
         }
         _radialSortingGroup = null;
         if(_moneyResourceElementScreen)
         {
            _moneyResourceElementScreen.dispose();
            _moneyResourceElementScreen = null;
         }
         _contentSort = null;
         super.dispose();
      }
      
      public function cleanUp() : void
      {
         if(_radialGroup != null)
         {
            _radialGroup.dispose();
         }
         _radialGroup = null;
      }
      
      public function get subTabGroup() : UIRadialGroup
      {
         return _radialGroup;
      }
      
      public function createScreen(onlyChangeContent:Boolean) : void
      {
         if(!onlyChangeContent)
         {
            initMoneyResourceElemenet();
         }
         initSubTabButtons();
         if(!onlyChangeContent)
         {
            initSorting();
         }
      }
      
      private function initSorting() : void
      {
         var _loc4_:* = null;
         var _loc2_:Boolean = false;
         var i:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         if(contentMoveClip)
         {
            if(_radialSortingGroup)
            {
               _radialSortingGroup.dispose();
            }
            _radialSortingGroup = new UIRadialGroup();
            _contentSort = contentMoveClip.getChildByName("Container_Sort_Tabs") as MovieClip;
            if(_contentSort)
            {
               _loc4_ = getPageSubTabLogic().sorting;
               _loc2_ = _loc4_ && _loc4_.length > 0 && !StringUtils.compareToIgnoreCase(_loc4_[i],"None");
               for(i = 0; i < _contentSort.numChildren; )
               {
                  _loc1_ = _contentSort.getChildAt(i) as MovieClip;
                  if(_loc1_ != null && _loc1_.name.indexOf("Tab_0") != -1)
                  {
                     if(!_loc2_)
                     {
                        if(_loc4_.length > i)
                        {
                           _loc3_ = new IconToggleTooltipButton(_contentSort.getChildByName(_loc1_.name) as MovieClip,_game,null);
                           _loc3_.addEventListener("clicked",sortPressed,false,0,true);
                           _loc3_.getIconContainer("Icon").gotoAndStop(_loc4_[i]);
                           _loc3_.setTooltip(_loc3_.getDesignMovieClip(),"SORTING_" + _loc4_[i]);
                           _radialSortingGroup.add(_loc3_);
                           _loc3_.setParameter(_loc4_[i]);
                           if(_loc4_[i] == "Rating")
                           {
                              _radialSortingGroup.setSelected(_loc3_);
                              getPageSubTabLogic().currentSort = _loc4_[i];
                           }
                        }
                        _loc1_.visible = _loc4_.length > i;
                     }
                     else
                     {
                        _loc1_.visible = false;
                     }
                  }
                  _sortText = TuxUiUtils.createAutoTextFieldWithText(_contentSort.Text as TextField,!_loc2_ ? ProjectManager.getText("SORTING") : "");
                  i++;
               }
            }
         }
      }
      
      private function sortPressed(event:UIButtonEvent) : void
      {
         getPageSubTabLogic().currentSort = event.getButton().getParameter() as String;
         createScreen(true);
      }
      
      private function initSubTabButtons() : void
      {
         var count:int = 0;
         var i:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         if(_radialGroup == null)
         {
            _radialGroup = new UIRadialGroup();
         }
         _radialGroup.dispose();
         var _loc2_:Array = getPageSubTabLogic().getTabs();
         var _loc3_:MovieClip = contentMoveClip.getChildByName("Container_Subtabs") as MovieClip;
         if(_loc3_)
         {
            count = 0;
            for(i = 0; i < _loc3_.numChildren; )
            {
               _loc1_ = _loc3_.getChildAt(i) as MovieClip;
               if(_loc1_ != null && _loc1_.name.indexOf("Tab_0") != -1)
               {
                  if(i < _loc2_.length)
                  {
                     _loc4_ = _loc2_[i];
                     var _loc8_:* = _loc4_;
                     §§push(TuxUiUtils);
                     §§push(UIToggleButton);
                     §§push(_loc3_);
                     §§push(_loc1_.name);
                     §§push(subTabPressed);
                     if(!_loc8_._cache["Name"])
                     {
                        _loc8_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","Name");
                     }
                     var _loc9_:* = _loc8_._cache["Name"];
                     _loc6_ = §§pop().createButton(§§pop(),§§pop(),§§pop(),§§pop(),_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value,_loc4_);
                     _radialGroup.add(_loc6_);
                     if(_loc4_ == getPageSubTabLogic().getCurrentTab())
                     {
                        _radialGroup.setSelected(_loc6_);
                     }
                     _loc1_.visible = true;
                  }
                  else
                  {
                     _loc1_.visible = false;
                  }
                  count++;
               }
               i++;
            }
            _radialGroup.setVisible(_loc2_.length >= 2);
            if(count < _loc2_.length)
            {
               LogUtils.log("Less sub_tabs(" + count + ") in graphics than configured sub_tabs(" + _loc2_.length + ") ods file",this,2,"Warning",true,false);
            }
         }
      }
      
      private function subTabPressed(event:MouseEvent) : void
      {
         var _loc2_:Row = _radialGroup.getSelectedButton().getParameter() as Row;
         getPageSubTabLogic().setCurrentTab(_loc2_);
         updateSubTabContent(_loc2_);
      }
      
      public function updateSubTabContent(newTab:Row) : void
      {
         LogUtils.log("Please override this in the extending class!",this,2,"Warning",false);
      }
      
      override public function set logic(logic:*) : void
      {
         super.logic = logic;
      }
      
      public function get moneyResourceElementScreen() : MoneyResourceElementScreen
      {
         return _moneyResourceElementScreen;
      }
      
      private function getPageSubTabLogic() : TuxPageSubTabLogic
      {
         return logic;
      }
      
      override public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         super.activateTutorial(itemID,arrow,addTutorialArrow);
         if(_radialGroup != null)
         {
            _radialGroup.setEnabled(false);
         }
         if(_radialSortingGroup != null)
         {
            _radialSortingGroup.setEnabled(false);
         }
      }
   }
}
