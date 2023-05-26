package tuxwars.ui.popups.screen.passedstat
{
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import flash.display.MovieClip;
   import tuxwars.player.TuxFriend;
   import tuxwars.utils.TuxUiUtils;
   
   public class PlayerSlot implements IResourceLoaderURL
   {
       
      
      private var player:TuxFriend;
      
      private var design:MovieClip;
      
      private var loader:URLResourceLoader;
      
      public function PlayerSlot(design:MovieClip, player:TuxFriend)
      {
         super();
         this.design = design;
         this.player = player;
         TuxUiUtils.createAutoTextFieldWithText(design.Text_Name,player.name);
         if(getResourceUrl())
         {
            loader = ResourceLoaderURL.getInstance().load(this,null);
            getTargetMovieClip().visible = true;
         }
         else
         {
            getTargetMovieClip().visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(loader)
         {
            loader.dispose();
         }
         loader = null;
         player = null;
      }
      
      public function getResourceUrl() : String
      {
         return !!player ? player.picUrl : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return design.Container_Profile_Picture;
      }
   }
}
