package tuxwars.home.ui.screen.tournament
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.TournamentRewardItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.ItemTooltip;
   import tuxwars.ui.tooltips.TooltipContainer;
   import tuxwars.ui.tooltips.TooltipManager;
   
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
      
      public function TournamentRewardSlot(design:MovieClip, game:TuxWarsGame, tournamentRewardItem:TournamentRewardItem, positionNumber:int, parent:TuxUIScreen = null, showTooltip:Boolean = true)
      {
         var slotContainer:* = null;
         var _loc9_:* = null;
         super(design);
         _game = game;
         _tournamentRewardItem = tournamentRewardItem;
         _parent = parent;
         if(showTooltip)
         {
            design.addEventListener("mouseOver",mouseOver,false,0,true);
            design.addEventListener("mouseOut",mouseOut,false,0,true);
         }
         _positionText = design.getChildByName("Text") as TextField;
         if(_positionText)
         {
            _positionText.text = ProjectManager.getText("TOURNAMENT_POSITION_" + positionNumber);
         }
         (design.getChildByName("Reward_Cash") as MovieClip).visible = _tournamentRewardItem.type == "Cash";
         (design.getChildByName("Reward_Coins") as MovieClip).visible = _tournamentRewardItem.type == "Coins";
         (design.getChildByName("Reward_Item") as MovieClip).visible = _tournamentRewardItem.type == "Item";
         (design.getChildByName("Reward_Exp") as MovieClip).visible = _tournamentRewardItem.type == "XP";
         (design.getChildByName("Reward_Membership") as MovieClip).visible = _tournamentRewardItem.type == "VIP";
         var slotAmountText:String = "" + tournamentRewardItem.amount;
         switch(tournamentRewardItem.type)
         {
            case "Cash":
               slotContainer = design.getChildByName("Reward_Cash") as MovieClip;
               break;
            case "Coins":
               slotContainer = design.getChildByName("Reward_Coins") as MovieClip;
               break;
            case "XP":
               slotContainer = design.getChildByName("Reward_Exp") as MovieClip;
               break;
            case "Item":
               slotContainer = design.getChildByName("Reward_Item") as MovieClip;
               _loc9_ = slotContainer.getChildByName("Container_Icon") as MovieClip;
               _loc9_.addChild(_tournamentRewardItem.itemData.icon);
               if(_tournamentRewardItem.itemData.type == "Clothing")
               {
                  slotAmountText = "";
                  break;
               }
               break;
            case "VIP":
               slotContainer = design.getChildByName("Reward_Membership") as MovieClip;
               slotAmountText = ProjectManager.getText("TOURNAMENT_DAY",[tournamentRewardItem.amount]);
               break;
            default:
               LogUtils.log("No item slot defined for the item type: " + tournamentRewardItem.type,"TournamentRewardSlot",2,"Tournament");
               return;
         }
         _amountText = slotContainer.getChildByName("Text") as TextField;
         _amountText.text = slotAmountText;
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",mouseOver,false);
         this._design.removeEventListener("mouseOut",mouseOut,false);
         TooltipManager.removeTooltip();
         _game = null;
         _tournamentRewardItem = null;
         super.dispose();
      }
      
      public function get game() : TuxWarsGame
      {
         return _game;
      }
      
      public function get tournamentRewardItem() : TournamentRewardItem
      {
         return _tournamentRewardItem;
      }
      
      public function get parent() : TuxUIScreen
      {
         return _parent;
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         var _loc4_:* = null;
         var tt:* = null;
         var b:Boolean = _tournamentRewardItem.type == "Item";
         if(b)
         {
            _loc4_ = ShopItemManager.getShopItem(_tournamentRewardItem.itemData);
            if(_loc4_)
            {
               if(_loc4_.itemData.type == "Weapon")
               {
                  tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc4_,TooltipsData.getWeaponTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design) as ItemBaseTooltip;
               }
               else if(_loc4_.itemData.type == "Clothing")
               {
                  tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc4_,TooltipsData.getClothingTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design) as ItemBaseTooltip;
               }
               else
               {
                  tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc4_,TooltipsData.getBoosterTooltipGraphics(),(parent as TuxUIScreen).tuxGame),this._design) as ItemBaseTooltip;
               }
               (tt.content.containers.getCurrentContainer() as TooltipContainer).amountTextField.setText("x" + _tournamentRewardItem.amount);
            }
         }
         else
         {
            TooltipManager.showTooltip(new ItemTooltip(_tournamentRewardItem.name,_tournamentRewardItem.description),this._design);
         }
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
