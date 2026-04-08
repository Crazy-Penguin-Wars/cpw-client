package tuxwars.ui.containers.shop.container.settag
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.SetReference;
   import tuxwars.ui.containers.shop.container.Container;
   import tuxwars.utils.*;
   
   public class SetTagContainer extends Container
   {
      private var _setText:UIAutoTextField;
      
      private var _atkText:UIAutoTextField;
      
      private var _defText:UIAutoTextField;
      
      private var _lckText:UIAutoTextField;
      
      private var _atkValue:UIAutoTextField;
      
      private var _defValue:UIAutoTextField;
      
      private var _lckValue:UIAutoTextField;
      
      public function SetTagContainer(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param2,param3,param4);
         this._setText = TuxUiUtils.createAutoTextField(param1.Text_Set,"COMPLETE_SET_BONUS");
         this._atkText = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Attack_Bonus,ProjectManager.getText("ATK"));
         this._defText = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Defense_Bonus,ProjectManager.getText("DEF"));
         this._lckText = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Luck_Bonus,ProjectManager.getText("LCK"));
         this._atkValue = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Attack_Bonus_Stat,this.getBonusStat("Attack",param2));
         this._defValue = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Defense_Bonus_Stat,this.getBonusStat("Defence",param2));
         this._lckValue = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Luck_Bonus_Stat,this.getBonusStat("Luck",param2));
      }
      
      private function getBonusStat(param1:String, param2:SetReference) : String
      {
         var _loc3_:int = 0;
         var _loc4_:String = "0";
         if(param2 && param2.statBonuses && Boolean(param2.statBonuses.getStat(param1)))
         {
            _loc3_ = param2.statBonuses.getStat(param1).calculateRoundedValue();
            _loc4_ = _loc3_.toString();
            if(_loc3_ > 0)
            {
               _loc4_ = "+" + _loc3_.toString();
            }
         }
         return _loc4_;
      }
      
      protected function getSetDescription(param1:SetReference) : String
      {
         var _loc2_:String = "";
         if(Boolean(param1) && Boolean(param1.statBonusDescTextOverride))
         {
            _loc2_ = param1.statBonusDescTextOverride;
         }
         return _loc2_;
      }
      
      public function updateSetBonusText(param1:Boolean, param2:Boolean, param3:SetReference) : void
      {
         this._atkValue.setText(this.getBonusStat("Attack",param3));
         this._defValue.setText(this.getBonusStat("Defence",param3));
         this._lckValue.setText(this.getBonusStat("Luck",param3));
      }
      
      override public function dispose() : void
      {
         this._setText = null;
         this._atkText = null;
         this._defText = null;
         this._lckText = null;
         this._atkValue = null;
         this._defValue = null;
         this._lckValue = null;
         super.dispose();
      }
   }
}

