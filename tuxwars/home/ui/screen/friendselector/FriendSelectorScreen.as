package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.friendselector.FriendSelectorLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.net.SendRequestObject;
   import tuxwars.utils.TuxUiUtils;
   
   public class FriendSelectorScreen extends TuxUIScreen
   {
      
      private static const CLOSE_BUTTON:String = "Button_Close";
       
      
      private var _closeButton:UIButton;
      
      private var mContent:SelectFriendsTab;
      
      private var mReadyCallback:Function = null;
      
      public function FriendSelectorScreen(game:TuxWarsGame, exportName:String)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/select_friends.swf",exportName));
         var _loc3_:MovieClip = getDesignMovieClip();
         _closeButton = TuxUiUtils.createButton(UIButton,_loc3_,"Button_Close",closePressed);
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         var sendRequest:SendRequestObject = SendRequestObject(params);
         mReadyCallback = sendRequest.callback;
         var type:String = sendRequest.type;
         if(type == "INVITE")
         {
            mContent = new SelectInviteFriendsTab(this._design as Sprite,tuxGame.giftingInfo);
            SelectInviteFriendsTab(mContent).setData(friendSelectorLogic.getTabsContent(sendRequest),friendSelectorLogic.data,selectionButtonClick);
         }
         else if(type == "GIFT")
         {
            mContent = new SelectGiftableFriendsTab(this._design as Sprite,tuxGame.giftingInfo);
            SelectGiftableFriendsTab(mContent).setData(friendSelectorLogic.getTabsContent(sendRequest),sendRequest.giftReference,friendSelectorLogic.data,selectionButtonClick);
         }
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         mContent.clean();
      }
      
      private function get friendSelectorLogic() : FriendSelectorLogic
      {
         return logic;
      }
      
      private function closePressed(event:MouseEvent) : void
      {
         close();
      }
      
      private function selectionButtonClick(selectedList:Vector.<Object>) : void
      {
         if(selectedList.length <= 50)
         {
            closePressed(null);
         }
         if(mReadyCallback != null)
         {
            mReadyCallback(SelectFriendsTab.handleFriendsList(selectedList),params);
         }
      }
   }
}
