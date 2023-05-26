package tuxwars.battle.ui.screen.result.awards.container
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.CashData;
   import tuxwars.items.data.CoinData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.VipData;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.utils.TuxUiUtils;
   
   public class ItemContainer extends UIContainer
   {
      
      private static const SLOT:String = "Slot_0";
       
      
      private var numSlots:int;
      
      private var _useObjectContainer:Boolean;
      
      private const slots:Vector.<ItemSlot> = new Vector.<ItemSlot>();
      
      private var objectContainer:ObjectContainer;
      
      private var cashValue:UIAutoTextField;
      
      private var coinValue:UIAutoTextField;
      
      private var vipValue:UIAutoTextField;
      
      private var itemValue:UIAutoTextField;
      
      private var _game:TuxWarsGame;
      
      public function ItemContainer(design:MovieClip, number:int, game:TuxWarsGame, useObjectContainer:Boolean, parent:UIComponent = null)
      {
         var _loc6_:* = null;
         var i:int = 0;
         super(design,parent);
         numSlots = number;
         _useObjectContainer = useObjectContainer;
         _game = game;
         if(useObjectContainer)
         {
            objectContainer = new ObjectContainer(design,game,getLootSlot,"transition_loot_left","transition_loot_right");
         }
         else
         {
            _loc6_ = !!design.Container_Slots ? design.Container_Slots : design;
            for(i = 1; i <= numSlots; )
            {
               slots.push(new ItemSlot(_loc6_.getChildByName("Slot_0" + i) as MovieClip,game));
               i++;
            }
         }
         LogUtils.log("Constructed: objectContainer: " + objectContainer + " slotsLenght: " + slots.length + " useObjectContainer: " + _useObjectContainer,this,0,"UI",false);
      }
      
      override public function dispose() : void
      {
         slots.splice(0,slots.length);
         objectContainer.dispose();
         objectContainer = null;
         _game = null;
         super.dispose();
      }
      
      public function init(items:Vector.<ItemData>) : void
      {
         var i:int = 0;
         var currentDesign:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var value:int = 0;
         LogUtils.log("Init: numSlots: " + numSlots + " itemsLenght: " + items.length + " useObjectContainer: " + _useObjectContainer,this,0,"UI",false);
         if(!_useObjectContainer)
         {
            for(i = 0; i < numSlots; )
            {
               currentDesign = (this._design as MovieClip).getChildByName("Slot_0" + (i + 1)) as MovieClip;
               _loc4_ = (currentDesign as MovieClip).getChildByName("Reward_Cash") as MovieClip;
               _loc2_ = (currentDesign as MovieClip).getChildByName("Reward_Coins") as MovieClip;
               _loc3_ = (currentDesign as MovieClip).getChildByName("Reward_Membership") as MovieClip;
               _loc6_ = (currentDesign as MovieClip).getChildByName("Reward_Item") as MovieClip;
               if(_loc4_ != null)
               {
                  _loc4_.visible = false;
               }
               if(_loc2_ != null)
               {
                  _loc2_.visible = false;
               }
               if(_loc3_ != null)
               {
                  _loc3_.visible = false;
               }
               if(_loc6_ != null)
               {
                  _loc6_.visible = false;
               }
               if(items[i] is CashData)
               {
                  slots[i].itemName = ProjectManager.getText("LEVELUP_CASH_TITLE");
                  slots[i].itemDescription = ProjectManager.getText("LEVELUP_CASH_DESC");
                  if(_loc4_ != null)
                  {
                     value = (items[i] as CashData).amount;
                     cashValue = TuxUiUtils.createAutoTextFieldWithText((_loc4_ as MovieClip).getChildByName("Text") as TextField,"" + value);
                     _loc4_.visible = true;
                  }
               }
               else if(items[i] is VipData)
               {
                  slots[i].itemName = ProjectManager.getText("LEVELUP_VIP_TITLE");
                  slots[i].itemDescription = ProjectManager.getText("LEVELUP_VIP_DESC");
                  if(_loc3_ != null)
                  {
                     value = (items[i] as VipData).amount;
                     vipValue = TuxUiUtils.createAutoTextFieldWithText((_loc3_ as MovieClip).getChildByName("Text") as TextField,"" + value);
                     _loc3_.visible = true;
                  }
               }
               else if(items[i] is CoinData)
               {
                  slots[i].itemName = ProjectManager.getText("LEVELUP_COIN_TITLE");
                  slots[i].itemDescription = ProjectManager.getText("LEVELUP_COIN_DESC");
                  if(_loc2_ != null)
                  {
                     value = (items[i] as CoinData).amount;
                     coinValue = TuxUiUtils.createAutoTextFieldWithText((_loc2_ as MovieClip).getChildByName("Text") as TextField,"" + value);
                     _loc2_.visible = true;
                  }
               }
               else if(items[i] is ItemData)
               {
                  slots[i].init(items[i]);
                  if(_loc6_ != null)
                  {
                     value = (items[i] as ItemData).amount;
                     itemValue = TuxUiUtils.createAutoTextFieldWithText((_loc6_ as MovieClip).getChildByName("Text") as TextField,"" + value);
                     _loc6_.visible = true;
                  }
               }
               i++;
            }
         }
         else
         {
            objectContainer.init(items);
         }
      }
      
      private function getLootSlot(slotIndex:int, object:*, scrollDesign:MovieClip) : *
      {
         var lootItem:ItemSlot = new ItemSlot(scrollDesign,_game);
         lootItem.init(object as ItemData);
         createRewardSlots(scrollDesign,object);
         return lootItem;
      }
      
      private function createRewardSlots(currentDesign:MovieClip, item:*) : void
      {
         var value:int = 0;
         var _loc5_:MovieClip = (currentDesign as MovieClip).getChildByName("Reward_Cash") as MovieClip;
         var _loc3_:MovieClip = (currentDesign as MovieClip).getChildByName("Reward_Coins") as MovieClip;
         var _loc4_:MovieClip = (currentDesign as MovieClip).getChildByName("Reward_Membership") as MovieClip;
         var _loc7_:MovieClip = (currentDesign as MovieClip).getChildByName("Reward_Item") as MovieClip;
         if(_loc5_ != null)
         {
            _loc5_.visible = false;
         }
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
         if(_loc4_ != null)
         {
            _loc4_.visible = false;
         }
         if(_loc7_ != null)
         {
            _loc7_.visible = false;
         }
         if(item is CashData)
         {
            if(_loc5_ != null)
            {
               value = (item as CashData).amount;
               cashValue = TuxUiUtils.createAutoTextFieldWithText((_loc5_ as MovieClip).getChildByName("Text") as TextField,"" + value);
               _loc5_.visible = true;
            }
         }
         else if(item is VipData)
         {
            if(_loc4_ != null)
            {
               value = (item as VipData).amount;
               vipValue = TuxUiUtils.createAutoTextFieldWithText((_loc4_ as MovieClip).getChildByName("Text") as TextField,"" + value);
               _loc4_.visible = true;
            }
         }
         else if(item is CoinData)
         {
            if(_loc3_ != null)
            {
               value = (item as CoinData).amount;
               coinValue = TuxUiUtils.createAutoTextFieldWithText((_loc3_ as MovieClip).getChildByName("Text") as TextField,"" + value);
               _loc3_.visible = true;
            }
         }
         else if(item is ItemData)
         {
            if(_loc7_ != null)
            {
               value = (item as ItemData).amount;
               itemValue = TuxUiUtils.createAutoTextFieldWithText((_loc7_ as MovieClip).getChildByName("Text") as TextField,"" + value);
               _loc7_.visible = true;
            }
         }
      }
   }
}
