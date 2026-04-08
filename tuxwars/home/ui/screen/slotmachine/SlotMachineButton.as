package tuxwars.home.ui.screen.slotmachine
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import tuxwars.player.Player;
   
   public class SlotMachineButton extends UIButton
   {
      private var freeSpins:UIAutoTextField;
      
      public function SlotMachineButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public static function getFreeDailySpins(param1:Player) : int
      {
         var _loc9_:Row = null;
         var _loc2_:String = "SlotMachineConfiguration";
         var _loc3_:String = "Default";
         var _loc4_:* = ProjectManager.findTable(_loc2_);
         if(!_loc4_.getCache[_loc3_])
         {
            _loc9_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc9_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc9_;
         }
         var _loc5_:String = "MaxDailySlotMachinePlays";
         var _loc6_:* = _loc4_.getCache[_loc3_];
         if(!_loc6_.getCache[_loc5_])
         {
            _loc6_.getCache[_loc5_] = DCUtils.find(_loc6_.getFields(),"name",_loc5_);
         }
         var _loc7_:* = _loc6_.getCache[_loc5_];
         var _loc8_:int = int(_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value);
         return _loc8_ - param1.slotMachineSpinsUsed;
      }
      
      public function init(param1:Player) : void
      {
         setText(ProjectManager.getText("BUTTON_FREE_SPINS",[getFreeDailySpins(param1)]));
      }
   }
}

