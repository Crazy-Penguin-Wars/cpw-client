package tuxwars.home.ui.screen.friendselector
{
   import flash.display.Sprite;
   import flash.text.*;
   
   public class SelectInviteFriendsTab extends SelectFriendsTab
   {
      private var mDescText:TextField = new TextField();
      
      public function SelectInviteFriendsTab(param1:Sprite, param2:GiftingInfo)
      {
         super(param1,param2);
         this._design.visible = false;
      }
      
      public function setData(param1:Array, param2:MultipleFriendSelectorData, param3:Function) : void
      {
         mFilters = parseFilters(param1);
         mCallback = param3;
         setSelectorData(param2);
         activateByTabName("Tab_0" + 1);
         this._design.visible = true;
      }
   }
}

