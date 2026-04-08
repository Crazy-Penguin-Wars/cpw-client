package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.dailynews.DailyNewsData;
   import tuxwars.home.ui.logic.dailynews.DailyNewsLogic;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.items.managers.*;
   import tuxwars.utils.*;
   
   public class DailyNewsScreen extends TuxUIScreen
   {
      private static const CLOSE_BUTTON:String = "Button_Close";
      
      private static const GIFTS_BUTTON:String = "Button_Gifts";
      
      private static const INBOX_BUTTON:String = "Button_Inbox";
      
      private var _closeButton:UIButton;
      
      private var _giftsButton:UIButton;
      
      private var _inboxButton:UIButton;
      
      private var saleSlotLeft:SaleSlot;
      
      private var saleSlotRight:SaleSlot;
      
      private var megaPackSlotLeft:MegaPackSlot;
      
      private var megaPackSlotRight:MegaPackSlot;
      
      private var addSlot:AddSlot;
      
      private const _dailyRewardContainers:Vector.<DailyRewardContainers> = new Vector.<DailyRewardContainers>();
      
      private var dailyRewardContainer:MovieClip;
      
      private var dailyRewardArray:Array;
      
      public var day:int;
      
      public function DailyNewsScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/daily_news.swf","daily_news_2"));
         var _loc2_:MovieClip = getDesignMovieClip();
         this.dailyRewardContainer = (_loc2_ as MovieClip).getChildByName("Slot_Daily_Reward") as MovieClip;
         this._closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",this.closePressed);
         this._giftsButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Gifts",this.giftsPressed,"DAILY_NEWS_GIFTS_BUTTON");
         this._inboxButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Inbox",this.inboxPressed,"DAILY_NEWS_INBOX_BUTTON",null,[InboxManager.messageCount]);
         TuxUiUtils.createAutoTextField(_loc2_.Text_Header,"DAILY_NEWS_HEADER");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Title_Reward,"DAILY_REWARD_HEADER");
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         this.dailyRewardInit(param1);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         if(this.dailyNewsData.saleLeft)
         {
            this._design.Slot_01.Slot_Default.visible = false;
            this.saleSlotLeft = new SaleSlot(this._design.Slot_01.Slot_Selected,this.dailyNewsData.saleLeft,this);
         }
         else
         {
            this._design.Slot_01.Slot_Selected.visible = false;
            this.megaPackSlotLeft = new MegaPackSlot(this._design.Slot_01.Slot_Default,ItemManager.getItemData("StarterPack"),this);
         }
         if(this.dailyNewsData.saleRight)
         {
            this._design.Slot_02.Slot_Default.visible = false;
            this.saleSlotRight = new SaleSlot(this._design.Slot_02.Slot_Selected,this.dailyNewsData.saleRight,this);
         }
         else
         {
            this._design.Slot_02.Slot_Selected.visible = false;
            this.megaPackSlotRight = new MegaPackSlot(this._design.Slot_02.Slot_Default,ItemManager.getItemData("DemolitionPack"),this);
         }
         this.addSlot = new AddSlot(this._design,this.dailyNewsData.addDatas);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         if(this._closeButton)
         {
            this._closeButton.dispose();
            this._closeButton = null;
         }
         if(this._giftsButton)
         {
            this._giftsButton.dispose();
            this._giftsButton = null;
         }
         if(this._inboxButton)
         {
            this._inboxButton.dispose();
            this._inboxButton = null;
         }
         for each(_loc1_ in this._dailyRewardContainers)
         {
            _loc1_.dispose();
         }
         this._dailyRewardContainers.splice(0,this._dailyRewardContainers.length);
         if(this.megaPackSlotLeft)
         {
            this.megaPackSlotLeft.dispose();
            this.megaPackSlotLeft = null;
         }
         if(this.megaPackSlotRight)
         {
            this.megaPackSlotRight.dispose();
            this.megaPackSlotRight = null;
         }
         if(this.saleSlotLeft)
         {
            this.saleSlotLeft.dispose();
            this.saleSlotLeft = null;
         }
         if(this.saleSlotRight)
         {
            this.saleSlotRight.dispose();
            this.saleSlotRight = null;
         }
         if(this.addSlot)
         {
            this.addSlot.dispose();
            this.addSlot = null;
         }
         super.dispose();
      }
      
      public function dailyRewardInit(param1:TuxWarsGame) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this.dailyRewardArray = param1.player.dailyRewards;
         this.day = param1.player.dailyRewardDay;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = ProjectManager.getText("DAILY_REWARD_TEXT");
            _loc4_ = this.dailyRewardArray[_loc2_][1];
            _loc5_ = this.dailyRewardArray[_loc2_][0];
            if(this.day < _loc2_ - 1)
            {
               _loc6_ = " ";
            }
            else if(this.day == _loc2_ - 1)
            {
               _loc6_ = ProjectManager.getText("DAILY_REWARD_TEXT_MESSAGE_TOMORROW");
            }
            else
            {
               _loc6_ = ProjectManager.getText("DAILY_REWARD_TEXT_MESSAGE_COLLECTED");
            }
            this._dailyRewardContainers.push(new DailyRewardContainers(param1,this.dailyRewardContainer,_loc2_,_loc3_ + " " + (_loc2_ + 1),_loc4_,_loc6_,_loc5_,this.day));
            _loc2_++;
         }
      }
      
      private function get dailyNewsLogic() : DailyNewsLogic
      {
         return logic;
      }
      
      private function closePressed(param1:MouseEvent) : void
      {
         this.dailyNewsLogic.exit();
      }
      
      private function giftsPressed(param1:MouseEvent) : void
      {
         this.dailyNewsLogic.openGifts();
      }
      
      private function inboxPressed(param1:MouseEvent) : void
      {
         this.dailyNewsLogic.openInbox();
      }
      
      private function slotMachinePressed(param1:MouseEvent) : void
      {
         this.dailyNewsLogic.openSlotMachine();
      }
      
      private function get dailyNewsData() : DailyNewsData
      {
         return params;
      }
   }
}

