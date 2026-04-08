package tuxwars.ui.containers.shop.container.settag
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.SetReference;
   import tuxwars.utils.*;
   
   public class SetTagBonusTextContainer extends SetTagContainer
   {
      private var _setDesc:UIAutoTextField;
      
      public function SetTagBonusTextContainer(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param2,param3,param4);
         this._setDesc = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Bonus,getSetDescription(param2));
      }
      
      override public function updateSetBonusText(param1:Boolean, param2:Boolean, param3:SetReference) : void
      {
         super.updateSetBonusText(param1,param2,param3);
         this._setDesc.setText(getSetDescription(param3));
      }
      
      override public function dispose() : void
      {
         this._setDesc = null;
         super.dispose();
      }
   }
}

