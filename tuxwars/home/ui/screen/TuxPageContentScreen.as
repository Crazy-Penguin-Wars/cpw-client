package tuxwars.home.ui.screen
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageContentLogic;
   import tuxwars.utils.TuxUiUtils;
   
   public class TuxPageContentScreen extends TuxPageScreen
   {
      private static const DEFAULT_PAGE:String = "DefaultPage";
      
      private static const PAGE_CONTENT:String = "PageContent";
      
      private static const CONTENT:String = "Content";
      
      private var _title:UIAutoTextField;
      
      private var _icon:MovieClip;
      
      private var _content:MovieClip;
      
      private var _currentContent:MovieClip;
      
      public function TuxPageContentScreen(game:TuxWarsGame, screen:MovieClip, screenData:Row)
      {
         super(game,screen);
         _content = screen.getChildByName("Content") as MovieClip;
         ExternalInterface.call("console.log","PLEASE");
         ExternalInterface.call("console.log",JSON.stringify(_content.name));
         var _loc8_:String = "DefaultPage";
         var _loc4_:* = screenData;
         if(!_loc4_._cache[_loc8_])
         {
            _loc4_._cache[_loc8_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc8_);
         }
         var _loc5_:* = _loc4_._cache[_loc8_];
         var _loc9_:String = "PageContent";
         var _loc6_:* = (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) as Row;
         if(!_loc6_._cache[_loc9_])
         {
            _loc6_._cache[_loc9_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc9_);
         }
         var _loc7_:* = _loc6_._cache[_loc9_];
         ExternalInterface.call("console.log","PLEASE");
         ExternalInterface.call("console.log",_loc7_._value);
         content = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
         if(screen.Text_Header)
         {
            _title = TuxUiUtils.createAutoTextField(screen.Text_Header,"");
         }
         if(screen.Icon)
         {
            _icon = screen.Icon;
         }
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         if(_title)
         {
            updateTitle();
         }
      }
      
      public function get contentMoveClip() : MovieClip
      {
         return _currentContent;
      }
      
      override public function updatePageContent(row:Row) : void
      {
         var _loc4_:String = "PageContent";
         var _loc2_:* = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc3_:* = _loc2_._cache[_loc4_];
         content = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         ExternalInterface.call("console.log","definitely recognizable lol");
         ExternalInterface.call("console.log",_loc3_);
         updateTitle();
      }
      
      protected function updateTitle() : void
      {
         if(_title)
         {
            var _loc5_:String = "Name";
            var _loc1_:* = pageContentLogic.getCurrentPage();
            §§push(_title);
            §§push(ProjectManager);
            if(!_loc1_._cache[_loc5_])
            {
               _loc1_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc5_);
            }
            var _loc2_:* = _loc1_._cache[_loc5_];
            §§pop().setText(§§pop().getText(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value));
         }
         if(_icon)
         {
            var _loc6_:String = "IconLabel";
            var _loc3_:* = pageContentLogic.getCurrentPage();
            §§push(_icon);
            if(!_loc3_._cache[_loc6_])
            {
               _loc3_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc6_);
            }
            var _loc4_:* = _loc3_._cache[_loc6_];
            §§pop().gotoAndStop(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
         }
      }
      
      private function set content(name:String) : void
      {
         var i:int = 0;
         while(i < _content.numChildren)
         {
            var mc:MovieClip = _content.getChildAt(i) as MovieClip;
            if(mc && mc.name == name)
            {
               _currentContent = mc;
               mc.visible = true;
            }
            else
            {
               mc.visible = false;
            }
            i++;
         }
      }
      
      private function get pageContentLogic() : TuxPageContentLogic
      {
         return logic;
      }
      
      override public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         super.activateTutorial(itemID,arrow,addTutorialArrow);
      }
   }
}

