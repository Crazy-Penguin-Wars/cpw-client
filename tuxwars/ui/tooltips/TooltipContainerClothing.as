package tuxwars.ui.tooltips
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ClothingData;
   import tuxwars.ui.containers.shop.ContentSetTag;
   import tuxwars.utils.TuxUiUtils;
   
   public class TooltipContainerClothing extends TooltipContainer
   {
       
      
      private var _attack:UIAutoTextField;
      
      private var _defence:UIAutoTextField;
      
      private var _luck:UIAutoTextField;
      
      private var _attackText:UIAutoTextField;
      
      private var _defenceText:UIAutoTextField;
      
      private var _luckText:UIAutoTextField;
      
      private var _contentSetTag:ContentSetTag;
      
      public function TooltipContainerClothing(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,data,game,parent);
         _attack = TuxUiUtils.createAutoTextFieldWithText(design.Content.Stats_Default.Text_Attack_Stat,getStat("Attack",shopItem));
         _defence = TuxUiUtils.createAutoTextFieldWithText(design.Content.Stats_Default.Text_Defense_Stat,getStat("Defence",shopItem));
         _luck = TuxUiUtils.createAutoTextFieldWithText(design.Content.Stats_Default.Text_Luck_Stat,getStat("Luck",shopItem));
         _attackText = TuxUiUtils.createAutoTextFieldWithText(design.Content.Stats_Default.Text_Attack,ProjectManager.getText("ATTACK") + ":");
         _defenceText = TuxUiUtils.createAutoTextFieldWithText(design.Content.Stats_Default.Text_Defense,ProjectManager.getText("DEFENCE") + ":");
         _luckText = TuxUiUtils.createAutoTextFieldWithText(design.Content.Stats_Default.Text_Luck,ProjectManager.getText("LUCK") + ":");
         if(design.Content.Tag_Set)
         {
            _contentSetTag = new ContentSetTag(design.Content.Tag_Set,shopItem && shopItem.itemData is ClothingData ? (shopItem.itemData as ClothingData).setReference : null,game);
            _contentSetTag.updateSetBonusText(true,true,shopItem.itemData is ClothingData ? (shopItem.itemData as ClothingData).setReference : null);
         }
      }
      
      private function getStat(statName:String, item:ShopItem) : String
      {
         var value:int = 0;
         var returnStatValue:String = "0";
         if(item && item.itemData && item.itemData.statBonuses && item.itemData.statBonuses.getStat(statName))
         {
            value = item.itemData.statBonuses.getStat(statName).calculateRoundedValue();
            returnStatValue = value.toString();
            if(value > 0)
            {
               returnStatValue = "+" + value.toString();
            }
         }
         return returnStatValue;
      }
      
      override public function dispose() : void
      {
         _attack = null;
         _defence = null;
         _luck = null;
         if(_contentSetTag)
         {
            _contentSetTag.dispose();
         }
         _contentSetTag = null;
         super.dispose();
      }
   }
}
