package tuxwars.ui.containers.shop.container.settag
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.SetReference;
   import tuxwars.utils.TuxUiUtils;
   
   public class SetTagBonusTextContainer extends SetTagContainer
   {
       
      
      private var _setDesc:UIAutoTextField;
      
      public function SetTagBonusTextContainer(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,data,game,parent);
         _setDesc = TuxUiUtils.createAutoTextFieldWithText(design.Text_Bonus,getSetDescription(data));
      }
      
      override public function updateSetBonusText(isSetStats:Boolean, hasSet:Boolean, setReference:SetReference) : void
      {
         super.updateSetBonusText(isSetStats,hasSet,setReference);
         _setDesc.setText(getSetDescription(setReference));
      }
      
      override public function dispose() : void
      {
         _setDesc = null;
         super.dispose();
      }
   }
}
