package tuxwars.home.ui.screen.leaderboard
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.events.UIRadialGroupEvent;
   import com.dchoc.ui.groups.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.components.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
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
      
      public function LeaderboardElement(param1:MovieClip, param2:TuxWarsGame, param3:LeaderboardScreen)
      {
         super(param1,param2);
         this.screen = param3;
         this.numSlots = this.calculateNumberOfSlots(param1.Container_Slots);
         this.header = TuxUiUtils.createAutoTextField(param1.Text_Header,"LEADERBOARD_HEADER");
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
         this.group.setSelected(this.getInitiallySelectedButton());
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
         this.objectContainer.dispose();
         this.objectContainer = null;
         super.dispose();
      }
      
      public function getSlotObject(param1:int, param2:*, param3:MovieClip) : *
      {
         return new BarElement(param3,param2,game,this.maxValue,this.wornItems,this.tab);
      }
      
      public function showStats(param1:Object, param2:String, param3:Object) : void
      {
         this.stats = param1;
         this.tab = param2;
         if(this.header)
         {
            this.header.setText(ProjectManager.getText(this.screen.leaderboardLogic.getCurrentTabTID()));
         }
         this.wornItems = param3;
         if(this.objectContainer)
         {
            this.objectContainer.dispose();
         }
         this.objectContainer = new ObjectContainer(this._design,game,this.getSlotObject,"transition_slots_left","transition_slots_right",false);
         var _loc4_:Vector.<Object> = this.getStatList(param1[param2],param2);
         this.maxValue = this.getMaxValue(_loc4_);
         this.objectContainer.init(_loc4_);
         this.objectContainer.showObjectAtIndex(this.findIndex(_loc4_,game.player.id));
      }
      
      private function findIndex(param1:Vector.<Object>, param2:String) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(Boolean(param1[_loc3_]) && param1[_loc3_].dcgId == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function getMaxValue(param1:Vector.<Object>) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc2_ = Math.max(_loc2_,!!_loc3_ ? Number(_loc3_.value) : 0);
         }
         return _loc2_;
      }
      
      private function getStatList(param1:Object, param2:String) : Vector.<Object>
      {
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:Array = this.getStats(param1,param2);
         var _loc6_:Vector.<Object> = new Vector.<Object>(Math.max(this.numSlots,_loc5_.length),true);
         var _loc7_:int;
         _loc4_ = _loc7_ = this.numSlots > _loc5_.length ? int(this.numSlots - _loc5_.length) : 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc6_[_loc4_] = _loc5_[_loc3_++];
            _loc4_++;
         }
         return _loc6_;
      }
      
      private function getInitiallySelectedButton() : UIToggleButton
      {
         switch(this.screen.leaderboardLogic.currentLeaderboardData)
         {
            case "All":
               return this.allButton;
            case "Weekly":
               return this.weekButton;
            case "Monthly":
               return this.monthButton;
            default:
               return null;
         }
      }
      
      private function getStats(param1:Object, param2:String) : Array
      {
         var data:Object = param1;
         var stat:String = param2;
         var list:Array = this.getFilteredStats(data,stat);
         list.sort(function(param1:Object, param2:Object):int
         {
            return param2.position - param1.position;
         });
         return list;
      }
      
      private function getFilteredStats(param1:Object, param2:String) : Array
      {
         var data:Object = param1;
         var stat:String = param2;
         var list:Array = data.user is Array ? data.user : [data.user];
         if(stat == "avg_position")
         {
            return list.filter(function(param1:*, param2:int, param3:Array):Boolean
            {
               return param1.value != 0;
            });
         }
         return list;
      }
      
      private function calculateNumberOfSlots(param1:MovieClip) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            if(StringUtils.startsWith(param1.getChildAt(_loc3_).name,"Slot_0"))
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function selectionChanged(param1:UIRadialGroupEvent) : void
      {
         if(param1.getParameter() == this.weekButton)
         {
            this.screen.leaderboardLogic.leaderboardWeeklySelected();
         }
         else if(param1.getParameter() == this.monthButton)
         {
            this.screen.leaderboardLogic.leaderboardMonthlySelected();
         }
         else if(param1.getParameter() == this.allButton)
         {
            this.screen.leaderboardLogic.leaderboardAllSelected();
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

