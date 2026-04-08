package tuxwars.ui.popups.screen.message
{
   import com.dchoc.resources.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.message.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class MessagePopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      private static const IMAGE_CONTAINER:String = "Container_Image";
      
      private var loader:URLResourceLoader;
      
      public function MessagePopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_message");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         headerField.setText(this.messageLogic.headerText);
         messageField.setText(this.messageLogic.messageText);
         if(this.messageLogic.picture)
         {
            this.loader = ResourceLoaderURL.getInstance().load(this);
         }
      }
      
      public function getResourceUrl() : String
      {
         return this.messageLogic.picture;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function get messageLogic() : MessagePopUpLogic
      {
         return logic as MessagePopUpLogic;
      }
   }
}

