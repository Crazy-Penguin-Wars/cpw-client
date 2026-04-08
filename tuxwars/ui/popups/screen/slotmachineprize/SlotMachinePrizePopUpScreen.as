package tuxwars.ui.popups.screen.slotmachineprize
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.slotmachine.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.*;
   
   public class SlotMachinePrizePopUpScreen extends PopUpBaseScreen
   {
      public static const TABLE:String = "SlotWin";
      
      private static const TITLE:String = "Title";
      
      private static const PICTURE:String = "Picture";
      
      private const _winslots:Array;
      
      private const SLOTMACHINE_PRIZES:String = "popup_prizes";
      
      private var buttonClose:UIButton;
      
      private var buttonOkay:UIButton;
      
      private var loader:URLResourceLoader;
      
      private var priceInfo1:UIAutoTextField;
      
      private var spins:UIAutoTextField;
      
      public function SlotMachinePrizePopUpScreen(param1:TuxWarsGame)
      {
         var _loc4_:* = undefined;
         var _loc5_:UIAutoTextField = null;
         var _loc6_:UIAutoTextField = null;
         var _loc7_:UIAutoTextField = null;
         var _loc8_:UIAutoTextField = null;
         var _loc9_:UIAutoTextField = null;
         var _loc10_:UIAutoTextField = null;
         var _loc11_:UIAutoTextField = null;
         var _loc12_:UIAutoTextField = null;
         var _loc13_:UIAutoTextField = null;
         var _loc14_:UIAutoTextField = null;
         var _loc15_:UIAutoTextField = null;
         var _loc16_:UIAutoTextField = null;
         this._winslots = [];
         super(param1,"flash/ui/slot_machine.swf","popup_prizes");
         headerField.setText("PRIZES");
         var _loc2_:String = "SlotWin";
         var _loc3_:* = ProjectManager.findTable(_loc2_);
         for each(_loc4_ in _loc3_._rows)
         {
            this._winslots.push(new SlotWinReference(_loc4_));
         }
         this._winslots.sort(this.sortWinByPriority);
         _loc5_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_01") as TextField,"" + (this._winslots[0] as SlotWinReference).rewardCash);
         _loc6_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_02") as TextField,"1");
         _loc7_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_03") as TextField,"1");
         _loc8_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_04") as TextField,"3");
         _loc9_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_05") as TextField,"3");
         _loc10_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_06") as TextField,"1");
         _loc11_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_07") as TextField,"" + (this._winslots[6] as SlotWinReference).rewardCoin);
         _loc12_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_08") as TextField,"" + (this._winslots[7] as SlotWinReference).rewardCoin);
         _loc13_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_09") as TextField,"" + (this._winslots[8] as SlotWinReference).rewardCoin);
         _loc14_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_10") as TextField,"" + this.scaleXP((this._winslots[9] as SlotWinReference).rewardXP));
         _loc15_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_11") as TextField,"" + this.scaleXP((this._winslots[10] as SlotWinReference).rewardXP));
         _loc16_ = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_12") as TextField,"" + this.scaleXP((this._winslots[11] as SlotWinReference).rewardXP));
      }
      
      private function scaleXP(param1:int) : int
      {
         var _loc12_:Row = null;
         var _loc2_:int = 0;
         var _loc3_:int = _game.player.level;
         var _loc4_:String = "SlotMachineConfiguration";
         var _loc5_:String = "Default";
         var _loc6_:* = ProjectManager.findTable(_loc4_);
         if(!_loc6_.getCache[_loc5_])
         {
            _loc12_ = DCUtils.find(_loc6_.rows,"id",_loc5_);
            if(!_loc12_)
            {
               LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc6_.name + "\'",_loc6_,3);
            }
            _loc6_.getCache[_loc5_] = _loc12_;
         }
         var _loc7_:String = "XPModifier";
         var _loc8_:* = _loc6_.getCache[_loc5_];
         if(!_loc8_.getCache[_loc7_])
         {
            _loc8_.getCache[_loc7_] = DCUtils.find(_loc8_.getFields(),"name",_loc7_);
         }
         var _loc9_:* = _loc8_.getCache[_loc7_];
         var _loc10_:Number = Number(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
         var _loc11_:* = param1;
         return int(_loc3_ * (_loc3_ * (Math.log(_loc3_) * (_loc10_ * _loc11_))) + _loc11_);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         if(param1)
         {
            messageField.setText(param1.code + "\n" + param1.description);
         }
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function sortWinByPriority(param1:SlotWinReference, param2:SlotWinReference) : int
      {
         if(param1.sortOrder == param2.sortOrder)
         {
            return 0;
         }
         if(param1.sortOrder < param2.sortOrder)
         {
            return -1;
         }
         return 1;
      }
   }
}

