package tuxwars.ui.popups.screen.firstvip
{
   import com.dchoc.resources.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.firstvip.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class VipFirstTimePopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      private static const IMAGE_CONTAINER:String = "Container_Image";
      
      private var loader:URLResourceLoader;
      
      public function VipFirstTimePopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_free_vip");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         headerField.setText(this.vipLogic.headerText);
         messageField.setText(this.vipLogic.messageText);
         if(this.vipLogic.picture)
         {
            this.loader = ResourceLoaderURL.getInstance().load(this);
         }
      }
      
      public function getResourceUrl() : String
      {
         return this.vipLogic.picture;
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

