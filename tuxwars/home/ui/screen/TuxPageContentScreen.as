package tuxwars.home.ui.screen
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageContentLogic;
   import tuxwars.utils.*;
   
   public class TuxPageContentScreen extends TuxPageScreen
   {
      private static const DEFAULT_PAGE:String = "DefaultPage";
      
      private static const PAGE_CONTENT:String = "PageContent";
      
      private static const CONTENT:String = "Content";
      
      private var _title:UIAutoTextField;
      
      private var _icon:MovieClip;
      
      private var _content:MovieClip;
      
      private var _currentContent:MovieClip;
      
      public function TuxPageContentScreen(param1:TuxWarsGame, param2:MovieClip, param3:Row)
      {
         var _loc7_:Field = null;
         super(param1,param2);
         this._content = param2.getChildByName(CONTENT) as MovieClip;
         var _loc4_:String = DEFAULT_PAGE;
         if(!param3.getCache[_loc4_])
         {
            param3.getCache[_loc4_] = DCUtils.find(param3.getFields(),"name",_loc4_);
         }
         var _loc5_:Field = param3.getCache[_loc4_];
         var _loc6_:Row = !!_loc5_ ? (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) as Row : null;
         if(_loc6_)
         {
            if(!_loc6_.getCache[PAGE_CONTENT])
            {
               _loc6_.getCache[PAGE_CONTENT] = DCUtils.find(_loc6_.getFields(),"name",PAGE_CONTENT);
            }
            _loc7_ = _loc6_.getCache[PAGE_CONTENT];
            this.content = !!_loc7_ ? (_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) : null;
         }
         if(param2.Text_Header)
         {
            this._title = TuxUiUtils.createAutoTextField(param2.Text_Header,"");
         }
         if(param2.Icon)
         {
            this._icon = param2.Icon;
         }
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         if(this._title)
         {
            this.updateTitle();
            this.updateTitle();
         }
      }
      
      public function get contentMoveClip() : MovieClip
      {
         return this._currentContent;
      }
      
      override public function updatePageContent(param1:Row) : void
      {
         var _loc2_:String = "PageContent";
         var _loc3_:* = param1;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:* = _loc3_.getCache[_loc2_];
         this.content = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
         this.updateTitle();
         this.updateTitle();
      }
      
      protected function updateTitle() : void
      {
         var _loc1_:Row = null;
         var _loc2_:Field = null;
         var _loc3_:Field = null;
         if(this._title)
         {
            _loc1_ = this.pageContentLogic.getCurrentPage();
            if(_loc1_)
            {
               if(!_loc1_.getCache[NAME])
               {
                  _loc1_.getCache[NAME] = DCUtils.find(_loc1_.getFields(),"name",NAME);
               }
               _loc2_ = _loc1_.getCache[NAME];
               this._title.setText(ProjectManager.getText(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value));
            }
         }
         if(this._icon)
         {
            _loc1_ = this.pageContentLogic.getCurrentPage();
            if(_loc1_)
            {
               if(!_loc1_.getCache["IconLabel"])
               {
                  _loc1_.getCache["IconLabel"] = DCUtils.find(_loc1_.getFields(),"name","IconLabel");
               }
               _loc3_ = _loc1_.getCache["IconLabel"];
               this._icon.gotoAndStop(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value);
            }
         }
      }
      
      private function set content(param1:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._content.numChildren)
         {
            _loc3_ = this._content.getChildAt(_loc2_) as MovieClip;
            if(Boolean(_loc3_) && _loc3_.name == param1)
            {
               this._currentContent = _loc3_;
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
      }
      
      private function get pageContentLogic() : TuxPageContentLogic
      {
         return logic;
      }
      
      override public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         super.activateTutorial(param1,param2,param3);
      }
   }
}

