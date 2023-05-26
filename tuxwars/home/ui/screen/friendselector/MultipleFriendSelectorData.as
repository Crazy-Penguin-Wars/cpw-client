package tuxwars.home.ui.screen.friendselector
{
   public class MultipleFriendSelectorData
   {
       
      
      private var mHeader:String;
      
      private var mDescription:String;
      
      private var mImageDescription:String;
      
      private var mIconFile:String;
      
      private var mIconClipName:String;
      
      private var mButtonText:String;
      
      private var mSelectionDescription:String;
      
      private var mSelectionMessage:String;
      
      public function MultipleFriendSelectorData(header:String, description:String, imageDescription:String, iconFile:String, iconClipName:String, buttonText:String, selectionDescription:String, selectionMessage:String)
      {
         super();
         mHeader = header;
         mDescription = description;
         mImageDescription = imageDescription;
         mIconFile = iconFile;
         mIconClipName = iconClipName;
         mButtonText = buttonText;
         mSelectionDescription = selectionDescription;
         mSelectionMessage = selectionMessage;
      }
      
      public function getHeader() : String
      {
         return mHeader;
      }
      
      public function getDescription() : String
      {
         return mDescription;
      }
      
      public function getImageDescription() : String
      {
         return mImageDescription;
      }
      
      public function getIconFile() : String
      {
         return mIconFile;
      }
      
      public function getIconName() : String
      {
         return mIconClipName;
      }
      
      public function getButtonText() : String
      {
         return mButtonText;
      }
      
      public function getSelectionDescription() : String
      {
         return mSelectionDescription;
      }
      
      public function getSelectionMessage() : String
      {
         return mSelectionMessage;
      }
   }
}
