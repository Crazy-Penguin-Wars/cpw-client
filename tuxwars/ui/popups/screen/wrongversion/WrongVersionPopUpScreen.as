package tuxwars.ui.popups.screen.wrongversion
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.wrongversion.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class WrongVersionPopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      private var loader:URLResourceLoader;
      
      public function WrongVersionPopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_message");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         messageField.setText(this.wrongVersionLogic.description);
         headerField.setText(this.wrongVersionLogic.header);
         okButton.setText(ProjectManager.getText("RELOAD_PAGE"));
         this.loader = ResourceLoaderURL.getInstance().load(this);
      }
      
      private function get wrongVersionLogic() : WrongVersionPopUpLogic
      {
         return logic as WrongVersionPopUpLogic;
      }
      
      public function getResourceUrl() : String
      {
         return this.wrongVersionLogic.picture;
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

