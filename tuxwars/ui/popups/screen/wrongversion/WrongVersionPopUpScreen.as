package tuxwars.ui.popups.screen.wrongversion
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.wrongversion.WrongVersionPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class WrongVersionPopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
       
      
      private var loader:URLResourceLoader;
      
      public function WrongVersionPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_message");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         messageField.setText(wrongVersionLogic.description);
         headerField.setText(wrongVersionLogic.header);
         okButton.setText(ProjectManager.getText("RELOAD_PAGE"));
         loader = ResourceLoaderURL.getInstance().load(this);
      }
      
      private function get wrongVersionLogic() : WrongVersionPopUpLogic
      {
         return logic as WrongVersionPopUpLogic;
      }
      
      public function getResourceUrl() : String
      {
         return wrongVersionLogic.picture;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      override public function exit() : void
      {
         super.exit();
         DCUtils.refreshPage();
      }
   }
}
