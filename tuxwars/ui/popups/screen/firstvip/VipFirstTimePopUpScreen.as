package tuxwars.ui.popups.screen.firstvip
{
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.firstvip.VipFirstTimePopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class VipFirstTimePopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      
      private static const IMAGE_CONTAINER:String = "Container_Image";
       
      
      private var loader:URLResourceLoader;
      
      public function VipFirstTimePopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_free_vip");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         headerField.setText(vipLogic.headerText);
         messageField.setText(vipLogic.messageText);
         if(vipLogic.picture)
         {
            loader = ResourceLoaderURL.getInstance().load(this);
         }
      }
      
      public function getResourceUrl() : String
      {
         return vipLogic.picture;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function get vipLogic() : VipFirstTimePopUpLogic
      {
         return logic as VipFirstTimePopUpLogic;
      }
   }
}
