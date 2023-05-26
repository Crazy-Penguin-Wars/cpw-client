package tuxwars.ui.containers.shop.container.settag
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.SetReference;
   import tuxwars.ui.containers.shop.container.Container;
   import tuxwars.utils.TuxUiUtils;
   
   public class SetTagContainer extends Container
   {
       
      
      private var _setText:UIAutoTextField;
      
      private var _atkText:UIAutoTextField;
      
      private var _defText:UIAutoTextField;
      
      private var _lckText:UIAutoTextField;
      
      private var _atkValue:UIAutoTextField;
      
      private var _defValue:UIAutoTextField;
      
      private var _lckValue:UIAutoTextField;
      
      public function SetTagContainer(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,data,game,parent);
         _setText = TuxUiUtils.createAutoTextField(design.Text_Set,"COMPLETE_SET_BONUS");
         _atkText = TuxUiUtils.createAutoTextFieldWithText(design.Text_Attack_Bonus,ProjectManager.getText("ATK"));
         _defText = TuxUiUtils.createAutoTextFieldWithText(design.Text_Defense_Bonus,ProjectManager.getText("DEF"));
         _lckText = TuxUiUtils.createAutoTextFieldWithText(design.Text_Luck_Bonus,ProjectManager.getText("LCK"));
         _atkValue = TuxUiUtils.createAutoTextFieldWithText(design.Text_Attack_Bonus_Stat,getBonusStat("Attack",data));
         _defValue = TuxUiUtils.createAutoTextFieldWithText(design.Text_Defense_Bonus_Stat,getBonusStat("Defence",data));
         _lckValue = TuxUiUtils.createAutoTextFieldWithText(design.Text_Luck_Bonus_Stat,getBonusStat("Luck",data));
      }
      
      private function getBonusStat(statName:String, setReference:SetReference) : String
      {
         var _loc4_:int = 0;
         var returnStatValue:String = "0";
         if(setReference && setReference.statBonuses && setReference.statBonuses.getStat(statName))
         {
            _loc4_ = setReference.statBonuses.getStat(statName).calculateRoundedValue();
            returnStatValue = _loc4_.toString();
            if(_loc4_ > 0)
            {
               returnStatValue = "+" + _loc4_.toString();
            }
         }
         return returnStatValue;
      }
      
      protected function getSetDescription(setReference:SetReference) : String
      {
         var description:String = "";
         if(setReference && setReference.statBonusDescTextOverride)
         {
            description = setReference.statBonusDescTextOverride;
         }
         return description;
      }
      
      public function updateSetBonusText(isSetStats:Boolean, hasSet:Boolean, setReference:SetReference) : void
      {
         _atkValue.setText(getBonusStat("Attack",setReference));
         _defValue.setText(getBonusStat("Defence",setReference));
         _lckValue.setText(getBonusStat("Luck",setReference));
      }
      
      override public function dispose() : void
      {
         _setText = null;
         _atkText = null;
         _defText = null;
         _lckText = null;
         _atkValue = null;
         _defValue = null;
         _lckValue = null;
         super.dispose();
      }
   }
}
