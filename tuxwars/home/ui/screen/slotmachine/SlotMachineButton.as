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
      
      public function SlotMachineButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
      }
      
      public static function getFreeDailySpins(player:Player) : int
      {
         var _loc7_:String = "SlotMachineConfiguration";
         var _loc3_:ProjectManager = ProjectManager;
         var _loc8_:String = "Default";
         var _loc4_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc7_);
         if(!_loc4_._cache[_loc8_])
         {
            var _loc9_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc8_);
            if(!_loc9_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc8_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc8_] = _loc9_;
         }
         var _loc10_:String = "MaxDailySlotMachinePlays";
         var _loc5_:* = _loc4_._cache[_loc8_];
         if(!_loc5_._cache[_loc10_])
         {
            _loc5_._cache[_loc10_] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name",_loc10_);
         }
         var _loc6_:* = _loc5_._cache[_loc10_];
         var _loc2_:int = int(_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value);
         return _loc2_ - player.slotMachineSpinsUsed;
      }
      
      public function init(player:Player) : void
      {
         setText(ProjectManager.getText("BUTTON_FREE_SPINS",[getFreeDailySpins(player)]));
      }
   }
}

