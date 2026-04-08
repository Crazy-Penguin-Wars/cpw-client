package tuxwars.home.ui.screen.leaderboard
{
   import com.dchoc.avatar.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import com.dchoc.ui.groups.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.data.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class PersonalStatsElement extends TuxUIElementScreen
   {
      private static const CONTAINER_ROW:String = "Container_Row0";
      
      private const group:UIRadialGroup = new UIRadialGroup();
      
      private var weekButton:UIToggleButton;
      
      private var monthButton:UIToggleButton;
      
      private var allButton:UIToggleButton;
      
      private var upButton:UIButton;
      
      private var downButton:UIButton;
      
      private var screen:LeaderboardScreen;
      
      private var curPage:int;
      
      private var numPages:int;
      
      private var _numContainerRows:int = -1;
      
      private var stats:Object;
      
      private var avatar:TuxAvatar;
      
      public function PersonalStatsElement(param1:MovieClip, param2:TuxWarsGame, param3:LeaderboardScreen)
      {
         super(param1,param2);
         this.screen = param3;
         TuxUiUtils.createAutoTextField(param1.Text_Header,"LEADERBOARD_PERSONAL_HEADER");
         this.upButton = TuxUiUtils.createButton(UIButton,param1,"Button_Arrow_Up",this.upCallback);
         this.downButton = TuxUiUtils.createButton(UIButton,param1,"Button_Arrow_Down",this.downCallback);
         this.weekButton = TuxUiUtils.createButton(UIToggleButton,param1,"Button_Range_01",null,"LEADERBOARD_PERSONAL_BUTTON_WEEK","LEADERBOARD_PERSONAL_BUTTON_WEEK_TOOLTIP");
         this.weekButton.addEventListener("over",this.mouseOver,false,0,true);
         this.weekButton.addEventListener("out",this.mouseOut,false,0,true);
         this.group.add(this.weekButton);
         this.monthButton = TuxUiUtils.createButton(UIToggleButton,param1,"Button_Range_02",null,"LEADERBOARD_PERSONAL_BUTTON_MONTH","LEADERBOARD_PERSONAL_BUTTON_MONTH_TOOLTIP");
         this.monthButton.addEventListener("over",this.mouseOver,false,0,true);
         this.monthButton.addEventListener("out",this.mouseOut,false,0,true);
         this.group.add(this.monthButton);
         this.allButton = TuxUiUtils.createButton(UIToggleButton,param1,"Button_Range_03",null,"LEADERBOARD_PERSONAL_BUTTON_ALL","LEADERBOARD_PERSONAL_BUTTON_ALL_TOOLTIP");
         this.allButton.addEventListener("over",this.mouseOver,false,0,true);
         this.allButton.addEventListener("out",this.mouseOut,false,0,true);
         this.group.add(this.allButton);
         this.group.addEventListener("selection_changed",this.selectionChanged,false,0,true);
         this.group.setSelected(this.allButton);
         this.hideStatFields();
         this.setupAvatar();
      }
      
      override public function dispose() : void
      {
         TooltipManager.removeTooltip();
         this.weekButton.removeEventListener("over",this.mouseOver);
         this.weekButton.removeEventListener("out",this.mouseOut);
         this.weekButton = null;
         this.monthButton.removeEventListener("over",this.mouseOver);
         this.monthButton.removeEventListener("out",this.mouseOut);
         this.monthButton = null;
         this.allButton.removeEventListener("over",this.mouseOver);
         this.allButton.removeEventListener("out",this.mouseOut);
         this.allButton = null;
         this.group.removeEventListener("selection_changed",this.selectionChanged);
         this.group.dispose();
         this.upButton.dispose();
         this.upButton = null;
         this.downButton.dispose();
         this.downButton = null;
         this.avatar.dispose();
         this.avatar = null;
         super.dispose();
      }
      
      public function showStats(param1:Object) : void
      {
         this.stats = param1;
         if(PlayerReportDatas.PLAYER_REPORT_DATAS.length == 0)
         {
            PlayerReportDatas.initReportDatas();
         }
         this.numPages = Math.ceil(PlayerReportDatas.PLAYER_REPORT_DATAS.length / this.numContainerRows);
         this.curPage = 0;
         this.showPage(this.curPage);
         this.downButton.setEnabled(this.curPage < this.numPages && this.numPages > 1);
         this.upButton.setEnabled(this.curPage > 0);
      }
      
      private function setupAvatar() : void
      {
         var _loc2_:* = undefined;
         this.avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         this.avatar.animate(new AvatarAnimation("idle"));
         this._design.Container_Character.addChild(this.avatar);
         var _loc1_:Object = game.player.wornItemsContainer.getWornItems();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_)
            {
               this.avatar.wearClothing(_loc2_);
            }
         }
      }
      
      private function showPage(param1:int) : void
      {
         var _loc2_:int = 0;
         this.hideStatFields();
         var _loc3_:Vector.<PlayerReportData> = this.getObjectsOnPage(param1);
         var _loc4_:int = Math.min(_loc3_.length,this.numContainerRows);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            this.showStat(_loc3_[_loc2_],getDesignMovieClip().getChildByName("Container_Row0" + (_loc2_ + 1)) as MovieClip);
            _loc2_++;
         }
      }
      
      private function showStat(param1:PlayerReportData, param2:MovieClip) : void
      {
         var _loc3_:* = !!this.stats.hasOwnProperty(param1.dataField) ? this.stats[param1.dataField] : 0;
         TuxUiUtils.createAutoTextField(param2.Text_Description,param1.description);
         TuxUiUtils.createAutoTextFieldWithText(param2.Text_Value,this.formatStatValue(_loc3_,param1.dataField));
         param2.visible = true;
      }
      
      private function formatStatValue(param1:*, param2:String) : String
      {
         switch(param2)
         {
            case "missile_airtime":
               return param1 / 1000 + "s";
            case "distance_walked":
               return param1 + "m";
            case "terrain_destroyed":
               return param1 / 100 + "m" + String.fromCharCode(178);
            default:
               return param1.toString();
         }
      }
      
      private function hideStatFields() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         _loc1_ = 0;
         while(_loc1_ < getDesignMovieClip().numChildren)
         {
            _loc2_ = getDesignMovieClip().getChildAt(_loc1_);
            if(StringUtils.startsWith(_loc2_.name,"Container_Row0"))
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
      }
      
      private function get numContainerRows() : int
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         if(this._numContainerRows == -1)
         {
            ++this._numContainerRows;
            _loc1_ = 0;
            while(_loc1_ < getDesignMovieClip().numChildren)
            {
               _loc2_ = getDesignMovieClip().getChildAt(_loc1_);
               if(StringUtils.startsWith(_loc2_.name,"Container_Row0"))
               {
                  ++this._numContainerRows;
               }
               _loc1_++;
            }
         }
         return this._numContainerRows;
      }
      
      private function getObjectsOnPage(param1:int) : Vector.<PlayerReportData>
      {
         var _loc2_:int = param1 * this.numContainerRows;
         var _loc3_:PlayerReportDatas = PlayerReportDatas;
         if(PlayerReportDatas.PLAYER_REPORT_DATAS.length == 0)
         {
            PlayerReportDatas.initReportDatas();
         }
         var _loc4_:int = PlayerReportDatas.PLAYER_REPORT_DATAS.length - _loc2_;
         var _loc5_:int = _loc2_ + (_loc4_ < this.numContainerRows ? _loc4_ : this.numContainerRows);
         var _loc6_:PlayerReportDatas = PlayerReportDatas;
         if(PlayerReportDatas.PLAYER_REPORT_DATAS.length == 0)
         {
            PlayerReportDatas.initReportDatas();
         }
         return PlayerReportDatas.PLAYER_REPORT_DATAS.slice(_loc2_,_loc5_);
      }
      
      private function selectionChanged(param1:UIRadialGroupEvent) : void
      {
         if(param1.getParameter() == this.weekButton)
         {
            this.screen.leaderboardLogic.personalWeeklySelected();
         }
         else if(param1.getParameter() == this.monthButton)
         {
            this.screen.leaderboardLogic.personalMonthlySelected();
         }
         else if(param1.getParameter() == this.allButton)
         {
            this.screen.leaderboardLogic.personalAllSelected();
         }
      }
      
      private function upCallback(param1:MouseEvent) : void
      {
         if(this.curPage - 1 >= 0)
         {
            --this.curPage;
            this.showPage(this.curPage);
            if(this.curPage == 0)
            {
               this.upButton.setEnabled(false);
            }
            if(!this.downButton.getEnabled())
            {
               this.downButton.setEnabled(true);
            }
         }
      }
      
      private function downCallback(param1:MouseEvent) : void
      {
         if(this.curPage + 1 < this.numPages)
         {
            ++this.curPage;
            this.showPage(this.curPage);
            if(this.curPage == this.numPages - 1)
            {
               this.downButton.setEnabled(false);
            }
            if(!this.upButton.getEnabled())
            {
               this.upButton.setEnabled(true);
            }
         }
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

