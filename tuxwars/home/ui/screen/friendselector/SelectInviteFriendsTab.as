package tuxwars.home.ui.screen.friendselector
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class SelectInviteFriendsTab extends SelectFriendsTab
   {
       
      
      private var mDescText:TextField;
      
      public function SelectInviteFriendsTab(newDesign:Sprite, giftingInfo:GiftingInfo)
      {
         mDescText = new TextField();
         super(newDesign,giftingInfo);
         this._design.visible = false;
      }
      
      public function setData(list:Array, selectorData:MultipleFriendSelectorData, callback:Function) : void
      {
         mFilters = parseFilters(list);
         mCallback = callback;
         setSelectorData(selectorData);
         activateByTabName("Tab_0" + 1);
         this._design.visible = true;
      }
   }
}
