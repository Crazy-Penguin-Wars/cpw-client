package tuxwars.home.ui.screen
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.groups.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageLogic;
   import tuxwars.net.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class TuxPageScreen extends TuxUIScreen implements IShopTutorial
   {
      protected static const NAME:String = "Name";
      
      protected static const ICON_LABEL:String = "IconLabel";
      
      private static const ICON:String = "Icon";
      
      private static const TEXT:String = "Text";
      
      private static const HEADERS_CONTAINER:String = "Container_Headers";
      
      private static const HEADER:String = "Header_0";
      
      private static const PAGES_CONTAINER:String = "Container_Tabs";
      
      private static const PAGE:String = "Tab_0";
      
      private var _closeButton:UIButton;
      
      private var _radialGroup:UIRadialGroup;
      
      public function TuxPageScreen(param1:TuxWarsGame, param2:MovieClip)
      {
         super(param1,param2);
         this._closeButton = TuxUiUtils.createButton(UIButton,param2,"Button_Close",this.closeScreen,null,"TOOLTIP_CLOSE_BUTTON");
         this._closeButton.addEventListener("out",this.mouseOut,false,0,true);
         this._closeButton.addEventListener("over",this.mouseOver,false,0,true);
         this._radialGroup = new UIRadialGroup();
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.initActivePageIndicators();
         this.initPageIndicators();
      }
      
      override public function dispose() : void
      {
         this._closeButton.dispose();
         this._closeButton = null;
         this._radialGroup.dispose();
         this._radialGroup = null;
         super.dispose();
      }
      
      public function get tabGroup() : UIRadialGroup
      {
         return this._radialGroup;
      }
      
      public function get closeButton() : UIButton
      {
         return this._closeButton;
      }
      
      private function initActivePageIndicators() : void
      {
         var _loc8_:Field = null;
         var _loc9_:Field = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Row = null;
         var _loc6_:Array = this.pageLogic.getPages();
         var _loc7_:MovieClip = getDesignMovieClip().getChildByName(HEADERS_CONTAINER) as MovieClip;
         if(_loc7_)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc7_.numChildren)
            {
               _loc3_ = _loc7_.getChildAt(_loc2_) as MovieClip;
               if(_loc3_ != null && _loc3_.name.indexOf(HEADER) != -1)
               {
                  _loc4_ = _loc3_.getChildByName(ICON) as MovieClip;
                  if(_loc2_ < _loc6_.length)
                  {
                     _loc5_ = _loc6_[_loc2_];
                     if(!_loc5_.getCache[NAME])
                     {
                        _loc5_.getCache[NAME] = DCUtils.find(_loc5_.getFields(),"name",NAME);
                     }
                     _loc8_ = _loc5_.getCache[NAME];
                     TuxUiUtils.createAutoTextField(_loc3_.getChildByName(TEXT) as TextField,!!_loc8_ ? (_loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value) : "");
                     if(!_loc5_.getCache[ICON_LABEL])
                     {
                        _loc5_.getCache[ICON_LABEL] = DCUtils.find(_loc5_.getFields(),"name",ICON_LABEL);
                     }
                     _loc9_ = _loc5_.getCache[ICON_LABEL];
                     if(_loc9_)
                     {
                        _loc4_.gotoAndStop(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
                     }
                     else
                     {
                        _loc4_.gotoAndStop(0);
                     }
                     _loc3_.visible = _loc5_ == this.pageLogic.getCurrentPage();
                  }
                  else
                  {
                     _loc4_.gotoAndStop(0);
                     _loc3_.visible = false;
                  }
                  _loc1_++;
               }
               _loc2_++;
            }
            if(_loc1_ < _loc6_.length)
            {
               LogUtils.log("Less pages than configured pages(1)",this,2,"Warning",false,false);
            }
         }
      }
      
      private function initPageIndicators() : void
      {
         var _loc9_:Field = null;
         var _loc10_:Field = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:Row = null;
         var _loc6_:IconToggleButton = null;
         var _loc7_:Array = this.pageLogic.getPages();
         var _loc8_:MovieClip = getDesignMovieClip().getChildByName(PAGES_CONTAINER) as MovieClip;
         if(_loc8_)
         {
            _loc1_ = 0;
            this.hideTabs(_loc8_);
            _loc2_ = 0;
            while(_loc2_ < _loc8_.numChildren)
            {
               _loc3_ = _loc8_.getChildAt(_loc2_) as MovieClip;
               _loc4_ = 1;
               while(_loc4_ < _loc7_.length + 1)
               {
                  if(_loc3_ != null && _loc3_.name == PAGE + _loc4_)
                  {
                     _loc5_ = _loc7_[_loc4_ - 1];
                     if(!_loc5_.getCache[NAME])
                     {
                        _loc5_.getCache[NAME] = DCUtils.find(_loc5_.getFields(),"name",NAME);
                     }
                     _loc9_ = _loc5_.getCache[NAME];
                     _loc6_ = TuxUiUtils.createButton(IconToggleButton,_loc8_,_loc3_.name,this.pagePressed,!!_loc9_ ? (_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value) : "",_loc5_);
                     if(!_loc5_.getCache[ICON_LABEL])
                     {
                        _loc5_.getCache[ICON_LABEL] = DCUtils.find(_loc5_.getFields(),"name",ICON_LABEL);
                     }
                     _loc10_ = _loc5_.getCache[ICON_LABEL];
                     if(_loc10_)
                     {
                        _loc6_.getIconContainer(ICON).gotoAndStop(_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value);
                     }
                     this._radialGroup.add(_loc6_);
                     if(_loc5_ == this.pageLogic.getCurrentPage())
                     {
                        this._radialGroup.setSelected(_loc6_);
                     }
                     _loc3_.visible = true;
                     _loc1_++;
                  }
                  _loc4_++;
               }
               _loc2_++;
            }
            if(_loc1_ < _loc7_.length)
            {
               LogUtils.log("Less pages than configured pages(2)",this,2,"Warning",false,false);
            }
         }
      }
      
      private function hideTabs(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_) as MovieClip;
            if(StringUtils.startsWith(_loc3_.name,"Tab_0"))
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
      }
      
      private function pagePressed(param1:MouseEvent) : void
      {
         var _loc2_:Row = this._radialGroup.getSelectedButton().getParameter() as Row;
         CRMService.sendEvent("Game",CRMService.classChecker(this),"Clicked",_loc2_.id);
         this.pageLogic.setCurrentPage(_loc2_);
         this.updatePageContent(_loc2_);
      }
      
      public function updatePageContent(param1:Row) : void
      {
         LogUtils.log("Override this method in extending class!",this,2,"Warning",false);
      }
      
      protected function closeScreen(param1:MouseEvent) : void
      {
         close();
      }
      
      private function get pageLogic() : TuxPageLogic
      {
         return logic;
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         if(this._closeButton)
         {
            this._closeButton.setEnabled(false);
         }
         if(this._radialGroup)
         {
            this._radialGroup.setEnabled(false);
         }
      }
   }
}

