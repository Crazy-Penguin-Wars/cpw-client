package tuxwars.home.ui.screen.tournament
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.ui.screen.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.TournamentRewardItem;
   import tuxwars.items.managers.*;
   import tuxwars.ui.tooltips.*;
   
   public class TournamentRewardSlot extends UIStateComponent
   {
      private static const REWARD_CASH:String = "Reward_Cash";
      
      private static const REWARD_COINS:String = "Reward_Coins";
      
      private static const REWARD_XP:String = "Reward_Exp";
      
      private static const REWARD_ITEM:String = "Reward_Item";
      
      private static const REWARD_MEMBERSHIP:String = "Reward_Membership";
      
      private var _game:TuxWarsGame;
      
      private var _tournamentRewardItem:TournamentRewardItem;
      
      private var _parent:TuxUIScreen;
      
      private var _positionText:TextField;
      
      private var _amountText:TextField;
      
      public function TournamentRewardSlot(param1:MovieClip, param2:TuxWarsGame, param3:TournamentRewardItem, param4:int, param5:TuxUIScreen = null, param6:Boolean = true)
      {
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         super(param1);
         this._game = param2;
         this._tournamentRewardItem = param3;
         this._parent = param5;
         if(param6)
         {
            param1.addEventListener("mouseOver",this.mouseOver,false,0,true);
            param1.addEventListener("mouseOut",this.mouseOut,false,0,true);
         }
         this._positionText = param1.getChildByName("Text") as TextField;
         if(this._positionText)
         {
            this._positionText.text = ProjectManager.getText("TOURNAMENT_POSITION_" + param4);
         }
         (param1.getChildByName("Reward_Cash") as MovieClip).visible = this._tournamentRewardItem.type == "Cash";
         (param1.getChildByName("Reward_Coins") as MovieClip).visible = this._tournamentRewardItem.type == "Coins";
         (param1.getChildByName("Reward_Item") as MovieClip).visible = this._tournamentRewardItem.type == "Item";
         (param1.getChildByName("Reward_Exp") as MovieClip).visible = this._tournamentRewardItem.type == "XP";
         (param1.getChildByName("Reward_Membership") as MovieClip).visible = this._tournamentRewardItem.type == "VIP";
         var _loc9_:String = "" + param3.amount;
         switch(param3.type)
         {
            case "Cash":
               _loc7_ = param1.getChildByName("Reward_Cash") as MovieClip;
               break;
            case "Coins":
               _loc7_ = param1.getChildByName("Reward_Coins") as MovieClip;
               break;
            case "XP":
               _loc7_ = param1.getChildByName("Reward_Exp") as MovieClip;
               break;
            case "Item":
               _loc7_ = param1.getChildByName("Reward_Item") as MovieClip;
               _loc8_ = _loc7_.getChildByName("Container_Icon") as MovieClip;
               _loc8_.addChild(this._tournamentRewardItem.itemData.icon);
               if(this._tournamentRewardItem.itemData.type == "Clothing")
               {
                  _loc9_ = "";
               }
               break;
            case "VIP":
               _loc7_ = param1.getChildByName("Reward_Membership") as MovieClip;
               _loc9_ = ProjectManager.getText("TOURNAMENT_DAY",[param3.amount]);
               break;
            default:
               LogUtils.log("No item slot defined for the item type: " + param3.type,"TournamentRewardSlot",2,"Tournament");
               return;
         }
         this._amountText = _loc7_.getChildByName("Text") as TextField;
         this._amountText.text = _loc9_;
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",this.mouseOver,false);
         this._design.removeEventListener("mouseOut",this.mouseOut,false);
         TooltipManager.removeTooltip();
         this._game = null;
         this._tournamentRewardItem = null;
         super.dispose();
      }
      
      public function get game() : TuxWarsGame
      {
         return this._game;
      }
      
      public function get tournamentRewardItem() : TournamentRewardItem
      {
         return this._tournamentRewardItem;
      }
      
      public function get parent() : TuxUIScreen
      {
         return this._parent;
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ShopItem = null;
         var _loc3_:ItemBaseTooltip = null;
         var _loc4_:* = this._tournamentRewardItem.type == "Item";
         if(_loc4_)
         {
            _loc2_ = ShopItemManager.getShopItem(this._tournamentRewardItem.itemData);
            if(_loc2_)
            {
               if(_loc2_.itemData.type == "Weapon")
               {
                  _loc3_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getWeaponTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this._design) as ItemBaseTooltip;
               }
               else if(_loc2_.itemData.type == "Clothing")
               {
                  _loc3_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getClothingTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this._design) as ItemBaseTooltip;
               }
               else
               {
                  _loc3_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getBoosterTooltipGraphics(),(this.parent as TuxUIScreen).tuxGame),this._design) as ItemBaseTooltip;
               }
               (_loc3_.content.containers.getCurrentContainer() as TooltipContainer).amountTextField.setText("x" + this._tournamentRewardItem.amount);
            }
         }
         else
         {
            TooltipManager.showTooltip(new ItemTooltip(this._tournamentRewardItem.name,this._tournamentRewardItem.description),this._design);
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

