package tuxwars.home.ui.screen
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.groups.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.logic.home.*;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
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
      
      public function TuxPageSubTabScreen(param1:TuxWarsGame, param2:MovieClip, param3:Row)
      {
         super(param1,param2,param3);
      }
      
      public function initMoneyResourceElemenet() : void
      {
         var _loc1_:MovieClip = null;
         if(contentMoveClip && contentMoveClip.Saldo || this._design && this._design.Saldo)
         {
            if(this._moneyResourceElementScreen)
            {
               this._moneyResourceElementScreen.dispose();
               this._moneyResourceElementScreen = null;
            }
            _loc1_ = !!contentMoveClip.Saldo ? contentMoveClip : this._design;
            this._moneyResourceElementScreen = new MoneyResourceElementScreen(_loc1_,_game);
            this._moneyResourceElementScreen.logic = this.getPageSubTabLogic().getMoneyResourceElementLogic();
            (this._moneyResourceElementScreen.logic as MoneyResourceElementLogic).screen = this._moneyResourceElementScreen;
         }
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(this._moneyResourceElementScreen)
         {
            this._moneyResourceElementScreen.logicUpdate(param1);
         }
      }
      
      override public function dispose() : void
      {
         this.cleanUp();
         if(this._radialSortingGroup)
         {
            this._radialSortingGroup.dispose();
         }
         this._radialSortingGroup = null;
         if(this._moneyResourceElementScreen)
         {
            this._moneyResourceElementScreen.dispose();
            this._moneyResourceElementScreen = null;
         }
         this._contentSort = null;
         super.dispose();
      }
      
      public function cleanUp() : void
      {
         if(this._radialGroup != null)
         {
            this._radialGroup.dispose();
         }
         this._radialGroup = null;
      }
      
      public function get subTabGroup() : UIRadialGroup
      {
         return this._radialGroup;
      }
      
      public function createScreen(param1:Boolean) : void
      {
         if(!param1)
         {
            this.initMoneyResourceElemenet();
         }
         this.initSubTabButtons();
         if(!param1)
         {
            this.initSorting();
         }
      }
      
      private function initSorting() : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:IconToggleTooltipButton = null;
         if(!contentMoveClip)
         {
            return;
         }
         if(this._radialSortingGroup)
         {
            this._radialSortingGroup.dispose();
         }
         this._radialSortingGroup = new UIRadialGroup();
         this._contentSort = contentMoveClip.getChildByName(CONTAINER_SORT_TABS) as MovieClip;
         if(!this._contentSort)
         {
            return;
         }
         var _loc1_:Array = this.getPageSubTabLogic().sorting;
         var _loc2_:Boolean = Boolean(_loc1_) && _loc1_.length > 0 && !(_loc1_.length == 1 && StringUtils.compareToIgnoreCase(_loc1_[0],"None") == 0);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._contentSort.numChildren)
         {
            _loc5_ = this._contentSort.getChildAt(_loc4_) as MovieClip;
            if((Boolean(_loc5_)) && _loc5_.name.indexOf(SUB_TAB) != -1)
            {
               if(_loc2_ && _loc1_.length > _loc3_)
               {
                  _loc6_ = new IconToggleTooltipButton(this._contentSort.getChildByName(_loc5_.name) as MovieClip,_game,null);
                  _loc6_.addEventListener("clicked",this.sortPressed,false,0,true);
                  _loc6_.getIconContainer(ICON).gotoAndStop(_loc1_[_loc3_]);
                  _loc6_.setTooltip(_loc6_.getDesignMovieClip(),"SORTING_" + _loc1_[_loc3_]);
                  this._radialSortingGroup.add(_loc6_);
                  _loc6_.setParameter(_loc1_[_loc3_]);
                  if(_loc1_[_loc3_] == "Rating")
                  {
                     this._radialSortingGroup.setSelected(_loc6_);
                     this.getPageSubTabLogic().currentSort = _loc1_[_loc3_];
                  }
                  _loc5_.visible = true;
                  _loc3_++;
               }
               else
               {
                  _loc5_.visible = false;
               }
            }
            _loc4_++;
         }
         this._sortText = TuxUiUtils.createAutoTextFieldWithText(this._contentSort.Text as TextField,!_loc2_ ? ProjectManager.getText("SORTING") : "");
      }
      
      private function sortPressed(param1:UIButtonEvent) : void
      {
         this.getPageSubTabLogic().currentSort = param1.getButton().getParameter() as String;
         this.createScreen(true);
      }
      
      private function initSubTabButtons() : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:Row = null;
         var _loc7_:Field = null;
         var _loc8_:String = null;
         var _loc9_:UIToggleButton = null;
         if(this._radialGroup == null)
         {
            this._radialGroup = new UIRadialGroup();
         }
         this._radialGroup.dispose();
         var _loc1_:Array = this.getPageSubTabLogic().getTabs();
         var _loc2_:MovieClip = contentMoveClip.getChildByName(SUB_TABS_CONTAINER) as MovieClip;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.numChildren)
         {
            _loc5_ = _loc2_.getChildAt(_loc4_) as MovieClip;
            if((Boolean(_loc5_)) && _loc5_.name.indexOf(SUB_TAB) != -1)
            {
               if(_loc3_ < _loc1_.length)
               {
                  _loc6_ = _loc1_[_loc3_];
                  if(!_loc6_.getCache[NAME])
                  {
                     _loc6_.getCache[NAME] = DCUtils.find(_loc6_.getFields(),"name",NAME);
                  }
                  _loc7_ = _loc6_.getCache[NAME];
                  _loc8_ = !!_loc7_ ? (_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) : null;
                  _loc9_ = TuxUiUtils.createButton(UIToggleButton,_loc2_,_loc5_.name,this.subTabPressed,_loc8_,_loc6_);
                  this._radialGroup.add(_loc9_);
                  if(_loc6_ == this.getPageSubTabLogic().getCurrentTab())
                  {
                     this._radialGroup.setSelected(_loc9_);
                  }
                  _loc5_.visible = true;
               }
               else
               {
                  _loc5_.visible = false;
               }
               _loc3_++;
            }
            _loc4_++;
         }
         this._radialGroup.setVisible(Boolean(_loc1_) && _loc1_.length >= 2);
         if(_loc3_ < (!!_loc1_ ? _loc1_.length : 0))
         {
            LogUtils.log("Less sub_tabs(" + _loc3_ + ") in graphics than configured sub_tabs(" + (!!_loc1_ ? _loc1_.length : 0) + ") ods file",this,2,"Warning",true,false);
         }
      }
      
      private function subTabPressed(param1:MouseEvent) : void
      {
         var _loc2_:Row = this._radialGroup.getSelectedButton().getParameter() as Row;
         this.getPageSubTabLogic().setCurrentTab(_loc2_);
         this.updateSubTabContent(_loc2_);
      }
      
      public function updateSubTabContent(param1:Row) : void
      {
         LogUtils.log("Please override this in the extending class!",this,2,"Warning",false);
      }
      
      override public function set logic(param1:*) : void
      {
         super.logic = param1;
      }
      
      public function get moneyResourceElementScreen() : MoneyResourceElementScreen
      {
         return this._moneyResourceElementScreen;
      }
      
      private function getPageSubTabLogic() : TuxPageSubTabLogic
      {
         return logic;
      }
      
      override public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         super.activateTutorial(param1,param2,param3);
         if(this._radialGroup != null)
         {
            this._radialGroup.setEnabled(false);
         }
         if(this._radialSortingGroup != null)
         {
            this._radialSortingGroup.setEnabled(false);
         }
      }
   }
}

