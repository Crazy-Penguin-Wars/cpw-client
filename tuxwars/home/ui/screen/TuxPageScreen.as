package tuxwars.home.ui.screen
{
   import com.dchoc.projectdata.Row;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.groups.UIRadialGroup;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.as3commons.lang.StringUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageLogic;
   import tuxwars.net.CRMService;
   import tuxwars.ui.components.IconToggleButton;
   import tuxwars.ui.containers.shop.IShopTutorial;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function TuxPageScreen(game:TuxWarsGame, screen:MovieClip)
      {
         super(game,screen);
         _closeButton = TuxUiUtils.createButton(UIButton,screen,"Button_Close",closeScreen,null,"TOOLTIP_CLOSE_BUTTON");
         _closeButton.addEventListener("out",mouseOut,false,0,true);
         _closeButton.addEventListener("over",mouseOver,false,0,true);
         _radialGroup = new UIRadialGroup();
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         initActivePageIndicators();
         initPageIndicators();
      }
      
      override public function dispose() : void
      {
         _closeButton.dispose();
         _closeButton = null;
         _radialGroup.dispose();
         _radialGroup = null;
         super.dispose();
      }
      
      public function get tabGroup() : UIRadialGroup
      {
         return _radialGroup;
      }
      
      public function get closeButton() : UIButton
      {
         return _closeButton;
      }
      
      private function initActivePageIndicators() : void
      {
         var count:int = 0;
         var i:int = 0;
         var child:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:Array = pageLogic.getPages();
         var _loc3_:MovieClip = getDesignMovieClip().getChildByName("Container_Headers") as MovieClip;
         if(_loc3_)
         {
            count = 0;
            for(i = 0; i < _loc3_.numChildren; )
            {
               child = _loc3_.getChildAt(i) as MovieClip;
               if(child != null && child.name.indexOf("Header_0") != -1)
               {
                  _loc2_ = child.getChildByName("Icon") as MovieClip;
                  if(i < _loc6_.length)
                  {
                     _loc5_ = _loc6_[i];
                     var _loc8_:* = _loc5_;
                     §§push(TuxUiUtils);
                     §§push(child.getChildByName("Text") as TextField);
                     if(!_loc8_._cache["Name"])
                     {
                        _loc8_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","Name");
                     }
                     var _loc9_:* = _loc8_._cache["Name"];
                     §§pop().createAutoTextField(§§pop(),_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
                     var _loc10_:* = _loc5_;
                     §§push(_loc2_);
                     if(!_loc10_._cache["IconLabel"])
                     {
                        _loc10_._cache["IconLabel"] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name","IconLabel");
                     }
                     var _loc11_:* = _loc10_._cache["IconLabel"];
                     §§pop().gotoAndStop(_loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value);
                     child.visible = _loc5_ == pageLogic.getCurrentPage();
                  }
                  else
                  {
                     _loc2_.gotoAndStop(0);
                     child.visible = false;
                  }
                  count++;
               }
               i++;
            }
            if(count < _loc6_.length)
            {
               LogUtils.log("Less pages than configured pages(1)",this,2,"Warning",false,false);
            }
         }
      }
      
      private function initPageIndicators() : void
      {
         var count:int = 0;
         var i:int = 0;
         var _loc1_:* = null;
         var slotCount:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:Array = pageLogic.getPages();
         var _loc5_:MovieClip = getDesignMovieClip().getChildByName("Container_Tabs") as MovieClip;
         if(_loc5_)
         {
            count = 0;
            hideTabs(_loc5_);
            for(i = 0; i < _loc5_.numChildren; )
            {
               _loc1_ = _loc5_.getChildAt(i) as MovieClip;
               for(slotCount = 1; slotCount < _loc6_.length + 1; )
               {
                  if(_loc1_ != null && _loc1_.name == "Tab_0" + slotCount)
                  {
                     _loc4_ = _loc6_[slotCount - 1];
                     var _loc9_:* = _loc4_;
                     §§push(TuxUiUtils);
                     §§push(IconToggleButton);
                     §§push(_loc5_);
                     §§push(_loc1_.name);
                     §§push(pagePressed);
                     if(!_loc9_._cache["Name"])
                     {
                        _loc9_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc9_._fields,"name","Name");
                     }
                     var _loc10_:* = _loc9_._cache["Name"];
                     _loc3_ = §§pop().createButton(§§pop(),§§pop(),§§pop(),§§pop(),_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value,_loc4_);
                     var _loc11_:* = _loc4_;
                     §§push(_loc3_.getIconContainer("Icon"));
                     if(!_loc11_._cache["IconLabel"])
                     {
                        _loc11_._cache["IconLabel"] = com.dchoc.utils.DCUtils.find(_loc11_._fields,"name","IconLabel");
                     }
                     var _loc12_:* = _loc11_._cache["IconLabel"];
                     §§pop().gotoAndStop(_loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value);
                     _radialGroup.add(_loc3_);
                     if(_loc4_ == pageLogic.getCurrentPage())
                     {
                        _radialGroup.setSelected(_loc3_);
                     }
                     _loc1_.visible = true;
                     count++;
                  }
                  slotCount++;
               }
               i++;
            }
            if(count < _loc6_.length)
            {
               LogUtils.log("Less pages than configured pages(2)",this,2,"Warning",false,false);
            }
         }
      }
      
      private function hideTabs(mc:MovieClip) : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         for(i = 0; i < mc.numChildren; )
         {
            _loc2_ = mc.getChildAt(i) as MovieClip;
            if(StringUtils.startsWith(_loc2_.name,"Tab_0"))
            {
               _loc2_.visible = false;
            }
            i++;
         }
      }
      
      private function pagePressed(event:MouseEvent) : void
      {
         var _loc2_:Row = _radialGroup.getSelectedButton().getParameter() as Row;
         CRMService.sendEvent("Game",CRMService.classChecker(this),"Clicked",_loc2_.id);
         pageLogic.setCurrentPage(_loc2_);
         updatePageContent(_loc2_);
      }
      
      public function updatePageContent(row:Row) : void
      {
         LogUtils.log("Override this method in extending class!",this,2,"Warning",false);
      }
      
      protected function closeScreen(event:MouseEvent) : void
      {
         close();
      }
      
      private function get pageLogic() : TuxPageLogic
      {
         return logic;
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         if(_closeButton)
         {
            _closeButton.setEnabled(false);
         }
         if(_radialGroup)
         {
            _radialGroup.setEnabled(false);
         }
      }
   }
}
