package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import flash.display.Sprite;
   import flash.text.TextField;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   
   public class SelectGiftableFriendsTab extends SelectFriendsTab
   {
       
      
      private var mItemText:UIAutoTextField;
      
      public function SelectGiftableFriendsTab(newDesign:Sprite, giftingInfo:GiftingInfo)
      {
         super(newDesign,giftingInfo);
      }
      
      public function setData(list:Array, gift:GiftReference, selectorData:MultipleFriendSelectorData, callback:Function) : void
      {
         mFilters = parseFilters(list);
         mCallback = callback;
         setSelectorData(selectorData);
         DCUtils.replaceDisplayObject(mIconHolder,gift.iconMovieClip);
         mIconHolder.visible = true;
         mItemText = new UIAutoTextField(getDesignMovieClip().getChildByName("Text_Item") as TextField);
         mItemText.setText(gift.name);
         activateByTabName("Tab_0" + 1);
         this._design.visible = true;
      }
   }
}
