package tuxwars.ui.popups.screen.message
{
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class MessagePopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      
      private static const IMAGE_CONTAINER:String = "Container_Image";
       
      
      private var loader:URLResourceLoader;
      
      public function MessagePopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_message");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         headerField.setText(messageLogic.headerText);
         messageField.setText(messageLogic.messageText);
         if(messageLogic.picture)
         {
            loader = ResourceLoaderURL.getInstance().load(this);
         }
      }
      
      public function getResourceUrl() : String
      {
         return messageLogic.picture;
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
