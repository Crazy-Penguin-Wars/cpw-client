package tuxwars.home.ui.screen.money
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.money.*;
   import tuxwars.utils.*;
   
   public class MoneyScreenCash extends TuxUIScreen
   {
      public static const MONEY_SCREEN_CASH:String = "popup_get_cash_new";
      
      private static const TEXT_HEADER:String = "Text_Header";
      
      private static const CONTAINER_SLOTS:String = "Container_Slots";
      
      private static const CONTAINER_SLOTS_DISCOUNT:String = "Container_Slots_discount";
      
      private static const DISCOUNT_LABEL:String = "discount_label";
      
      private static const SLOT_INDEX:String = "Slot_0";
      
      private var headerTextField:TextField;
      
      private var moneySlots:Vector.<MoneyContainer> = new Vector.<MoneyContainer>();
      
      private var buttonClose:UIButton;
      
      internal var slots:MovieClip;
      
      public function MoneyScreenCash(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_get_cash_new"));
         if(param1.homeState)
         {
            IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         }
         this.buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",this.closeScreen);
         this.headerTextField = this._design.getChildByName("Text_Header") as TextField;
         this.headerTextField.text = ProjectManager.getText("MONEY_SCREEN_CASH_TITLE");
         this._design.getChildByName("discount_label").visible = false;
         this.callInitSlots();
         this.addData();
      }
      
      override public function dispose() : void
      {
         if(_game.homeState)
         {
            IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         }
         super.dispose();
         this.buttonClose.dispose();
         this.buttonClose = null;
         this.moneySlots = null;
      }
      
      private function initSlots(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            this.moneySlots.push(new MoneyContainer(MovieClip(param1.getChildByName("Slot_0" + (_loc2_ + 1))),tuxGame,true));
            _loc2_++;
         }
      }
      
      private function addData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<CashPackage> = MoneyManager.getCashPackages();
         _loc1_ = 0;
         while(_loc1_ < this.moneySlots.length)
         {
            if(_loc1_ < _loc2_.length)
            {
               this.moneySlots[_loc1_].setData(_loc2_[_loc1_],null);
            }
            else
            {
               this.moneySlots[_loc1_].setData(null,null);
            }
            _loc1_++;
         }
      }
      
      private function callInitSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<CashPackage> = MoneyManager.getCashPackages();
         _loc1_ = 0;
         while(_loc1_ < this._design.getChildByName("Container_Slots").numChildren)
         {
            if(_loc2_[_loc1_].creditCost == _loc2_[_loc1_].creditOld)
            {
               this._design.getChildByName("Container_Slots_discount").getChildByName("Slot_0" + (_loc1_ + 1)).visible = false;
               this.moneySlots.push(new MoneyContainer(MovieClip(this._design.getChildByName("Container_Slots").getChildByName("Slot_0" + (_loc1_ + 1))),tuxGame,true));
            }
            else
            {
               this._design.getChildByName("Container_Slots").getChildByName("Slot_0" + (_loc1_ + 1)).visible = false;
               this.moneySlots.push(new MoneyContainer(MovieClip(this._design.getChildByName("Container_Slots_discount").getChildByName("Slot_0" + (_loc1_ + 1))),tuxGame,true));
            }
            _loc1_++;
         }
      }
      
      private function closeScreen(param1:MouseEvent) : void
      {
         logic.close();
      }
   }
}

