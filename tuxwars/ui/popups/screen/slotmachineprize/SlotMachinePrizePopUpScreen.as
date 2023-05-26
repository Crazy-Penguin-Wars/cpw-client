package tuxwars.ui.popups.screen.slotmachineprize
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.slotmachine.SlotWinReference;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class SlotMachinePrizePopUpScreen extends PopUpBaseScreen
   {
      
      public static const TABLE:String = "SlotWin";
      
      private static const TITLE:String = "Title";
      
      private static const PICTURE:String = "Picture";
       
      
      private const _winslots:Array = [];
      
      private const SLOTMACHINE_PRIZES:String = "popup_prizes";
      
      private var buttonClose:UIButton;
      
      private var buttonOkay:UIButton;
      
      private var loader:URLResourceLoader;
      
      private var priceInfo1:UIAutoTextField;
      
      private var spins:UIAutoTextField;
      
      public function SlotMachinePrizePopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/slot_machine.swf","popup_prizes");
         headerField.setText("PRIZES");
         var _loc15_:ProjectManager = ProjectManager;
         var _loc16_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotWin");
         for each(var row in _loc16_._rows)
         {
            _winslots.push(new SlotWinReference(row));
         }
         _winslots.sort(sortWinByPriority);
         var priceInfo12:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_01") as TextField,"" + (_winslots[0] as SlotWinReference).rewardCash);
         var priceInfo11:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_02") as TextField,"1");
         var priceInfo10:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_03") as TextField,"1");
         var priceInfo9:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_04") as TextField,"3");
         var priceInfo8:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_05") as TextField,"3");
         var priceInfo7:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_06") as TextField,"1");
         var priceInfo6:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_07") as TextField,"" + (_winslots[6] as SlotWinReference).rewardCoin);
         var priceInfo5:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_08") as TextField,"" + (_winslots[7] as SlotWinReference).rewardCoin);
         var priceInfo4:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_09") as TextField,"" + (_winslots[8] as SlotWinReference).rewardCoin);
         var priceInfo3:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_10") as TextField,"" + scaleXP((_winslots[9] as SlotWinReference).rewardXP));
         var priceInfo2:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_11") as TextField,"" + scaleXP((_winslots[10] as SlotWinReference).rewardXP));
         var priceInfo1:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText((this._design as MovieClip).getChildByName("Text_12") as TextField,"" + scaleXP((_winslots[11] as SlotWinReference).rewardXP));
      }
      
      private function scaleXP(value:int) : int
      {
         var xpScaledValue:int = 0;
         var level:int = _game.player.level;
         var _loc6_:ProjectManager = ProjectManager;
         var _loc7_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachineConfiguration");
         if(!_loc7_._cache["Default"])
         {
            var _loc12_:Row = com.dchoc.utils.DCUtils.find(_loc7_.rows,"id","Default");
            if(!_loc12_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc7_.name + "\'",_loc7_,3);
            }
            _loc7_._cache["Default"] = _loc12_;
         }
         var _loc8_:* = _loc7_._cache["Default"];
         if(!_loc8_._cache["XPModifier"])
         {
            _loc8_._cache["XPModifier"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","XPModifier");
         }
         var _loc9_:* = _loc8_._cache["XPModifier"];
         var modifier:Number = Number(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value);
         var baseValue:* = value;
         return level * (level * (Math.log(level) * (modifier * baseValue))) + baseValue;
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         if(params)
         {
            messageField.setText(params.code + "\n" + params.description);
         }
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function sortWinByPriority(a:SlotWinReference, b:SlotWinReference) : int
      {
         if(a.sortOrder == b.sortOrder)
         {
            return 0;
         }
         if(a.sortOrder < b.sortOrder)
         {
            return -1;
         }
         return 1;
      }
   }
}
