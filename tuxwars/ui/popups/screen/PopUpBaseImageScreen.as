package tuxwars.ui.popups.screen
{
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PopUpData;
   
   public class PopUpBaseImageScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
       
      
      private var loader:URLResourceLoader;
      
      public function PopUpBaseImageScreen(game:TuxWarsGame, swf:String = "flash/ui/popups.swf", exportName:String = "popup_message")
      {
         super(game,swf,exportName);
      }
      
      override public function dispose() : void
      {
         if(loader != null)
         {
            loader.dispose();
            loader = null;
         }
         super.dispose();
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         var _loc2_:String = popupDataID;
         if(_loc2_)
         {
            headerField.setText(PopUpData.getTitle(_loc2_,tidTitleParams));
            messageField.setText(PopUpData.getDescription(_loc2_,tidDescriptionParams));
         }
         loader = ResourceLoaderURL.getInstance().load(this);
      }
      
      public function get popupDataID() : String
      {
         if(params is String)
         {
            return params;
         }
         if(params && params.popupDataID is String)
         {
            return params.popupDataID;
         }
         LogUtils.log("PopupDataID not configured correctly or missing, using errorpopup_1!",this,2,"Warning",true,false,true);
         return "errorpopup_1";
      }
      
      public function getResourceUrl() : String
      {
         return PopUpData.getPicture(popupDataID);
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      public function get tidDescriptionParams() : Array
      {
         return null;
      }
      
      public function get tidTitleParams() : Array
      {
         return null;
      }
   }
}
