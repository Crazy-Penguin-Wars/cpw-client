package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.friendselector.FriendSelectorLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.net.*;
   import tuxwars.utils.*;
   
   public class FriendSelectorScreen extends TuxUIScreen
   {
      private static const CLOSE_BUTTON:String = "Button_Close";
      
      private var _closeButton:UIButton;
      
      private var mContent:SelectFriendsTab;
      
      private var mReadyCallback:Function = null;
      
      public function FriendSelectorScreen(param1:TuxWarsGame, param2:String)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/select_friends.swf",param2));
         var _loc3_:MovieClip = getDesignMovieClip();
         this._closeButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Close",this.closePressed);
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         var _loc2_:SendRequestObject = SendRequestObject(param1);
         this.mReadyCallback = _loc2_.callback;
         var _loc3_:String = _loc2_.type;
         if(_loc3_ == "INVITE")
         {
            this.mContent = new SelectInviteFriendsTab(this._design as Sprite,tuxGame.giftingInfo);
            SelectInviteFriendsTab(this.mContent).setData(this.friendSelectorLogic.getTabsContent(_loc2_),this.friendSelectorLogic.data,this.selectionButtonClick);
         }
         else if(_loc3_ == "GIFT")
         {
            this.mContent = new SelectGiftableFriendsTab(this._design as Sprite,tuxGame.giftingInfo);
            SelectGiftableFriendsTab(this.mContent).setData(this.friendSelectorLogic.getTabsContent(_loc2_),_loc2_.giftReference,this.friendSelectorLogic.data,this.selectionButtonClick);
         }
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         this.mContent.clean();
      }
      
      private function get friendSelectorLogic() : FriendSelectorLogic
      {
         return logic;
      }
      
      private function closePressed(param1:MouseEvent) : void
      {
         close();
      }
      
      private function selectionButtonClick(param1:Vector.<Object>) : void
      {
         if(param1.length <= 50)
         {
            this.closePressed(null);
         }
         if(this.mReadyCallback != null)
         {
            this.mReadyCallback(SelectFriendsTab.handleFriendsList(param1),params);
         }
      }
   }
}

