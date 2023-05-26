package tuxwars.home.ui.screen.gifts.container
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.utils.TuxUiUtils;
   
   public class GiftLock extends GiftBase
   {
       
      
      private var levelText:UIAutoTextField;
      
      private var selectedFriendID:String;
      
      public function GiftLock(design:MovieClip, gift:GiftReference, game:TuxWarsGame, friendID:String, parent:UIComponent = null)
      {
         super(design,gift,game,parent);
         selectedFriendID = friendID;
         levelText = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Level") as TextField,gift.requiredLevel.toString());
      }
      
      private function sendGift(event:MouseEvent) : void
      {
         LogUtils.log("What is the unlock supposed to do ? clear this up. (pay to be able to send gifts earleir to friends?)",this,2,"Gift",false,true,true);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
