package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.dailynews.DailyNewsData;
   import tuxwars.home.ui.logic.dailynews.DailyNewsLogic;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function DailyNewsScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/daily_news.swf","daily_news_2"));
         var _loc2_:MovieClip = getDesignMovieClip();
         dailyRewardContainer = (_loc2_ as MovieClip).getChildByName("Slot_Daily_Reward") as MovieClip;
         _closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",closePressed);
         _giftsButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Gifts",giftsPressed,"DAILY_NEWS_GIFTS_BUTTON");
         _inboxButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Inbox",inboxPressed,"DAILY_NEWS_INBOX_BUTTON",null,[InboxManager.messageCount]);
         TuxUiUtils.createAutoTextField(_loc2_.Text_Header,"DAILY_NEWS_HEADER");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Title_Reward,"DAILY_REWARD_HEADER");
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         dailyRewardInit(game);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         if(dailyNewsData.saleLeft)
         {
            this._design.Slot_01.Slot_Default.visible = false;
            saleSlotLeft = new SaleSlot(this._design.Slot_01.Slot_Selected,dailyNewsData.saleLeft,this);
         }
         else
         {
            this._design.Slot_01.Slot_Selected.visible = false;
            megaPackSlotLeft = new MegaPackSlot(this._design.Slot_01.Slot_Default,ItemManager.getItemData("StarterPack"),this);
         }
         if(dailyNewsData.saleRight)
         {
            this._design.Slot_02.Slot_Default.visible = false;
            saleSlotRight = new SaleSlot(this._design.Slot_02.Slot_Selected,dailyNewsData.saleRight,this);
         }
         else
         {
            this._design.Slot_02.Slot_Selected.visible = false;
            megaPackSlotRight = new MegaPackSlot(this._design.Slot_02.Slot_Default,ItemManager.getItemData("DemolitionPack"),this);
         }
         addSlot = new AddSlot(this._design,dailyNewsData.addDatas);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         if(_closeButton)
         {
            _closeButton.dispose();
            _closeButton = null;
         }
         if(_giftsButton)
         {
            _giftsButton.dispose();
            _giftsButton = null;
         }
         if(_inboxButton)
         {
            _inboxButton.dispose();
            _inboxButton = null;
         }
         for each(var icon in _dailyRewardContainers)
         {
            icon.dispose();
         }
         _dailyRewardContainers.splice(0,_dailyRewardContainers.length);
         if(megaPackSlotLeft)
         {
            megaPackSlotLeft.dispose();
            megaPackSlotLeft = null;
         }
         if(megaPackSlotRight)
         {
            megaPackSlotRight.dispose();
            megaPackSlotRight = null;
         }
         if(saleSlotLeft)
         {
            saleSlotLeft.dispose();
            saleSlotLeft = null;
         }
         if(saleSlotRight)
         {
            saleSlotRight.dispose();
            saleSlotRight = null;
         }
         if(addSlot)
         {
            addSlot.dispose();
            addSlot = null;
         }
         super.dispose();
      }
      
      public function dailyRewardInit(game:TuxWarsGame) : void
      {
         var i:int = 0;
         var text:* = null;
         var textValue:* = null;
         var icon:* = null;
         var textMessage:* = null;
         dailyRewardArray = game.player.dailyRewards;
         day = game.player.dailyRewardDay;
         for(i = 0; i < 5; )
         {
            text = ProjectManager.getText("DAILY_REWARD_TEXT");
            textValue = dailyRewardArray[i][1];
            icon = dailyRewardArray[i][0];
            if(day < i - 1)
            {
               textMessage = " ";
            }
            else if(day == i - 1)
            {
               textMessage = ProjectManager.getText("DAILY_REWARD_TEXT_MESSAGE_TOMORROW");
            }
            else
            {
               textMessage = ProjectManager.getText("DAILY_REWARD_TEXT_MESSAGE_COLLECTED");
            }
            _dailyRewardContainers.push(new DailyRewardContainers(game,dailyRewardContainer,i,text + " " + (i + 1),textValue,textMessage,icon,day));
            i++;
         }
      }
      
      private function get dailyNewsLogic() : DailyNewsLogic
      {
         return logic;
      }
      
      private function closePressed(event:MouseEvent) : void
      {
         dailyNewsLogic.exit();
      }
      
      private function giftsPressed(event:MouseEvent) : void
      {
         dailyNewsLogic.openGifts();
      }
      
      private function inboxPressed(event:MouseEvent) : void
      {
         dailyNewsLogic.openInbox();
      }
      
      private function slotMachinePressed(event:MouseEvent) : void
      {
         dailyNewsLogic.openSlotMachine();
      }
      
      private function get dailyNewsData() : DailyNewsData
      {
         return params;
      }
   }
}
