package tuxwars.home.ui.screen.gifts.container
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.net.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class GiftSend extends GiftBase
   {
      private var send:UIButton;
      
      private var selectedFriendID:String;
      
      public function GiftSend(param1:MovieClip, param2:GiftReference, param3:TuxWarsGame, param4:String, param5:UIComponent = null)
      {
         var _loc6_:Object = null;
         super(param1,param2,param3,param5);
         this.selectedFriendID = param4;
         if(param3.player.level >= param2.requiredLevel)
         {
            MessageCenter.addListener("GiftStatusChecked",this.giftStatusChecked);
         }
         this.send = TuxUiUtils.createButton(UIButton,param1,"Button_Send",this.sendGift,"Send");
         if(this.selectedFriendID)
         {
            this.send.setVisible(false);
            _loc6_ = {};
            _loc6_.recipient_id = this.selectedFriendID;
            _loc6_.recipients_platform = Config.getPlatform();
            _loc6_.platform = Config.getPlatform();
            _loc6_.uid = param3.player.id;
            MessageCenter.sendMessage("CheckGiftStatus",_loc6_);
         }
         else
         {
            this.send.setVisible(true);
            this.send.setEnabled(true);
         }
      }
      
      private function sendGift(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(this.selectedFriendID)
         {
            _loc2_ = [gift.name];
            _loc3_ = [this.selectedFriendID];
            GiftService.sendGift(gift,"SEND_GIFT","SEND_GIFT_DESC",_loc3_,"InboxNoGifts",null,_loc2_,null);
            this.send.setEnabled(false);
         }
         else
         {
            _loc4_ = {};
            _loc4_.gift_id = gift.id;
            _loc4_.recipients_platform = Config.getPlatform();
            _loc4_.platform = Config.getPlatform();
            _loc4_.uid = game.player.id;
            MessageCenter.sendMessage("CheckGiftStatus",_loc4_);
         }
      }
      
      private function giftStatusChecked(param1:Message) : void
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         this.send.setVisible(true);
         if(!param1.data.gift_status_results)
         {
            if(this.selectedFriendID)
            {
               this.send.setEnabled(true);
            }
            return;
         }
         if(this.selectedFriendID)
         {
            _loc2_ = true;
            _loc3_ = param1.data.gift_status_results.gift_id is Array ? param1.data.gift_status_results.gift_id : [param1.data.gift_status_results.gift_id];
            for each(_loc7_ in _loc3_)
            {
               if(_loc7_ == gift.id)
               {
                  _loc2_ = false;
                  break;
               }
            }
            this.send.setEnabled(_loc2_);
            return;
         }
         if(gift.id != param1.data.gift_status_results.gift_id)
         {
            return;
         }
         var _loc5_:* = "";
         if(param1.data.gift_status_results.recipient_id)
         {
            _loc4_ = param1.data.gift_status_results.recipient_id is Array ? param1.data.gift_status_results.recipient_id : [param1.data.gift_status_results.recipient_id];
            for each(_loc8_ in _loc4_)
            {
               if(_loc5_.length > 0)
               {
                  _loc5_ += ",";
               }
               _loc5_ += Config.getPlatform() + "@" + _loc8_;
            }
         }
         TooltipManager.removeTooltip();
         var _loc6_:Array = [gift.name];
         GiftService.sendGift(gift,"SEND_GIFT","SEND_GIFT_DESC",null,"InboxNoGifts",null,_loc6_,null,_loc5_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("GiftStatusChecked",this.giftStatusChecked);
         this.send.dispose();
         this.send = null;
      }
   }
}

