package tuxwars.home.ui.screen.gifts.container
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.utils.*;
   
   public class GiftLock extends GiftBase
   {
      private var levelText:UIAutoTextField;
      
      private var selectedFriendID:String;
      
      public function GiftLock(param1:MovieClip, param2:GiftReference, param3:TuxWarsGame, param4:String, param5:UIComponent = null)
      {
         super(param1,param2,param3,param5);
         this.selectedFriendID = param4;
         this.levelText = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Level") as TextField,param2.requiredLevel.toString());
      }
      
      private function sendGift(param1:MouseEvent) : void
      {
         LogUtils.log("What is the unlock supposed to do ? clear this up. (pay to be able to send gifts earleir to friends?)",this,2,"Gift",false,true,true);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

