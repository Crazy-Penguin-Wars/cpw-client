package tuxwars.ui.popups.screen
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   
   public class PopUpBaseImageScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      private var loader:URLResourceLoader;
      
      public function PopUpBaseImageScreen(param1:TuxWarsGame, param2:String = "flash/ui/popups.swf", param3:String = "popup_message")
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         if(this.loader != null)
         {
            this.loader.dispose();
            this.loader = null;
         }
         super.dispose();
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         var _loc2_:String = this.popupDataID;
         if(_loc2_)
         {
            headerField.setText(PopUpData.getTitle(_loc2_,this.tidTitleParams));
            messageField.setText(PopUpData.getDescription(_loc2_,this.tidDescriptionParams));
         }
         this.loader = ResourceLoaderURL.getInstance().load(this);
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
         return PopUpData.getPicture(this.popupDataID);
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

