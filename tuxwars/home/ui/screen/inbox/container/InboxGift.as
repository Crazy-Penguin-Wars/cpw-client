package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.battle.ui.screen.result.awards.container.ItemSlot;
   import tuxwars.home.ui.logic.gifts.GiftManager;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.net.GiftService;
   import tuxwars.utils.TuxUiUtils;
   
   public class InboxGift extends InboxCore
   {
      
      public static const MYSTERY_GIFT_ID:String = "MysteryGift";
       
      
      private var claim:UIButton;
      
      private var sendBack:UIButton;
      
      private var icon:MovieClip;
      
      private var itemSlot:ItemSlot;
      
      private var receivedGift:String;
      
      public function InboxGift(requestDataObj:RequestData, design:MovieClip, parent:UIComponent = null)
      {
         super(requestDataObj,design,"","",null,null,parent);
         var _loc4_:MovieClip = design.getChildByName("Container_Buttons") as MovieClip;
         claim = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Claim",claimPressed,"BUTTON_CLAIM");
         claim.setShowTransitions(false);
         claim.setVisible(requestData.state == "New");
         claim.setShowTransitions(true);
         sendBack = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Send_Back",sendBackPressed,"BUTTON_SEND_BACK");
         sendBack.setShowTransitions(false);
         sendBack.setVisible(false);
         sendBack.setShowTransitions(true);
      }
      
      override public function dispose() : void
      {
         if(icon)
         {
            icon.addFrameScript(DCUtils.indexOfLabel(icon,"Stop"),null);
         }
         MessageCenter.removeListener("InboxGiftAcceptReceipt",requestReceiptReceived);
         MessageCenter.removeListener("CanSendGiftBackToSenderChecked",giftStatusChecked);
         if(claim)
         {
            claim.dispose();
         }
         if(sendBack)
         {
            sendBack.dispose();
         }
         super.dispose();
      }
      
      override public function setFriend(friend:Friend, playerID:String) : void
      {
         var _loc3_:* = null;
         super.setFriend(friend,playerID);
         if(requestData.type == "Gifts_Default")
         {
            MessageCenter.addListener("InboxGiftAcceptReceipt",requestReceiptReceived);
            MessageCenter.addListener("CanSendGiftBackToSenderChecked",giftStatusChecked);
            _loc3_ = GiftManager.getGiftReference(requestData.giftID);
            setGift(_loc3_,ProjectManager.getText("GIFT_RECEIVE_TITLE",[friend.name,_loc3_.name]));
            receivedGift = null;
            setSendBackAvailability();
         }
      }
      
      private function setSendBackAvailability() : void
      {
         var _loc1_:* = null;
         if(requestData.state == "Accepted")
         {
            _loc1_ = {};
            _loc1_.request_id = requestData.requestID;
            _loc1_.recipient_id = getPlayerID();
            MessageCenter.sendMessage("CanSendGiftBackToSender",_loc1_);
         }
         else if(requestData.state == "HideManually")
         {
            sendBack.setText(ProjectManager.getText("BUTTON_HIDE"));
            sendBack.setMouseClickFunction(updateContent);
            sendBack.setVisible(true);
         }
         else
         {
            sendBack.setVisible(false);
         }
      }
      
      private function giftStatusChecked(msg:Message) : void
      {
         if(msg.data.request_id != requestData.requestID)
         {
            return;
         }
         if(requestData.feedRewardGift)
         {
            requestData.state = "HideManually";
            sendBack.setText(ProjectManager.getText("BUTTON_HIDE"));
            sendBack.setMouseClickFunction(updateContent);
            sendBack.setVisible(true);
         }
         else if(msg.data.can_send_gift_back == null)
         {
            LogUtils.log("CheckGiftStatus data not found for the gift: " + requestData.giftID + ", request_id:" + requestData.requestID,"InboxGift",2,"Inbox");
            requestData.state = "Accepted";
            sendBack.setVisible(true);
         }
         else if(!msg.data.can_send_gift_back)
         {
            if(requestData.giftID == "MysteryGift")
            {
               requestData.state = "HideManually";
               sendBack.setText(ProjectManager.getText("BUTTON_HIDE"));
               sendBack.setMouseClickFunction(updateContent);
               sendBack.setVisible(true);
            }
            else
            {
               requestData.state = "Done";
               sendBack.setVisible(false);
               updateContent(null);
            }
         }
         else
         {
            requestData.state = "Accepted";
            sendBack.setVisible(true);
         }
         MessageCenter.removeListener("CanSendGiftBackToSenderChecked",giftStatusChecked);
      }
      
      private function claimPressed(event:MouseEvent) : void
      {
         if(requestData.data && requestData.state == "New")
         {
            claim.setVisible(false);
            requestData.state = "Accepted";
            MessageCenter.sendMessage("InboxGiftAccept",requestData);
            claim.dispose();
            claim = null;
            setSendBackAvailability();
         }
      }
      
      private function requestReceiptReceived(msg:Message) : void
      {
         if(requestData.requestID != msg.data.request_id)
         {
            return;
         }
         receivedGift = msg.data.received;
         if(receivedGift && requestData.giftID == "MysteryGift")
         {
            icon.addFrameScript(DCUtils.indexOfLabel(icon,"Stop"),revealMysteryGift);
            icon.play();
         }
      }
      
      private function sendBackPressed(event:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(requestData.state != "Done")
         {
            _loc2_ = [getFriend().platformId];
            _loc3_ = GiftManager.getGiftReference(requestData.giftID);
            GiftService.sendGift(_loc3_,"SEND_GIFT","SEND_GIFT_DESC",_loc2_,"InboxGiftSendBack",[],[_loc3_.name]);
            requestData.state = "Done";
            updateContent(null);
         }
      }
      
      private function updateContent(event:MouseEvent) : void
      {
         if(sendBack)
         {
            sendBack.setVisible(false);
            sendBack.dispose();
            sendBack = null;
            if(requestData.state == "HideManually")
            {
               requestData.state = "Done";
            }
         }
         MessageCenter.sendMessage("InboxContentUpdate");
      }
      
      private function setGift(giftReference:GiftReference, giftTitle:String) : void
      {
         if(giftReference)
         {
            title = giftTitle;
            description = giftReference.description;
            itemSlot = new ItemSlot(this._design.Slot.Item,(parent as TuxUIScreen).tuxGame,false);
            icon = giftReference.iconMovieClip;
            if(giftReference.id == "MysteryGift")
            {
               icon.gotoAndStop("Default");
               itemSlot.itemName = giftReference.name;
               itemSlot.itemDescription = giftReference.description;
            }
            else if(giftReference.itemData)
            {
               itemSlot.itemName = giftReference.itemData.name;
               itemSlot.itemDescription = giftReference.itemData.description;
            }
            itemSlot.icon = icon;
            itemSlot.amount = 1;
            show("Item",1);
         }
      }
      
      private function revealMysteryGift() : void
      {
         icon.stop();
         icon.addFrameScript(DCUtils.indexOfLabel(icon,"Stop"),null);
         var _loc1_:GiftReference = GiftManager.getGiftReference(receivedGift);
         switch(_loc1_.type)
         {
            case "Coins":
               show("Coins",_loc1_.amount);
               break;
            case "Cash":
               show("Cash",_loc1_.amount);
               break;
            case "Exp":
               show("Exp",_loc1_.amount);
               break;
            case "Item":
               setGift(_loc1_,_loc1_.name);
         }
         title = _loc1_.name;
         description = _loc1_.description;
      }
      
      private function show(childName:String, amount:int) : void
      {
         this._design.Slot.Item.visible = false;
         this._design.Slot.Coins.visible = false;
         this._design.Slot.Cash.visible = false;
         this._design.Slot.Exp.visible = false;
         var _loc3_:MovieClip = this._design.Slot.getChildByName(childName) as MovieClip;
         _loc3_.visible = true;
         if(_loc3_.Text_Exp)
         {
            _loc3_.Text_Exp.text = amount.toString();
         }
         else
         {
            _loc3_.Text.text = amount.toString();
         }
      }
   }
}
