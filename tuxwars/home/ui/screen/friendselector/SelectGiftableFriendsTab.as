package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.ui.text.*;
   import com.dchoc.utils.*;
   import flash.display.Sprite;
   import flash.text.*;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   
   public class SelectGiftableFriendsTab extends SelectFriendsTab
   {
      private var mItemText:UIAutoTextField;
      
      public function SelectGiftableFriendsTab(param1:Sprite, param2:GiftingInfo)
      {
         super(param1,param2);
      }
      
      public function setData(param1:Array, param2:GiftReference, param3:MultipleFriendSelectorData, param4:Function) : void
      {
         mFilters = parseFilters(param1);
         mCallback = param4;
         setSelectorData(param3);
         DCUtils.replaceDisplayObject(mIconHolder,param2.iconMovieClip);
         mIconHolder.visible = true;
         this.mItemText = new UIAutoTextField(getDesignMovieClip().getChildByName("Text_Item") as TextField);
         this.mItemText.setText(param2.name);
         activateByTabName("Tab_0" + 1);
         this._design.visible = true;
      }
   }
}

