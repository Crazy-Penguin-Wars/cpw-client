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
   import tuxwars.money.CoinPackage;
   import tuxwars.money.MoneyManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class MoneyScreenCoins extends TuxUIScreen
   {
      
      public static const MONEY_SCREEN_COINS:String = "popup_get_coins";
      
      private static const TEXT_HEADER:String = "Text_Header";
      
      private static const CONTAINER_SLOTS:String = "Container_Slots";
      
      private static const SLOT_INDEX:String = "Slot_0";
       
      
      private var headerTextField:TextField;
      
      private var moneySlots:Vector.<MoneySlot>;
      
      private var buttonClose:UIButton;
      
      public function MoneyScreenCoins(game:TuxWarsGame)
      {
         moneySlots = new Vector.<MoneySlot>();
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_get_coins"));
         if(game.homeState)
         {
            IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         }
         buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeScreen);
         headerTextField = this._design.getChildByName("Text_Header") as TextField;
         headerTextField.text = ProjectManager.getText("MONEY_SCREEN_COINS_TITLE");
         initSlots(this._design.getChildByName("Container_Slots") as MovieClip);
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
            moneySlots.push(new MoneySlot(MovieClip(slotsClip.getChildByName("Slot_0" + (i + 1))),tuxGame));
            i++;
         }
      }
      
      private function addData() : void
      {
         var slotIndex:int = 0;
         var _loc2_:Vector.<CoinPackage> = MoneyManager.getCoinPackages();
         for(slotIndex = 0; slotIndex < moneySlots.length; )
         {
            if(slotIndex < _loc2_.length)
            {
               moneySlots[slotIndex].setData(null,_loc2_[slotIndex]);
            }
            else
            {
               moneySlots[slotIndex].setData(null,null);
            }
            slotIndex++;
         }
      }
      
      private function closeScreen(event:MouseEvent) : void
      {
         logic.close();
      }
   }
}
