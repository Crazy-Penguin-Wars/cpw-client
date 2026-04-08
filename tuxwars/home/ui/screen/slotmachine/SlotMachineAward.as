package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.windows.UIContainers;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.*;
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
      
      public function SlotMachineAward(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         add("Award_Exp",new SlotMachineAwardContainer(param1.getChildByName("Award_Exp") as MovieClip));
         add("Award_Coins",new SlotMachineAwardContainer(param1.getChildByName("Award_Coins") as MovieClip));
         add("Award_Cash",new SlotMachineAwardContainer(param1.getChildByName("Award_Cash") as MovieClip));
         add("Award_Item",new SlotMachineAwardItemContainer(param1.getChildByName("Award_Item") as MovieClip));
         this._game = param2;
      }
      
      public function showContainer(param1:SlotWinReference, param2:String, param3:ItemData, param4:int) : void
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:* = undefined;
         var _loc11_:String = null;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:Row = null;
         var _loc5_:int = 0;
         var _loc6_:Number = Number(NaN);
         var _loc7_:int = 0;
         super.show(param2);
         if(param2 != "Award_Item")
         {
            if(param2 == "Award_Exp")
            {
               _loc5_ = int(this._game.player.level);
               _loc8_ = "SlotMachineConfiguration";
               _loc9_ = "Default";
               _loc10_ = ProjectManager.findTable(_loc8_);
               if(!_loc10_.getCache[_loc9_])
               {
                  _loc14_ = DCUtils.find(_loc10_.rows,"id",_loc9_);
                  if(!_loc14_)
                  {
                     LogUtils.log("No row with name: \'" + _loc9_ + "\' was found in table: \'" + _loc10_.name + "\'",_loc10_,3);
                  }
                  _loc10_.getCache[_loc9_] = _loc14_;
               }
               _loc11_ = "XPModifier";
               _loc12_ = _loc10_.getCache[_loc9_];
               if(!_loc12_.getCache[_loc11_])
               {
                  _loc12_.getCache[_loc11_] = DCUtils.find(_loc12_.getFields(),"name",_loc11_);
               }
               _loc13_ = _loc12_.getCache[_loc11_];
               _loc6_ = Number(_loc13_.overrideValue != null ? _loc13_.overrideValue : _loc13_._value);
               _loc7_ = param1.rewardXP;
               this.xpScaledValue = _loc5_ * (_loc5_ * (Math.log(_loc5_) * (_loc6_ * _loc7_))) + _loc7_;
               this.getCurrentSlotMachineContainer().setText(this.xpScaledValue.toString());
            }
            else if(param2 == "Award_Cash")
            {
               this.getCurrentSlotMachineContainer().setText(param1.rewardCash.toString());
            }
            else
            {
               this.getCurrentSlotMachineContainer().setText(param1.rewardCoin.toString());
            }
         }
         else
         {
            (this.getCurrentSlotMachineContainer() as SlotMachineAwardItemContainer).setItem(param3.icon);
            this.getCurrentSlotMachineContainer().setText(param4.toString());
         }
      }
      
      public function getCurrentSlotMachineContainer() : SlotMachineAwardContainer
      {
         return getCurrentContainer() as SlotMachineAwardContainer;
      }
   }
}

