package tuxwars.ui.tooltips
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.progress.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.utils.*;
   
   public class TooltipContainerWeapon extends TooltipContainer
   {
      private var _textPower:UIAutoTextField;
      
      private var _textSkill:UIAutoTextField;
      
      private var _sliderPower:UIProgressIndicator;
      
      private var _sliderSkill:UIProgressIndicator;
      
      public function TooltipContainerWeapon(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param2,param3,param4);
         this._sliderPower = new UIProgressIndicator(param1.Content.Slider_Power_Avg,0,100);
         this._sliderPower.setValueWithoutBarAnimation(shopItem.tooltipPower);
         this._textPower = TuxUiUtils.createAutoTextField(param1.Content.Text_Avg_Power,"TID_TOOLTIP_POWER");
         this._textPower = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Text_Avg_Power_Value,shopItem.tooltipPowerWord);
         this._sliderSkill = new UIProgressIndicator(param1.Content.Slider_Power_Max,0,100);
         this._sliderSkill.setValueWithoutBarAnimation(shopItem.tooltipSkill);
         this._textSkill = TuxUiUtils.createAutoTextField(param1.Content.Text_Max_Power,"TID_TOOLTIP_SKILL");
         this._textSkill = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Text_Max_Power_Value,shopItem.tooltipSkillWord);
      }
   }
}

