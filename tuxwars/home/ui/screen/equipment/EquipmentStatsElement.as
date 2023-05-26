package tuxwars.home.ui.screen.equipment
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.SetReference;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.net.messages.WornItemsUpdatedMessage;
   import tuxwars.ui.containers.shop.ContentSetTag;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class EquipmentStatsElement extends TuxUIElementScreen
   {
      
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
      
      private static var tuxGame:TuxWarsGame;
       
      
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
      
      public function EquipmentStatsElement(design:MovieClip, game:TuxWarsGame, isSetStats:Boolean)
      {
         super(design,game);
         attack = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Attack") as TextField,ProjectManager.getText("Attack") + ":");
         var stat:int = game.player.wornItemsContainer.getWornItemsStats().getStat("Attack").calculateRoundedValue();
         attackStat = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Attack" + "_Stat") as TextField,stat.toString());
         attackStatModifierPositive = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Attack" + "_Modifier" + "_Positive") as TextField,getModifierString(0));
         attackStatModifierNegative = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Attack" + "_Modifier" + "_Negative") as TextField,getModifierString(0));
         defence = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Defense") as TextField,ProjectManager.getText("Defence") + ":");
         stat = game.player.wornItemsContainer.getWornItemsStats().getStat("Defence").calculateRoundedValue();
         defenceStat = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Defense" + "_Stat") as TextField,stat.toString());
         defenceStatModifierPositive = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Defense" + "_Modifier" + "_Positive") as TextField,getModifierString(0));
         defenceStatModifierNegative = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Defense" + "_Modifier" + "_Negative") as TextField,getModifierString(0));
         luck = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Luck") as TextField,ProjectManager.getText("Luck") + ":");
         stat = game.player.wornItemsContainer.getWornItemsStats().getStat("Luck").calculateRoundedValue();
         luckStat = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Luck" + "_Stat") as TextField,stat.toString());
         luckStatModifierPositive = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Luck" + "_Modifier" + "_Positive") as TextField,getModifierString(0));
         luckStatModifierNegative = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Luck" + "_Modifier" + "_Negative") as TextField,getModifierString(0));
         MessageCenter.addListener("WornItemsUpdated",updateStats);
         MessageCenter.addListener("ItemDetails",updateStatsModifiers);
         attack.getTextField().mouseEnabled = true;
         attack.getTextField().addEventListener("mouseOut",mouseOut,false,0,true);
         attack.getTextField().addEventListener("mouseOver",mouseOver,false,0,true);
         defence.getTextField().mouseEnabled = true;
         defence.getTextField().addEventListener("mouseOut",mouseOut,false,0,true);
         defence.getTextField().addEventListener("mouseOver",mouseOver,false,0,true);
         luck.getTextField().mouseEnabled = true;
         luck.getTextField().addEventListener("mouseOut",mouseOut,false,0,true);
         luck.getTextField().addEventListener("mouseOver",mouseOver,false,0,true);
         _isSetStats = isSetStats;
         if(design.getChildByName("Set_Tag"))
         {
            _setContent = new ContentSetTag(design.getChildByName("Set_Tag") as MovieClip,!!game.player.wornItemsContainer.getWornItemInSlot("Torso") ? game.player.wornItemsContainer.getWornItemInSlot("Torso").setReference : null,game);
            _setContent.updateSetBonusText(isSetStats,game.player.wornItemsContainer.hasSet(),!!game.player.wornItemsContainer.getWornItemInSlot("Torso") ? game.player.wornItemsContainer.getWornItemInSlot("Torso").setReference : null);
         }
         updateStatsModifiersTexts(null,null);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("WornItemsUpdated",updateStats);
         MessageCenter.removeListener("ItemDetails",updateStatsModifiers);
         attack.getTextField().removeEventListener("mouseOut",mouseOut);
         attack.getTextField().removeEventListener("mouseOver",mouseOver);
         defence.getTextField().removeEventListener("mouseOut",mouseOut);
         defence.getTextField().removeEventListener("mouseOver",mouseOver);
         luck.getTextField().removeEventListener("mouseOut",mouseOut);
         luck.getTextField().removeEventListener("mouseOver",mouseOver);
         TooltipManager.removeTooltip();
         super.dispose();
      }
      
      private function updateStats(msg:WornItemsUpdatedMessage) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(msg.wearEvent == "ItemUnWear" || msg.wearEvent == "ItemWear")
         {
            fetchTuxGame();
            if(tuxGame.player.id == msg.player.id)
            {
               _loc3_ = game.player.wornItemsContainer.getWornItemsStats().getStat("Attack").calculateRoundedValue();
               attackStat.setText(_loc3_.toString());
               _loc2_ = game.player.wornItemsContainer.getWornItemsStats().getStat("Defence").calculateRoundedValue();
               defenceStat.setText(_loc2_.toString());
               _loc4_ = game.player.wornItemsContainer.getWornItemsStats().getStat("Luck").calculateRoundedValue();
               luckStat.setText(_loc4_.toString());
               updateStatsModifiersTexts(null,null);
            }
         }
      }
      
      private function updateStatsModifiers(msg:Message) : void
      {
         var newItem:* = null;
         var oldItem:* = null;
         if(msg.data != null)
         {
            newItem = game.player.inventory.getItem((msg.data as ShopItem).id) as ClothingItem;
            if(newItem == null)
            {
               newItem = ItemManager.createItem((msg.data as ShopItem).id) as ClothingItem;
            }
            if(newItem != null)
            {
               oldItem = game.player.wornItemsContainer.getWornItems()[newItem.slot] as ClothingItem;
            }
            updateStatsModifiersTexts(oldItem,newItem);
         }
         else
         {
            updateStatsModifiersTexts(null,null);
         }
      }
      
      private function updateStatsModifiersTexts(oldItem:ClothingItem, newItem:ClothingItem) : void
      {
         var newSetReference:* = null;
         var oldSetReference:* = null;
         var addSet:Boolean = false;
         var newSetStats:* = null;
         var oldSetStats:* = null;
         var show:Boolean = newItem && (game.player.wornItemsContainer.hasSet(newItem) || newItem.setReference == null);
         if(!newItem && !show)
         {
            show = game.player.wornItemsContainer.hasSet();
            if(_setContent)
            {
               _setContent.updateSetBonusText(_isSetStats,show,!!game.player.wornItemsContainer.getWornItemInSlot("Torso") ? game.player.wornItemsContainer.getWornItemInSlot("Torso").setReference : null);
            }
         }
         else if(_setContent)
         {
            _setContent.updateSetBonusText(_isSetStats,show,!!newItem ? newItem.setReference : null);
         }
         setVisible(_isSetStats ? show : !show);
         if(newItem && newItem.setReference && game.player.wornItemsContainer.hasSet(newItem))
         {
            if(newItem.slot == "Torso")
            {
               newSetReference = game.player.wornItemsContainer.getWornItemInSlot("Head").setReference;
            }
            else
            {
               newSetReference = game.player.wornItemsContainer.getWornItemInSlot("Torso").setReference;
            }
         }
         if(oldItem && newItem.setReference && game.player.wornItemsContainer.hasSet())
         {
            oldSetReference = game.player.wornItemsContainer.getWornItemInSlot("Torso").setReference;
         }
         if(newSetReference)
         {
            addSet = true;
         }
         else if(oldSetReference)
         {
            addSet = false;
         }
         if(oldSetReference && newSetReference)
         {
            if(oldSetReference.id == newSetReference.id)
            {
               if(newItem.id == oldItem.id)
               {
                  newSetReference = null;
                  addSet = false;
               }
               else
               {
                  oldSetReference = null;
                  newSetReference = null;
                  addSet = false;
               }
            }
            else
            {
               LogUtils.log("Impossible to change from one set to an other with one item (" + oldSetReference.id + " to " + newSetReference.id + ")",this,3,"Items",true,true,true);
            }
         }
         if(newSetReference)
         {
            newSetStats = newSetReference.statBonuses;
         }
         if(oldSetReference)
         {
            oldSetStats = oldSetReference.statBonuses;
         }
         if(oldItem == null && newItem != null)
         {
            setModifierTexts(attackStatModifierPositive,attackStatModifierNegative,newItem,null,addSet,!!newSetStats ? newSetStats : oldSetStats,"Attack");
            setModifierTexts(defenceStatModifierPositive,defenceStatModifierNegative,newItem,null,addSet,!!newSetStats ? newSetStats : oldSetStats,"Defence");
            setModifierTexts(luckStatModifierPositive,luckStatModifierNegative,newItem,null,addSet,!!newSetStats ? newSetStats : oldSetStats,"Luck");
         }
         else if(oldItem != null && newItem != null)
         {
            setModifierTexts(attackStatModifierPositive,attackStatModifierNegative,newItem,oldItem,addSet,!!newSetStats ? newSetStats : oldSetStats,"Attack");
            setModifierTexts(defenceStatModifierPositive,defenceStatModifierNegative,newItem,oldItem,addSet,!!newSetStats ? newSetStats : oldSetStats,"Defence");
            setModifierTexts(luckStatModifierPositive,luckStatModifierNegative,newItem,oldItem,addSet,!!newSetStats ? newSetStats : oldSetStats,"Luck");
         }
         else
         {
            setModifierTexts(attackStatModifierPositive,attackStatModifierNegative,null,null,addSet,null,"Attack");
            setModifierTexts(defenceStatModifierPositive,defenceStatModifierNegative,null,null,addSet,null,"Defence");
            setModifierTexts(luckStatModifierPositive,luckStatModifierNegative,null,null,addSet,null,"Luck");
         }
      }
      
      private function getPercentageValue(statName:String, sign:int, stat:Stat) : int
      {
         var originalStatValue:int = game.player.wornItemsContainer.getWornItemsStats().getStat(statName).calculateRoundedValue();
         var percentage:Number = stat.calculateValue() - 1;
         if(sign > 0)
         {
            return sign * (originalStatValue * percentage);
         }
         return sign * (originalStatValue - originalStatValue / (1 + percentage));
      }
      
      private function getModifierValue(statName:String, sign:int, firstStat:Stat, secondStat:Stat) : int
      {
         var secondPercentage:Number = NaN;
         var firstValue:Number = NaN;
         var secondValue:Number = NaN;
         if(secondStat == null)
         {
            if(firstStat.isPercentage())
            {
               return getPercentageValue(statName,sign,firstStat);
            }
            return sign * firstStat.calculateRoundedValue();
         }
         if(firstStat.isPercentage())
         {
            firstValue = getPercentageValue(statName,sign,firstStat);
         }
         else
         {
            firstValue = firstStat.calculateRoundedValue();
         }
         if(secondStat.isPercentage())
         {
            secondValue = getPercentageValue(statName,sign,secondStat);
         }
         else
         {
            secondValue = secondStat.calculateRoundedValue();
         }
         return sign * firstValue - secondValue;
      }
      
      private function setModifierTexts(positive:UIAutoTextField, negative:UIAutoTextField, newItem:ClothingItem, oldItem:ClothingItem, addSet:Boolean, setStats:Stats, statName:String) : void
      {
         var value:int = 0;
         var valueString:* = null;
         var _loc10_:* = null;
         var _loc9_:Stat = !!newItem ? newItem.getStatBonus(statName) : null;
         var _loc8_:Stat = !!oldItem ? oldItem.getStatBonus(statName) : null;
         if(_loc9_ == null && _loc8_ == null)
         {
            value = 0;
         }
         else if(_loc9_ && _loc8_)
         {
            if(_loc9_ == _loc8_)
            {
               value = getModifierValue(statName,-1,_loc9_,null);
            }
            else
            {
               value = getModifierValue(statName,1,_loc9_,_loc8_);
            }
         }
         else if(_loc9_)
         {
            value = getModifierValue(statName,1,_loc9_,null);
         }
         else
         {
            value = getModifierValue(statName,-1,_loc8_,null);
         }
         if(setStats)
         {
            _loc10_ = setStats.getStat(statName);
            if(_loc10_)
            {
               value += getModifierValue(statName,addSet ? 1 : -1,_loc10_,null);
            }
         }
         valueString = value.toString();
         positive.setText("+" + valueString);
         negative.setText(valueString);
         if(value > 0)
         {
            positive.setVisible(true);
            negative.setVisible(false);
         }
         else if(value < 0)
         {
            positive.setVisible(false);
            negative.setVisible(true);
         }
         else
         {
            positive.setVisible(false);
            negative.setVisible(false);
         }
      }
      
      private function getModifierString(modifier:int) : String
      {
         if(modifier > 0)
         {
            return "+" + modifier.toString();
         }
         if(modifier < 0)
         {
            return modifier.toString();
         }
         return "";
      }
      
      private function fetchTuxGame() : void
      {
         if(!tuxGame)
         {
            MessageCenter.addListener("SendGame",sendGameHandler);
            MessageCenter.sendMessage("GetGame");
         }
      }
      
      private function sendGameHandler(msg:Message) : void
      {
         MessageCenter.removeListener("SendGame",sendGameHandler);
         tuxGame = msg.data;
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         var _loc2_:TextField = event.target as TextField;
         var _loc3_:GenericTooltip = new GenericTooltip(getTooltipTid(_loc2_));
         TooltipManager.showTooltip(_loc3_,_loc2_);
         _loc3_.setX(_loc3_.getX() + _loc2_.width * 0.5);
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      private function getTooltipTid(field:TextField) : String
      {
         switch(field.name)
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
