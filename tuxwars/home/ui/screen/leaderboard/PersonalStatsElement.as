package tuxwars.home.ui.screen.leaderboard
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import com.dchoc.ui.groups.UIRadialGroup;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.as3commons.lang.StringUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.data.PlayerReportData;
   import tuxwars.data.PlayerReportDatas;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.ClothingItem;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function PersonalStatsElement(design:MovieClip, game:TuxWarsGame, leaderboardScreen:LeaderboardScreen)
      {
         super(design,game);
         screen = leaderboardScreen;
         TuxUiUtils.createAutoTextField(design.Text_Header,"LEADERBOARD_PERSONAL_HEADER");
         upButton = TuxUiUtils.createButton(UIButton,design,"Button_Arrow_Up",upCallback);
         downButton = TuxUiUtils.createButton(UIButton,design,"Button_Arrow_Down",downCallback);
         weekButton = TuxUiUtils.createButton(UIToggleButton,design,"Button_Range_01",null,"LEADERBOARD_PERSONAL_BUTTON_WEEK","LEADERBOARD_PERSONAL_BUTTON_WEEK_TOOLTIP");
         weekButton.addEventListener("over",mouseOver,false,0,true);
         weekButton.addEventListener("out",mouseOut,false,0,true);
         group.add(weekButton);
         monthButton = TuxUiUtils.createButton(UIToggleButton,design,"Button_Range_02",null,"LEADERBOARD_PERSONAL_BUTTON_MONTH","LEADERBOARD_PERSONAL_BUTTON_MONTH_TOOLTIP");
         monthButton.addEventListener("over",mouseOver,false,0,true);
         monthButton.addEventListener("out",mouseOut,false,0,true);
         group.add(monthButton);
         allButton = TuxUiUtils.createButton(UIToggleButton,design,"Button_Range_03",null,"LEADERBOARD_PERSONAL_BUTTON_ALL","LEADERBOARD_PERSONAL_BUTTON_ALL_TOOLTIP");
         allButton.addEventListener("over",mouseOver,false,0,true);
         allButton.addEventListener("out",mouseOut,false,0,true);
         group.add(allButton);
         group.addEventListener("selection_changed",selectionChanged,false,0,true);
         group.setSelected(allButton);
         hideStatFields();
         setupAvatar();
      }
      
      override public function dispose() : void
      {
         TooltipManager.removeTooltip();
         weekButton.removeEventListener("over",mouseOver);
         weekButton.removeEventListener("out",mouseOut);
         weekButton = null;
         monthButton.removeEventListener("over",mouseOver);
         monthButton.removeEventListener("out",mouseOut);
         monthButton = null;
         allButton.removeEventListener("over",mouseOver);
         allButton.removeEventListener("out",mouseOut);
         allButton = null;
         group.removeEventListener("selection_changed",selectionChanged);
         group.dispose();
         upButton.dispose();
         upButton = null;
         downButton.dispose();
         downButton = null;
         avatar.dispose();
         avatar = null;
         super.dispose();
      }
      
      public function showStats(stats:Object) : void
      {
         this.stats = stats;
         var _loc2_:PlayerReportDatas = PlayerReportDatas;
         §§push(Math);
         if(tuxwars.data.PlayerReportDatas.PLAYER_REPORT_DATAS.length == 0)
         {
            tuxwars.data.PlayerReportDatas.initReportDatas();
         }
         numPages = §§pop().ceil(Number(tuxwars.data.PlayerReportDatas.PLAYER_REPORT_DATAS.length) / numContainerRows);
         curPage = 0;
         showPage(curPage);
         downButton.setEnabled(curPage < numPages && numPages > 1);
         upButton.setEnabled(curPage > 0);
      }
      
      private function setupAvatar() : void
      {
         avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         avatar.animate(new AvatarAnimation("idle"));
         this._design.Container_Character.addChild(avatar);
         var _loc1_:Object = game.player.wornItemsContainer.getWornItems();
         for each(var item in _loc1_)
         {
            if(item)
            {
               avatar.wearClothing(item);
            }
         }
      }
      
      private function showPage(index:int) : void
      {
         var i:int = 0;
         hideStatFields();
         var _loc2_:Vector.<PlayerReportData> = getObjectsOnPage(index);
         var _loc3_:int = Math.min(_loc2_.length,numContainerRows);
         for(i = 0; i < _loc3_; )
         {
            showStat(_loc2_[i],getDesignMovieClip().getChildByName("Container_Row0" + (i + 1)) as MovieClip);
            i++;
         }
      }
      
      private function showStat(data:PlayerReportData, mc:MovieClip) : void
      {
         TuxUiUtils.createAutoTextField(mc.Text_Description,data.description);
         TuxUiUtils.createAutoTextFieldWithText(mc.Text_Value,formatStatValue(0,data.dataField));
         mc.visible = true;
      }
      
      private function formatStatValue(value:*, stat:String) : String
      {
         switch(stat)
         {
            case "missile_airtime":
               return value / 1000 + "s";
            case "distance_walked":
               return value + "m";
            case "terrain_destroyed":
               return value / 100 + "m" + String.fromCharCode(178);
            default:
               return value.toString();
         }
      }
      
      private function hideStatFields() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         for(i = 0; i < getDesignMovieClip().numChildren; )
         {
            _loc1_ = getDesignMovieClip().getChildAt(i);
            if(StringUtils.startsWith(_loc1_.name,"Container_Row0"))
            {
               _loc1_.visible = false;
            }
            i++;
         }
      }
      
      private function get numContainerRows() : int
      {
         var i:int = 0;
         var _loc1_:* = null;
         if(_numContainerRows == -1)
         {
            _numContainerRows++;
            for(i = 0; i < getDesignMovieClip().numChildren; )
            {
               _loc1_ = getDesignMovieClip().getChildAt(i);
               if(StringUtils.startsWith(_loc1_.name,"Container_Row0"))
               {
                  _numContainerRows++;
               }
               i++;
            }
         }
         return _numContainerRows;
      }
      
      private function getObjectsOnPage(pageIndex:int) : Vector.<PlayerReportData>
      {
         var _loc3_:int = pageIndex * numContainerRows;
         var _loc5_:PlayerReportDatas = PlayerReportDatas;
         if(tuxwars.data.PlayerReportDatas.PLAYER_REPORT_DATAS.length == 0)
         {
            tuxwars.data.PlayerReportDatas.initReportDatas();
         }
         var _loc2_:int = Number(tuxwars.data.PlayerReportDatas.PLAYER_REPORT_DATAS.length) - _loc3_;
         var _loc4_:int = _loc3_ + (_loc2_ < numContainerRows ? _loc2_ : numContainerRows);
         var _loc6_:PlayerReportDatas = PlayerReportDatas;
         if(tuxwars.data.PlayerReportDatas.PLAYER_REPORT_DATAS.length == 0)
         {
            tuxwars.data.PlayerReportDatas.initReportDatas();
         }
         return tuxwars.data.PlayerReportDatas.PLAYER_REPORT_DATAS.slice(_loc3_,_loc4_);
      }
      
      private function selectionChanged(event:UIRadialGroupEvent) : void
      {
         if(event.getParameter() == weekButton)
         {
            screen.leaderboardLogic.personalWeeklySelected();
         }
         else if(event.getParameter() == monthButton)
         {
            screen.leaderboardLogic.personalMonthlySelected();
         }
         else if(event.getParameter() == allButton)
         {
            screen.leaderboardLogic.personalAllSelected();
         }
      }
      
      private function upCallback(event:MouseEvent) : void
      {
         if(curPage - 1 >= 0)
         {
            curPage--;
            showPage(curPage);
            if(curPage == 0)
            {
               upButton.setEnabled(false);
            }
            if(!downButton.getEnabled())
            {
               downButton.setEnabled(true);
            }
         }
      }
      
      private function downCallback(event:MouseEvent) : void
      {
         if(curPage + 1 < numPages)
         {
            curPage++;
            showPage(curPage);
            if(curPage == numPages - 1)
            {
               downButton.setEnabled(false);
            }
            if(!upButton.getEnabled())
            {
               upButton.setEnabled(true);
            }
         }
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
