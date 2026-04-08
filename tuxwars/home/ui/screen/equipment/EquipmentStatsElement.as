package tuxwars.home.ui.screen.equipment
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.*;
   import tuxwars.items.data.SetReference;
   import tuxwars.items.managers.*;
   import tuxwars.net.messages.WornItemsUpdatedMessage;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class EquipmentStatsElement extends TuxUIElementScreen
   {
      private static var tuxGame:TuxWarsGame;
      
      private static const SET_TAG:String = "Set_Tag";
      
      private static const TEXT_SET:String = "Text_Set";
      
      private static const TEXT_SET_BONUS:String = "Text_Bonus";
      
      private static const ATTACK:String = "Text_Attack";
      
      private static const DEFENCE:String = "Text_Defense";
      
      private static const LUCK:String = "Text_Luck";
      
      private static const STAT:String = "_Stat";
      
      private static const MODIFIER:String = "_Modifier";
      
      private static const NEGATIVE:String = "_Negative";
      
      private static const POSITIVE:String = "_Positive";
      
      private var attack:UIAutoTextField;
      
      private var attackStat:UIAutoTextField;
      
      private var attackStatModifierPositive:UIAutoTextField;
      
      private var attackStatModifierNegative:UIAutoTextField;
      
      private var defence:UIAutoTextField;
      
      private var defenceStat:UIAutoTextField;
      
      private var defenceStatModifierPositive:UIAutoTextField;
      
      private var defenceStatModifierNegative:UIAutoTextField;
      
      private var luck:UIAutoTextField;
      
      private var luckStat:UIAutoTextField;
      
      private var luckStatModifierPositive:UIAutoTextField;
      
      private var luckStatModifierNegative:UIAutoTextField;
      
      private var _isSetStats:Boolean;
      
      private var _setContent:ContentSetTag;
      
      public function EquipmentStatsElement(param1:MovieClip, param2:TuxWarsGame, param3:Boolean)
      {
         super(param1,param2);
         this.attack = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Attack") as TextField,ProjectManager.getText("Attack") + ":");
         var _loc4_:int = param2.player.wornItemsContainer.getWornItemsStats().getStat("Attack").calculateRoundedValue();
         this.attackStat = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Attack" + "_Stat") as TextField,_loc4_.toString());
         this.attackStatModifierPositive = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Attack" + "_Modifier" + "_Positive") as TextField,this.getModifierString(0));
         this.attackStatModifierNegative = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Attack" + "_Modifier" + "_Negative") as TextField,this.getModifierString(0));
         this.defence = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Defense") as TextField,ProjectManager.getText("Defence") + ":");
         _loc4_ = param2.player.wornItemsContainer.getWornItemsStats().getStat("Defence").calculateRoundedValue();
         this.defenceStat = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Defense" + "_Stat") as TextField,_loc4_.toString());
         this.defenceStatModifierPositive = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Defense" + "_Modifier" + "_Positive") as TextField,this.getModifierString(0));
         this.defenceStatModifierNegative = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Defense" + "_Modifier" + "_Negative") as TextField,this.getModifierString(0));
         this.luck = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Luck") as TextField,ProjectManager.getText("Luck") + ":");
         _loc4_ = param2.player.wornItemsContainer.getWornItemsStats().getStat("Luck").calculateRoundedValue();
         this.luckStat = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Luck" + "_Stat") as TextField,_loc4_.toString());
         this.luckStatModifierPositive = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Luck" + "_Modifier" + "_Positive") as TextField,this.getModifierString(0));
         this.luckStatModifierNegative = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Luck" + "_Modifier" + "_Negative") as TextField,this.getModifierString(0));
         MessageCenter.addListener("WornItemsUpdated",this.updateStats);
         MessageCenter.addListener("ItemDetails",this.updateStatsModifiers);
         this.attack.getTextField().mouseEnabled = true;
         this.attack.getTextField().addEventListener("mouseOut",this.mouseOut,false,0,true);
         this.attack.getTextField().addEventListener("mouseOver",this.mouseOver,false,0,true);
         this.defence.getTextField().mouseEnabled = true;
         this.defence.getTextField().addEventListener("mouseOut",this.mouseOut,false,0,true);
         this.defence.getTextField().addEventListener("mouseOver",this.mouseOver,false,0,true);
         this.luck.getTextField().mouseEnabled = true;
         this.luck.getTextField().addEventListener("mouseOut",this.mouseOut,false,0,true);
         this.luck.getTextField().addEventListener("mouseOver",this.mouseOver,false,0,true);
         this._isSetStats = param3;
         if(param1.getChildByName("Set_Tag"))
         {
            this._setContent = new ContentSetTag(param1.getChildByName("Set_Tag") as MovieClip,!!param2.player.wornItemsContainer.getWornItemInSlot("Torso") ? param2.player.wornItemsContainer.getWornItemInSlot("Torso").setReference : null,param2);
            this._setContent.updateSetBonusText(param3,param2.player.wornItemsContainer.hasSet(),!!param2.player.wornItemsContainer.getWornItemInSlot("Torso") ? param2.player.wornItemsContainer.getWornItemInSlot("Torso").setReference : null);
         }
         this.updateStatsModifiersTexts(null,null);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("WornItemsUpdated",this.updateStats);
         MessageCenter.removeListener("ItemDetails",this.updateStatsModifiers);
         this.attack.getTextField().removeEventListener("mouseOut",this.mouseOut);
         this.attack.getTextField().removeEventListener("mouseOver",this.mouseOver);
         this.defence.getTextField().removeEventListener("mouseOut",this.mouseOut);
         this.defence.getTextField().removeEventListener("mouseOver",this.mouseOver);
         this.luck.getTextField().removeEventListener("mouseOut",this.mouseOut);
         this.luck.getTextField().removeEventListener("mouseOver",this.mouseOver);
         TooltipManager.removeTooltip();
         super.dispose();
      }
      
      private function updateStats(param1:WornItemsUpdatedMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.wearEvent == "ItemUnWear" || param1.wearEvent == "ItemWear")
         {
            this.fetchTuxGame();
            if(tuxGame.player.id == param1.player.id)
            {
               _loc2_ = game.player.wornItemsContainer.getWornItemsStats().getStat("Attack").calculateRoundedValue();
               this.attackStat.setText(_loc2_.toString());
               _loc3_ = game.player.wornItemsContainer.getWornItemsStats().getStat("Defence").calculateRoundedValue();
               this.defenceStat.setText(_loc3_.toString());
               _loc4_ = game.player.wornItemsContainer.getWornItemsStats().getStat("Luck").calculateRoundedValue();
               this.luckStat.setText(_loc4_.toString());
               this.updateStatsModifiersTexts(null,null);
            }
         }
      }
      
      private function updateStatsModifiers(param1:Message) : void
      {
         var _loc2_:ClothingItem = null;
         var _loc3_:ClothingItem = null;
         if(param1.data != null)
         {
            _loc2_ = game.player.inventory.getItem((param1.data as ShopItem).id) as ClothingItem;
            if(_loc2_ == null)
            {
               _loc2_ = ItemManager.createItem((param1.data as ShopItem).id) as ClothingItem;
            }
            if(_loc2_ != null)
            {
               _loc3_ = game.player.wornItemsContainer.getWornItems()[_loc2_.slot] as ClothingItem;
            }
            this.updateStatsModifiersTexts(_loc3_,_loc2_);
         }
         else
         {
            this.updateStatsModifiersTexts(null,null);
         }
      }
      
      private function updateStatsModifiersTexts(param1:ClothingItem, param2:ClothingItem) : void
      {
         var _loc3_:SetReference = null;
         var _loc4_:SetReference = null;
         var _loc5_:Boolean = false;
         var _loc6_:Stats = null;
         var _loc7_:Stats = null;
         var _loc8_:Boolean = Boolean(param2) && (game.player.wornItemsContainer.hasSet(param2) || param2.setReference == null);
         if(!param2 && !_loc8_)
         {
            _loc8_ = game.player.wornItemsContainer.hasSet();
            if(this._setContent)
            {
               this._setContent.updateSetBonusText(this._isSetStats,_loc8_,!!game.player.wornItemsContainer.getWornItemInSlot("Torso") ? game.player.wornItemsContainer.getWornItemInSlot("Torso").setReference : null);
            }
         }
         else if(this._setContent)
         {
            this._setContent.updateSetBonusText(this._isSetStats,_loc8_,!!param2 ? param2.setReference : null);
         }
         setVisible(!!this._isSetStats ? _loc8_ : !_loc8_);
         if(param2 && param2.setReference && game.player.wornItemsContainer.hasSet(param2))
         {
            if(param2.slot == "Torso")
            {
               _loc3_ = game.player.wornItemsContainer.getWornItemInSlot("Head").setReference;
            }
            else
            {
               _loc3_ = game.player.wornItemsContainer.getWornItemInSlot("Torso").setReference;
            }
         }
         if(param1 && param2.setReference && game.player.wornItemsContainer.hasSet())
         {
            _loc4_ = game.player.wornItemsContainer.getWornItemInSlot("Torso").setReference;
         }
         if(_loc3_)
         {
            _loc5_ = true;
         }
         else if(_loc4_)
         {
            _loc5_ = false;
         }
         if(Boolean(_loc4_) && Boolean(_loc3_))
         {
            if(_loc4_.id == _loc3_.id)
            {
               if(param2.id == param1.id)
               {
                  _loc3_ = null;
                  _loc5_ = false;
               }
               else
               {
                  _loc4_ = null;
                  _loc3_ = null;
                  _loc5_ = false;
               }
            }
            else
            {
               LogUtils.log("Impossible to change from one set to an other with one item (" + _loc4_.id + " to " + _loc3_.id + ")",this,3,"Items",true,true,true);
            }
         }
         if(_loc3_)
         {
            _loc6_ = _loc3_.statBonuses;
         }
         if(_loc4_)
         {
            _loc7_ = _loc4_.statBonuses;
         }
         if(param1 == null && param2 != null)
         {
            this.setModifierTexts(this.attackStatModifierPositive,this.attackStatModifierNegative,param2,null,_loc5_,!!_loc6_ ? _loc6_ : _loc7_,"Attack");
            this.setModifierTexts(this.defenceStatModifierPositive,this.defenceStatModifierNegative,param2,null,_loc5_,!!_loc6_ ? _loc6_ : _loc7_,"Defence");
            this.setModifierTexts(this.luckStatModifierPositive,this.luckStatModifierNegative,param2,null,_loc5_,!!_loc6_ ? _loc6_ : _loc7_,"Luck");
         }
         else if(param1 != null && param2 != null)
         {
            this.setModifierTexts(this.attackStatModifierPositive,this.attackStatModifierNegative,param2,param1,_loc5_,!!_loc6_ ? _loc6_ : _loc7_,"Attack");
            this.setModifierTexts(this.defenceStatModifierPositive,this.defenceStatModifierNegative,param2,param1,_loc5_,!!_loc6_ ? _loc6_ : _loc7_,"Defence");
            this.setModifierTexts(this.luckStatModifierPositive,this.luckStatModifierNegative,param2,param1,_loc5_,!!_loc6_ ? _loc6_ : _loc7_,"Luck");
         }
         else
         {
            this.setModifierTexts(this.attackStatModifierPositive,this.attackStatModifierNegative,null,null,_loc5_,null,"Attack");
            this.setModifierTexts(this.defenceStatModifierPositive,this.defenceStatModifierNegative,null,null,_loc5_,null,"Defence");
            this.setModifierTexts(this.luckStatModifierPositive,this.luckStatModifierNegative,null,null,_loc5_,null,"Luck");
         }
      }
      
      private function getPercentageValue(param1:String, param2:int, param3:Stat) : int
      {
         var _loc4_:int = game.player.wornItemsContainer.getWornItemsStats().getStat(param1).calculateRoundedValue();
         var _loc5_:Number = param3.calculateValue() - 1;
         if(param2 > 0)
         {
            return param2 * (_loc4_ * _loc5_);
         }
         return param2 * (_loc4_ - _loc4_ / (1 + _loc5_));
      }
      
      private function getModifierValue(param1:String, param2:int, param3:Stat, param4:Stat) : int
      {
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         if(param4 == null)
         {
            if(param3.isPercentage())
            {
               return this.getPercentageValue(param1,param2,param3);
            }
            return param2 * param3.calculateRoundedValue();
         }
         if(param3.isPercentage())
         {
            _loc6_ = Number(this.getPercentageValue(param1,param2,param3));
         }
         else
         {
            _loc6_ = param3.calculateRoundedValue();
         }
         if(param4.isPercentage())
         {
            _loc7_ = Number(this.getPercentageValue(param1,param2,param4));
         }
         else
         {
            _loc7_ = param4.calculateRoundedValue();
         }
         return param2 * _loc6_ - _loc7_;
      }
      
      private function setModifierTexts(param1:UIAutoTextField, param2:UIAutoTextField, param3:ClothingItem, param4:ClothingItem, param5:Boolean, param6:Stats, param7:String) : void
      {
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Stat = null;
         var _loc11_:Stat = !!param3 ? param3.getStatBonus(param7) : null;
         var _loc12_:Stat = !!param4 ? param4.getStatBonus(param7) : null;
         if(_loc11_ == null && _loc12_ == null)
         {
            _loc8_ = 0;
         }
         else if(Boolean(_loc11_) && Boolean(_loc12_))
         {
            if(_loc11_ == _loc12_)
            {
               _loc8_ = int(this.getModifierValue(param7,-1,_loc11_,null));
            }
            else
            {
               _loc8_ = int(this.getModifierValue(param7,1,_loc11_,_loc12_));
            }
         }
         else if(_loc11_)
         {
            _loc8_ = int(this.getModifierValue(param7,1,_loc11_,null));
         }
         else
         {
            _loc8_ = int(this.getModifierValue(param7,-1,_loc12_,null));
         }
         if(param6)
         {
            _loc10_ = param6.getStat(param7);
            if(_loc10_)
            {
               _loc8_ += this.getModifierValue(param7,param5 ? 1 : -1,_loc10_,null);
            }
         }
         _loc9_ = _loc8_.toString();
         param1.setText("+" + _loc9_);
         param2.setText(_loc9_);
         if(_loc8_ > 0)
         {
            param1.setVisible(true);
            param2.setVisible(false);
         }
         else if(_loc8_ < 0)
         {
            param1.setVisible(false);
            param2.setVisible(true);
         }
         else
         {
            param1.setVisible(false);
            param2.setVisible(false);
         }
      }
      
      private function getModifierString(param1:int) : String
      {
         if(param1 > 0)
         {
            return "+" + param1.toString();
         }
         if(param1 < 0)
         {
            return param1.toString();
         }
         return "";
      }
      
      private function fetchTuxGame() : void
      {
         if(!tuxGame)
         {
            MessageCenter.addListener("SendGame",this.sendGameHandler);
            MessageCenter.sendMessage("GetGame");
         }
      }
      
      private function sendGameHandler(param1:Message) : void
      {
         MessageCenter.removeListener("SendGame",this.sendGameHandler);
         tuxGame = param1.data;
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         var _loc3_:GenericTooltip = new GenericTooltip(this.getTooltipTid(_loc2_));
         TooltipManager.showTooltip(_loc3_,_loc2_);
         _loc3_.setX(_loc3_.getX() + _loc2_.width * 0.5);
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      private function getTooltipTid(param1:TextField) : String
      {
         switch(param1.name)
         {
            case "Text_Attack":
               return "TOOLTIP_ATTACK";
            case "Text_Defense":
               return "TOOLTIP_DEFENCE";
            case "Text_Luck":
               return "TOOLTIP_LUCK";
            default:
               return null;
         }
      }
   }
}

