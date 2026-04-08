package tuxwars.ui.tooltips
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.*;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.utils.*;
   
   public class TooltipContainerClothing extends TooltipContainer
   {
      private var _attack:UIAutoTextField;
      
      private var _defence:UIAutoTextField;
      
      private var _luck:UIAutoTextField;
      
      private var _attackText:UIAutoTextField;
      
      private var _defenceText:UIAutoTextField;
      
      private var _luckText:UIAutoTextField;
      
      private var _contentSetTag:ContentSetTag;
      
      public function TooltipContainerClothing(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param2,param3,param4);
         this._attack = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Stats_Default.Text_Attack_Stat,this.getStat("Attack",shopItem));
         this._defence = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Stats_Default.Text_Defense_Stat,this.getStat("Defence",shopItem));
         this._luck = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Stats_Default.Text_Luck_Stat,this.getStat("Luck",shopItem));
         this._attackText = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Stats_Default.Text_Attack,ProjectManager.getText("ATTACK") + ":");
         this._defenceText = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Stats_Default.Text_Defense,ProjectManager.getText("DEFENCE") + ":");
         this._luckText = TuxUiUtils.createAutoTextFieldWithText(param1.Content.Stats_Default.Text_Luck,ProjectManager.getText("LUCK") + ":");
         if(param1.Content.Tag_Set)
         {
            this._contentSetTag = new ContentSetTag(param1.Content.Tag_Set,Boolean(shopItem) && shopItem.itemData is ClothingData ? (shopItem.itemData as ClothingData).setReference : null,param3);
            this._contentSetTag.updateSetBonusText(true,true,shopItem.itemData is ClothingData ? (shopItem.itemData as ClothingData).setReference : null);
         }
      }
      
      private function getStat(param1:String, param2:ShopItem) : String
      {
         var _loc3_:int = 0;
         var _loc4_:String = "0";
         if(param2 && param2.itemData && param2.itemData.statBonuses && Boolean(param2.itemData.statBonuses.getStat(param1)))
         {
            _loc3_ = param2.itemData.statBonuses.getStat(param1).calculateRoundedValue();
            _loc4_ = _loc3_.toString();
            if(_loc3_ > 0)
            {
               _loc4_ = "+" + _loc3_.toString();
            }
         }
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         this._attack = null;
         this._defence = null;
         this._luck = null;
         if(this._contentSetTag)
         {
            this._contentSetTag.dispose();
         }
         this._contentSetTag = null;
         super.dispose();
      }
   }
}

