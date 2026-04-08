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
      
      public function MultipleFriendSelectorData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String)
      {
         super();
         this.mHeader = param1;
         this.mDescription = param2;
         this.mImageDescription = param3;
         this.mIconFile = param4;
         this.mIconClipName = param5;
         this.mButtonText = param6;
         this.mSelectionDescription = param7;
         this.mSelectionMessage = param8;
      }
      
      public function getHeader() : String
      {
         return this.mHeader;
      }
      
      public function getDescription() : String
      {
         return this.mDescription;
      }
      
      public function getImageDescription() : String
      {
         return this.mImageDescription;
      }
      
      public function getIconFile() : String
      {
         return this.mIconFile;
      }
      
      public function getIconName() : String
      {
         return this.mIconClipName;
      }
      
      public function getButtonText() : String
      {
         return this.mButtonText;
      }
      
      public function getSelectionDescription() : String
      {
         return this.mSelectionDescription;
      }
      
      public function getSelectionMessage() : String
      {
         return this.mSelectionMessage;
      }
   }
}

