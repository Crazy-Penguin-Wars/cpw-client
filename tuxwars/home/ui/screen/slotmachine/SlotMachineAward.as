package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.slotmachine.SlotWinReference;
   import tuxwars.items.data.ItemData;
   
   public class SlotMachineAward extends UIContainers
   {
      
      public static const AWARD_EXP:String = "Award_Exp";
      
      public static const AWARD_COINS:String = "Award_Coins";
      
      public static const AWARD_CASH:String = "Award_Cash";
      
      public static const AWARD_ITEM:String = "Award_Item";
       
      
      private var _game:TuxWarsGame;
      
      private var xpScaledValue:int;
      
      public function SlotMachineAward(design:MovieClip, game:TuxWarsGame)
      {
         super();
         add("Award_Exp",new SlotMachineAwardContainer(design.getChildByName("Award_Exp") as MovieClip));
         add("Award_Coins",new SlotMachineAwardContainer(design.getChildByName("Award_Coins") as MovieClip));
         add("Award_Cash",new SlotMachineAwardContainer(design.getChildByName("Award_Cash") as MovieClip));
         add("Award_Item",new SlotMachineAwardItemContainer(design.getChildByName("Award_Item") as MovieClip));
         _game = game;
      }
      
      public function showContainer(value:SlotWinReference, containerID:String, itemIcon:ItemData, itemValue:int) : void
      {
         var level:int = 0;
         var modifier:Number = NaN;
         var baseValue:int = 0;
         super.show(containerID);
         if(containerID != "Award_Item")
         {
            if(containerID == "Award_Exp")
            {
               level = _game.player.level;
               var _loc8_:ProjectManager = ProjectManager;
               var _loc9_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachineConfiguration");
               if(!_loc9_._cache["Default"])
               {
                  var _loc14_:Row = com.dchoc.utils.DCUtils.find(_loc9_.rows,"id","Default");
                  if(!_loc14_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc9_.name + "\'",_loc9_,3);
                  }
                  _loc9_._cache["Default"] = _loc14_;
               }
               var _loc10_:* = _loc9_._cache["Default"];
               if(!_loc10_._cache["XPModifier"])
               {
                  _loc10_._cache["XPModifier"] = com.dchoc.utils.DCUtils.find(_loc10_._fields,"name","XPModifier");
               }
               var _loc11_:* = _loc10_._cache["XPModifier"];
               modifier = Number(_loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value);
               baseValue = value.rewardXP;
               xpScaledValue = level * (level * (Math.log(level) * (modifier * baseValue))) + baseValue;
               getCurrentSlotMachineContainer().setText(xpScaledValue.toString());
            }
            else if(containerID == "Award_Cash")
            {
               getCurrentSlotMachineContainer().setText(value.rewardCash.toString());
            }
            else
            {
               getCurrentSlotMachineContainer().setText(value.rewardCoin.toString());
            }
         }
         else
         {
            (getCurrentSlotMachineContainer() as SlotMachineAwardItemContainer).setItem(itemIcon.icon);
            getCurrentSlotMachineContainer().setText(itemValue.toString());
         }
      }
      
      public function getCurrentSlotMachineContainer() : SlotMachineAwardContainer
      {
         return getCurrentContainer() as SlotMachineAwardContainer;
      }
   }
}
