package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.battle.ui.screen.result.awards.container.*;
   import tuxwars.home.ui.logic.gifts.*;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.home.ui.screen.*;
   import tuxwars.net.*;
   import tuxwars.utils.*;
   
   public class InboxGift extends InboxCore
   {
      public static const MYSTERY_GIFT_ID:String = "MysteryGift";
      
      private var claim:UIButton;
      
      private var sendBack:UIButton;
      
      private var icon:MovieClip;
      
      private var itemSlot:ItemSlot;
      
      private var receivedGift:String;
      
      public function InboxGift(param1:RequestData, param2:MovieClip, param3:UIComponent = null)
      {
         super(param1,param2,"","",null,null,param3);
         var _loc4_:MovieClip = param2.getChildByName("Container_Buttons") as MovieClip;
         this.claim = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Claim",this.claimPressed,"BUTTON_CLAIM");
         this.claim.setShowTransitions(false);
         this.claim.setVisible(requestData.state == "New");
         this.claim.setShowTransitions(true);
         this.sendBack = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Send_Back",this.sendBackPressed,"BUTTON_SEND_BACK");
         this.sendBack.setShowTransitions(false);
         this.sendBack.setVisible(false);
         this.sendBack.setShowTransitions(true);
      }
      
      override public function dispose() : void
      {
         if(this.icon)
         {
            this.icon.addFrameScript(DCUtils.indexOfLabel(this.icon,"Stop"),null);
         }
         MessageCenter.removeListener("InboxGiftAcceptReceipt",this.requestReceiptReceived);
         MessageCenter.removeListener("CanSendGiftBackToSenderChecked",this.giftStatusChecked);
         if(this.claim)
         {
            this.claim.dispose();
         }
         if(this.sendBack)
         {
            this.sendBack.dispose();
         }
         super.dispose();
      }
      
      override public function setFriend(param1:Friend, param2:String) : void
      {
         var _loc3_:GiftReference = null;
         super.setFriend(param1,param2);
         if(requestData.type == "Gifts_Default")
         {
            MessageCenter.addListener("InboxGiftAcceptReceipt",this.requestReceiptReceived);
            MessageCenter.addListener("CanSendGiftBackToSenderChecked",this.giftStatusChecked);
            _loc3_ = GiftManager.getGiftReference(requestData.giftID);
            this.setGift(_loc3_,ProjectManager.getText("GIFT_RECEIVE_TITLE",[param1.name,_loc3_.name]));
            this.receivedGift = null;
            this.setSendBackAvailability();
         }
      }
      
      private function setSendBackAvailability() : void
      {
         var _loc1_:Object = null;
         if(requestData.state == "Accepted")
         {
            _loc1_ = {};
            _loc1_.request_id = requestData.requestID;
            _loc1_.recipient_id = getPlayerID();
            MessageCenter.sendMessage("CanSendGiftBackToSender",_loc1_);
         }
         else if(requestData.state == "HideManually")
         {
            this.sendBack.setText(ProjectManager.getText("BUTTON_HIDE"));
            this.sendBack.setMouseClickFunction(this.updateContent);
            this.sendBack.setVisible(true);
         }
         else
         {
            this.sendBack.setVisible(false);
         }
      }
      
      private function giftStatusChecked(param1:Message) : void
      {
         if(param1.data.request_id != requestData.requestID)
         {
            return;
         }
         if(requestData.feedRewardGift)
         {
            requestData.state = "HideManually";
            this.sendBack.setText(ProjectManager.getText("BUTTON_HIDE"));
            this.sendBack.setMouseClickFunction(this.updateContent);
            this.sendBack.setVisible(true);
         }
         else if(param1.data.can_send_gift_back == null)
         {
            LogUtils.log("CheckGiftStatus data not found for the gift: " + requestData.giftID + ", request_id:" + requestData.requestID,"InboxGift",2,"Inbox");
            requestData.state = "Accepted";
            this.sendBack.setVisible(true);
         }
         else if(!param1.data.can_send_gift_back)
         {
            if(requestData.giftID == "MysteryGift")
            {
               requestData.state = "HideManually";
               this.sendBack.setText(ProjectManager.getText("BUTTON_HIDE"));
               this.sendBack.setMouseClickFunction(this.updateContent);
               this.sendBack.setVisible(true);
            }
            else
            {
               requestData.state = "Done";
               this.sendBack.setVisible(false);
               this.updateContent(null);
            }
         }
         else
         {
            requestData.state = "Accepted";
            this.sendBack.setVisible(true);
         }
         MessageCenter.removeListener("CanSendGiftBackToSenderChecked",this.giftStatusChecked);
      }
      
      private function claimPressed(param1:MouseEvent) : void
      {
         if(Boolean(requestData.data) && requestData.state == "New")
         {
            this.claim.setVisible(false);
            requestData.state = "Accepted";
            MessageCenter.sendMessage("InboxGiftAccept",requestData);
            this.claim.dispose();
            this.claim = null;
            this.setSendBackAvailability();
         }
      }
      
      private function requestReceiptReceived(param1:Message) : void
      {
         if(requestData.requestID != param1.data.request_id)
         {
            return;
         }
         this.receivedGift = param1.data.received;
         if(Boolean(this.receivedGift) && requestData.giftID == "MysteryGift")
         {
            this.icon.addFrameScript(DCUtils.indexOfLabel(this.icon,"Stop"),this.revealMysteryGift);
            this.icon.play();
         }
      }
      
      private function sendBackPressed(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:GiftReference = null;
         if(requestData.state != "Done")
         {
            _loc2_ = [getFriend().platformId];
            _loc3_ = GiftManager.getGiftReference(requestData.giftID);
            GiftService.sendGift(_loc3_,"SEND_GIFT","SEND_GIFT_DESC",_loc2_,"InboxGiftSendBack",[],[_loc3_.name]);
            requestData.state = "Done";
            this.updateContent(null);
         }
      }
      
      private function updateContent(param1:MouseEvent) : void
      {
         if(this.sendBack)
         {
            this.sendBack.setVisible(false);
            this.sendBack.dispose();
            this.sendBack = null;
            if(requestData.state == "HideManually")
            {
               requestData.state = "Done";
            }
         }
         MessageCenter.sendMessage("InboxContentUpdate");
      }
      
      private function setGift(param1:GiftReference, param2:String) : void
      {
         if(param1)
         {
            title = param2;
            description = param1.description;
            this.itemSlot = new ItemSlot(this._design.Slot.Item,(parent as TuxUIScreen).tuxGame,false);
            this.icon = param1.iconMovieClip;
            if(param1.id == "MysteryGift")
            {
               this.icon.gotoAndStop("Default");
               this.itemSlot.itemName = param1.name;
               this.itemSlot.itemDescription = param1.description;
            }
            else if(param1.itemData)
            {
               this.itemSlot.itemName = param1.itemData.name;
               this.itemSlot.itemDescription = param1.itemData.description;
            }
            this.itemSlot.icon = this.icon;
            this.itemSlot.amount = 1;
            this.show("Item",1);
         }
      }
      
      private function revealMysteryGift() : void
      {
         this.icon.stop();
         this.icon.addFrameScript(DCUtils.indexOfLabel(this.icon,"Stop"),null);
         var _loc1_:GiftReference = GiftManager.getGiftReference(this.receivedGift);
         switch(_loc1_.type)
         {
            case "Coins":
               this.show("Coins",_loc1_.amount);
               break;
            case "Cash":
               this.show("Cash",_loc1_.amount);
               break;
            case "Exp":
               this.show("Exp",_loc1_.amount);
               break;
            case "Item":
               this.setGift(_loc1_,_loc1_.name);
         }
         title = _loc1_.name;
         description = _loc1_.description;
      }
      
      private function show(param1:String, param2:int) : void
      {
         this._design.Slot.Item.visible = false;
         this._design.Slot.Coins.visible = false;
         this._design.Slot.Cash.visible = false;
         this._design.Slot.Exp.visible = false;
         var _loc3_:MovieClip = this._design.Slot.getChildByName(param1) as MovieClip;
         _loc3_.visible = true;
         if(_loc3_.Text_Exp)
         {
            _loc3_.Text_Exp.text = param2.toString();
         }
         else
         {
            _loc3_.Text.text = param2.toString();
         }
      }
   }
}

