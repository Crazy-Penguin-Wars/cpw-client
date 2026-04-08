package tuxwars.battle.ui.screen.result.awards.container
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
   public class ItemContainer extends UIContainer
   {
      private static const SLOT:String = "Slot_0";
      
      private var numSlots:int;
      
      private var _useObjectContainer:Boolean;
      
      private const slots:Vector.<ItemSlot>;
      
      private var objectContainer:ObjectContainer;
      
      private var cashValue:UIAutoTextField;
      
      private var coinValue:UIAutoTextField;
      
      private var vipValue:UIAutoTextField;
      
      private var itemValue:UIAutoTextField;
      
      private var _game:TuxWarsGame;
      
      public function ItemContainer(param1:MovieClip, param2:int, param3:TuxWarsGame, param4:Boolean, param5:UIComponent = null)
      {
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         this.slots = new Vector.<ItemSlot>();
         super(param1,param5);
         this.numSlots = param2;
         this._useObjectContainer = param4;
         this._game = param3;
         if(param4)
         {
            this.objectContainer = new ObjectContainer(param1,param3,this.getLootSlot,"transition_loot_left","transition_loot_right");
         }
         else
         {
            _loc6_ = !!param1.Container_Slots ? param1.Container_Slots : param1;
            _loc7_ = 1;
            while(_loc7_ <= this.numSlots)
            {
               this.slots.push(new ItemSlot(_loc6_.getChildByName("Slot_0" + _loc7_) as MovieClip,param3));
               _loc7_++;
            }
         }
         LogUtils.log("Constructed: objectContainer: " + this.objectContainer + " slotsLenght: " + this.slots.length + " useObjectContainer: " + this._useObjectContainer,this,0,"UI",false);
      }
      
      override public function dispose() : void
      {
         this.slots.splice(0,this.slots.length);
         this.objectContainer.dispose();
         this.objectContainer = null;
         this._game = null;
         super.dispose();
      }
      
      public function init(param1:Vector.<ItemData>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:int = 0;
         LogUtils.log("Init: numSlots: " + this.numSlots + " itemsLenght: " + param1.length + " useObjectContainer: " + this._useObjectContainer,this,0,"UI",false);
         if(!this._useObjectContainer)
         {
            _loc2_ = 0;
            while(_loc2_ < this.numSlots)
            {
               _loc3_ = (this._design as MovieClip).getChildByName("Slot_0" + (_loc2_ + 1)) as MovieClip;
               _loc4_ = (_loc3_ as MovieClip).getChildByName("Reward_Cash") as MovieClip;
               _loc5_ = (_loc3_ as MovieClip).getChildByName("Reward_Coins") as MovieClip;
               _loc6_ = (_loc3_ as MovieClip).getChildByName("Reward_Membership") as MovieClip;
               _loc7_ = (_loc3_ as MovieClip).getChildByName("Reward_Item") as MovieClip;
               if(_loc4_ != null)
               {
                  _loc4_.visible = false;
               }
               if(_loc5_ != null)
               {
                  _loc5_.visible = false;
               }
               if(_loc6_ != null)
               {
                  _loc6_.visible = false;
               }
               if(_loc7_ != null)
               {
                  _loc7_.visible = false;
               }
               if(param1[_loc2_] is CashData)
               {
                  this.slots[_loc2_].itemName = ProjectManager.getText("LEVELUP_CASH_TITLE");
                  this.slots[_loc2_].itemDescription = ProjectManager.getText("LEVELUP_CASH_DESC");
                  if(_loc4_ != null)
                  {
                     _loc8_ = int((param1[_loc2_] as CashData).amount);
                     this.cashValue = TuxUiUtils.createAutoTextFieldWithText((_loc4_ as MovieClip).getChildByName("Text") as TextField,"" + _loc8_);
                     _loc4_.visible = true;
                  }
               }
               else if(param1[_loc2_] is VipData)
               {
                  this.slots[_loc2_].itemName = ProjectManager.getText("LEVELUP_VIP_TITLE");
                  this.slots[_loc2_].itemDescription = ProjectManager.getText("LEVELUP_VIP_DESC");
                  if(_loc6_ != null)
                  {
                     _loc8_ = int((param1[_loc2_] as VipData).amount);
                     this.vipValue = TuxUiUtils.createAutoTextFieldWithText((_loc6_ as MovieClip).getChildByName("Text") as TextField,"" + _loc8_);
                     _loc6_.visible = true;
                  }
               }
               else if(param1[_loc2_] is CoinData)
               {
                  this.slots[_loc2_].itemName = ProjectManager.getText("LEVELUP_COIN_TITLE");
                  this.slots[_loc2_].itemDescription = ProjectManager.getText("LEVELUP_COIN_DESC");
                  if(_loc5_ != null)
                  {
                     _loc8_ = int((param1[_loc2_] as CoinData).amount);
                     this.coinValue = TuxUiUtils.createAutoTextFieldWithText((_loc5_ as MovieClip).getChildByName("Text") as TextField,"" + _loc8_);
                     _loc5_.visible = true;
                  }
               }
               else if(param1[_loc2_] is ItemData)
               {
                  this.slots[_loc2_].init(param1[_loc2_]);
                  if(_loc7_ != null)
                  {
                     _loc8_ = int((param1[_loc2_] as ItemData).amount);
                     this.itemValue = TuxUiUtils.createAutoTextFieldWithText((_loc7_ as MovieClip).getChildByName("Text") as TextField,"" + _loc8_);
                     _loc7_.visible = true;
                  }
               }
               _loc2_++;
            }
         }
         else
         {
            this.objectContainer.init(param1);
         }
      }
      
      private function getLootSlot(param1:int, param2:*, param3:MovieClip) : *
      {
         var _loc4_:ItemSlot = new ItemSlot(param3,this._game);
         _loc4_.init(param2 as ItemData);
         this.createRewardSlots(param3,param2);
         return _loc4_;
      }
      
      private function createRewardSlots(param1:MovieClip, param2:*) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = (param1 as MovieClip).getChildByName("Reward_Cash") as MovieClip;
         var _loc5_:MovieClip = (param1 as MovieClip).getChildByName("Reward_Coins") as MovieClip;
         var _loc6_:MovieClip = (param1 as MovieClip).getChildByName("Reward_Membership") as MovieClip;
         var _loc7_:MovieClip = (param1 as MovieClip).getChildByName("Reward_Item") as MovieClip;
         if(_loc4_ != null)
         {
            _loc4_.visible = false;
         }
         if(_loc5_ != null)
         {
            _loc5_.visible = false;
         }
         if(_loc6_ != null)
         {
            _loc6_.visible = false;
         }
         if(_loc7_ != null)
         {
            _loc7_.visible = false;
         }
         if(param2 is CashData)
         {
            if(_loc4_ != null)
            {
               _loc3_ = int((param2 as CashData).amount);
               this.cashValue = TuxUiUtils.createAutoTextFieldWithText((_loc4_ as MovieClip).getChildByName("Text") as TextField,"" + _loc3_);
               _loc4_.visible = true;
            }
         }
         else if(param2 is VipData)
         {
            if(_loc6_ != null)
            {
               _loc3_ = int((param2 as VipData).amount);
               this.vipValue = TuxUiUtils.createAutoTextFieldWithText((_loc6_ as MovieClip).getChildByName("Text") as TextField,"" + _loc3_);
               _loc6_.visible = true;
            }
         }
         else if(param2 is CoinData)
         {
            if(_loc5_ != null)
            {
               _loc3_ = int((param2 as CoinData).amount);
               this.coinValue = TuxUiUtils.createAutoTextFieldWithText((_loc5_ as MovieClip).getChildByName("Text") as TextField,"" + _loc3_);
               _loc5_.visible = true;
            }
         }
         else if(param2 is ItemData)
         {
            if(_loc7_ != null)
            {
               _loc3_ = int((param2 as ItemData).amount);
               this.itemValue = TuxUiUtils.createAutoTextFieldWithText((_loc7_ as MovieClip).getChildByName("Text") as TextField,"" + _loc3_);
               _loc7_.visible = true;
            }
         }
      }
   }
}

