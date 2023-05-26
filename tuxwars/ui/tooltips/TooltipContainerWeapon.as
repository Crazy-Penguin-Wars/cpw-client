package tuxwars.ui.tooltips
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.progress.UIProgressIndicator;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.utils.TuxUiUtils;
   
   public class TooltipContainerWeapon extends TooltipContainer
   {
       
      
      private var _textPower:UIAutoTextField;
      
      private var _textSkill:UIAutoTextField;
      
      private var _sliderPower:UIProgressIndicator;
      
      private var _sliderSkill:UIProgressIndicator;
      
      public function TooltipContainerWeapon(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,data,game,parent);
         _sliderPower = new UIProgressIndicator(design.Content.Slider_Power_Avg,0,100);
         _sliderPower.setValueWithoutBarAnimation(shopItem.tooltipPower);
         _textPower = TuxUiUtils.createAutoTextField(design.Content.Text_Avg_Power,"TID_TOOLTIP_POWER");
         _textPower = TuxUiUtils.createAutoTextFieldWithText(design.Content.Text_Avg_Power_Value,shopItem.tooltipPowerWord);
         _sliderSkill = new UIProgressIndicator(design.Content.Slider_Power_Max,0,100);
         _sliderSkill.setValueWithoutBarAnimation(shopItem.tooltipSkill);
         _textSkill = TuxUiUtils.createAutoTextField(design.Content.Text_Max_Power,"TID_TOOLTIP_SKILL");
         _textSkill = TuxUiUtils.createAutoTextFieldWithText(design.Content.Text_Max_Power_Value,shopItem.tooltipSkillWord);
      }
   }
}
