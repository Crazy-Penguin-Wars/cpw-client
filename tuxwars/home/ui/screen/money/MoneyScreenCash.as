package tuxwars.home.ui.screen.money
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.money.CashPackage;
   import tuxwars.money.MoneyManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class MoneyScreenCash extends TuxUIScreen
   {
      
      public static const MONEY_SCREEN_CASH:String = "popup_get_cash_new";
      
      private static const TEXT_HEADER:String = "Text_Header";
      
      private static const CONTAINER_SLOTS:String = "Container_Slots";
      
      private static const CONTAINER_SLOTS_DISCOUNT:String = "Container_Slots_discount";
      
      private static const DISCOUNT_LABEL:String = "discount_label";
      
      private static const SLOT_INDEX:String = "Slot_0";
       
      
      private var headerTextField:TextField;
      
      private var moneySlots:Vector.<MoneyContainer>;
      
      private var buttonClose:UIButton;
      
      internal var slots:MovieClip;
      
      public function MoneyScreenCash(game:TuxWarsGame)
      {
         moneySlots = new Vector.<MoneyContainer>();
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_get_cash_new"));
         if(game.homeState)
         {
            IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         }
         buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeScreen);
         headerTextField = this._design.getChildByName("Text_Header") as TextField;
         headerTextField.text = ProjectManager.getText("MONEY_SCREEN_CASH_TITLE");
         this._design.getChildByName("discount_label").visible = false;
         callInitSlots();
         addData();
      }
      
      override public function dispose() : void
      {
         if(_game.homeState)
         {
            IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         }
         super.dispose();
         buttonClose.dispose();
         buttonClose = null;
         moneySlots = null;
      }
      
      private function initSlots(slotsClip:MovieClip) : void
      {
         var i:int = 0;
         for(i = 0; i < slotsClip.numChildren; )
         {
            moneySlots.push(new MoneyContainer(MovieClip(slotsClip.getChildByName("Slot_0" + (i + 1))),tuxGame,true));
            i++;
         }
      }
      
      private function addData() : void
      {
         var slotIndex:int = 0;
         var _loc2_:Vector.<CashPackage> = MoneyManager.getCashPackages();
         for(slotIndex = 0; slotIndex < moneySlots.length; )
         {
            if(slotIndex < _loc2_.length)
            {
               moneySlots[slotIndex].setData(_loc2_[slotIndex],null);
            }
            else
            {
               moneySlots[slotIndex].setData(null,null);
            }
            slotIndex++;
         }
      }
      
      private function callInitSlots() : void
      {
         var slotIndex:int = 0;
         var _loc2_:Vector.<CashPackage> = MoneyManager.getCashPackages();
         slotIndex = 0;
         for(; slotIndex < this._design.getChildByName("Container_Slots").numChildren; slotIndex++)
         {
            if(_loc2_[slotIndex].creditCost == _loc2_[slotIndex].creditOld)
            {
               this._design.getChildByName("Container_Slots_discount").getChildByName("Slot_0" + (slotIndex + 1)).visible = false;
               moneySlots.push(new MoneyContainer(MovieClip(this._design.getChildByName("Container_Slots").getChildByName("Slot_0" + (slotIndex + 1))),tuxGame,true));
            }
            else
            {
               this._design.getChildByName("Container_Slots").getChildByName("Slot_0" + (slotIndex + 1)).visible = false;
               moneySlots.push(new MoneyContainer(MovieClip(this._design.getChildByName("Container_Slots_discount").getChildByName("Slot_0" + (slotIndex + 1))),tuxGame,true));
            }
         }
      }
      
      private function closeScreen(event:MouseEvent) : void
      {
         logic.close();
      }
   }
}
