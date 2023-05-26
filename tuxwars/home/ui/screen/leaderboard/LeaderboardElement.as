package tuxwars.home.ui.screen.leaderboard
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import com.dchoc.ui.groups.UIRadialGroup;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import org.as3commons.lang.StringUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class LeaderboardElement extends TuxUIElementScreen
   {
      
      private static const SLOT:String = "Slot_0";
       
      
      private const group:UIRadialGroup = new UIRadialGroup();
      
      private var weekButton:UIToggleButton;
      
      private var monthButton:UIToggleButton;
      
      private var allButton:UIToggleButton;
      
      private var screen:LeaderboardScreen;
      
      private var objectContainer:ObjectContainer;
      
      private var numSlots:int;
      
      private var stats:Object;
      
      private var tab:String;
      
      private var wornItems:Object;
      
      private var maxValue:int;
      
      private var header:UIAutoTextField;
      
      public function LeaderboardElement(design:MovieClip, game:TuxWarsGame, screen:LeaderboardScreen)
      {
         super(design,game);
         this.screen = screen;
         numSlots = calculateNumberOfSlots(design.Container_Slots);
         header = TuxUiUtils.createAutoTextField(design.Text_Header,"LEADERBOARD_HEADER");
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
         group.setSelected(getInitiallySelectedButton());
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
         objectContainer.dispose();
         objectContainer = null;
         super.dispose();
      }
      
      public function getSlotObject(slotIndex:int, object:*, design:MovieClip) : *
      {
         return new BarElement(design,object,game,maxValue,wornItems,tab);
      }
      
      public function showStats(stats:Object, tab:String, wornItems:Object) : void
      {
         this.stats = stats;
         this.tab = tab;
         if(header)
         {
            header.setText(ProjectManager.getText(screen.leaderboardLogic.getCurrentTabTID()));
         }
         this.wornItems = wornItems;
         if(objectContainer)
         {
            objectContainer.dispose();
         }
         objectContainer = new ObjectContainer(this._design,game,getSlotObject,"transition_slots_left","transition_slots_right",false);
         var _loc4_:Vector.<Object> = getStatList(stats[tab],tab);
         maxValue = getMaxValue(_loc4_);
         objectContainer.init(_loc4_);
         objectContainer.showObjectAtIndex(findIndex(_loc4_,game.player.id));
      }
      
      private function findIndex(statList:Vector.<Object>, id:String) : int
      {
         var i:int = 0;
         for(i = 0; i < statList.length; )
         {
            if(statList[i] && statList[i].dcgId == id)
            {
               return i;
            }
            i++;
         }
         return 0;
      }
      
      private function getMaxValue(statList:Vector.<Object>) : int
      {
         var value:int = 0;
         for each(var stat in statList)
         {
            value = Math.max(value,!!stat ? stat.value : 0);
         }
         return value;
      }
      
      private function getStatList(data:Object, stat:String) : Vector.<Object>
      {
         var j:int = 0;
         var i:* = 0;
         var _loc5_:Array = getStats(data,stat);
         var _loc4_:Vector.<Object> = new Vector.<Object>(Math.max(numSlots,_loc5_.length),true);
         var _loc3_:int = numSlots > _loc5_.length ? numSlots - _loc5_.length : 0;
         for(i = _loc3_; i < _loc4_.length; )
         {
            _loc4_[i] = _loc5_[j++];
            i++;
         }
         return _loc4_;
      }
      
      private function getInitiallySelectedButton() : UIToggleButton
      {
         switch(screen.leaderboardLogic.currentLeaderboardData)
         {
            case "All":
               return allButton;
            case "Weekly":
               return weekButton;
            case "Monthly":
               return monthButton;
            default:
               return null;
         }
      }
      
      private function getStats(data:Object, stat:String) : Array
      {
         var list:Array = getFilteredStats(data,stat);
         list.sort(function(obj1:Object, obj2:Object):int
         {
            return Number(obj2.position) - Number(obj1.position);
         });
         return list;
      }
      
      private function getFilteredStats(data:Object, stat:String) : Array
      {
         var list:Array = data.user is Array ? data.user : [data.user];
         if(stat == "avg_position")
         {
            return list.filter(function(item:*, index:int, array:Array):Boolean
            {
               return item.value != 0;
            });
         }
         return list;
      }
      
      private function calculateNumberOfSlots(container:MovieClip) : int
      {
         var count:int = 0;
         var i:int = 0;
         for(i = 0; i < container.numChildren; )
         {
            if(StringUtils.startsWith(container.getChildAt(i).name,"Slot_0"))
            {
               count++;
            }
            i++;
         }
         return count;
      }
      
      private function selectionChanged(event:UIRadialGroupEvent) : void
      {
         if(event.getParameter() == weekButton)
         {
            screen.leaderboardLogic.leaderboardWeeklySelected();
         }
         else if(event.getParameter() == monthButton)
         {
            screen.leaderboardLogic.leaderboardMonthlySelected();
         }
         else if(event.getParameter() == allButton)
         {
            screen.leaderboardLogic.leaderboardAllSelected();
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
