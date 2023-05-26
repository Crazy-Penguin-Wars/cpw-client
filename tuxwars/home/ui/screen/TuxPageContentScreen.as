package tuxwars.home.ui.screen
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
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
         var _loc4_:* = screenData;
         if(!_loc4_._cache["DefaultPage"])
         {
            _loc4_._cache["DefaultPage"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","DefaultPage");
         }
         var _loc5_:* = _loc4_._cache["DefaultPage"];
         var _loc6_:* = (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) as Row;
         if(!_loc6_._cache["PageContent"])
         {
            _loc6_._cache["PageContent"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","PageContent");
         }
         var _loc7_:* = _loc6_._cache["PageContent"];
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
         var _loc2_:* = row;
         if(!_loc2_._cache["PageContent"])
         {
            _loc2_._cache["PageContent"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","PageContent");
         }
         var _loc3_:* = _loc2_._cache["PageContent"];
         content = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         updateTitle();
      }
      
      protected function updateTitle() : void
      {
         if(_title)
         {
            var _loc1_:* = pageContentLogic.getCurrentPage();
            §§push(_title);
            §§push(ProjectManager);
            if(!_loc1_._cache["Name"])
            {
               _loc1_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Name");
            }
            var _loc2_:* = _loc1_._cache["Name"];
            §§pop().setText(§§pop().getText(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value));
         }
         if(_icon)
         {
            var _loc3_:* = pageContentLogic.getCurrentPage();
            §§push(_icon);
            if(!_loc3_._cache["IconLabel"])
            {
               _loc3_._cache["IconLabel"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","IconLabel");
            }
            var _loc4_:* = _loc3_._cache["IconLabel"];
            §§pop().gotoAndStop(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
         }
      }
      
      private function set content(name:String) : void
      {
         for each(var mc in _content)
         {
            if(mc.name == name)
            {
               _currentContent = _content.getChildByName(name) as MovieClip;
               mc.visible = true;
            }
            else
            {
               mc.visible = false;
            }
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
