package tuxwars.home.ui.screen.gifts.container
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.net.GiftService;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class GiftSend extends GiftBase
   {
       
      
      private var send:UIButton;
      
      private var selectedFriendID:String;
      
      public function GiftSend(design:MovieClip, gift:GiftReference, game:TuxWarsGame, friendID:String, parent:UIComponent = null)
      {
         var data:* = null;
         super(design,gift,game,parent);
         selectedFriendID = friendID;
         if(game.player.level >= gift.requiredLevel)
         {
            MessageCenter.addListener("GiftStatusChecked",giftStatusChecked);
         }
         send = TuxUiUtils.createButton(UIButton,design,"Button_Send",sendGift,"Send");
         if(selectedFriendID)
         {
            send.setVisible(false);
            data = {};
            data.recipient_id = selectedFriendID;
            data.recipients_platform = Config.getPlatform();
            data.platform = Config.getPlatform();
            data.uid = game.player.id;
            MessageCenter.sendMessage("CheckGiftStatus",data);
         }
         else
         {
            send.setVisible(true);
            send.setEnabled(true);
         }
      }
      
      private function sendGift(event:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var data:* = null;
         if(selectedFriendID)
         {
            _loc4_ = [gift.name];
            _loc2_ = [selectedFriendID];
            GiftService.sendGift(gift,"SEND_GIFT","SEND_GIFT_DESC",_loc2_,"InboxNoGifts",null,_loc4_,null);
            send.setEnabled(false);
         }
         else
         {
            data = {};
            data.gift_id = gift.id;
            data.recipients_platform = Config.getPlatform();
            data.platform = Config.getPlatform();
            data.uid = game.player.id;
            MessageCenter.sendMessage("CheckGiftStatus",data);
         }
      }
      
      private function giftStatusChecked(msg:Message) : void
      {
         var giftSendable:Boolean = false;
         var _loc6_:* = null;
         var _loc2_:* = null;
         send.setVisible(true);
         if(!msg.data.gift_status_results)
         {
            if(selectedFriendID)
            {
               send.setEnabled(true);
            }
            return;
         }
         if(selectedFriendID)
         {
            giftSendable = true;
            _loc6_ = msg.data.gift_status_results.gift_id is Array ? msg.data.gift_status_results.gift_id : [msg.data.gift_status_results.gift_id];
            for each(var giftId in _loc6_)
            {
               if(giftId == gift.id)
               {
                  giftSendable = false;
                  break;
               }
            }
            send.setEnabled(giftSendable);
            return;
         }
         if(gift.id != msg.data.gift_status_results.gift_id)
         {
            return;
         }
         var excludes:String = "";
         if(msg.data.gift_status_results.recipient_id)
         {
            _loc2_ = msg.data.gift_status_results.recipient_id is Array ? msg.data.gift_status_results.recipient_id : [msg.data.gift_status_results.recipient_id];
            for each(var recipientId in _loc2_)
            {
               if(excludes.length > 0)
               {
                  excludes += ",";
               }
               excludes += Config.getPlatform() + "@" + recipientId;
            }
         }
         TooltipManager.removeTooltip();
         var _loc8_:Array = [gift.name];
         GiftService.sendGift(gift,"SEND_GIFT","SEND_GIFT_DESC",null,"InboxNoGifts",null,_loc8_,null,excludes);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("GiftStatusChecked",giftStatusChecked);
         send.dispose();
         send = null;
      }
   }
}
