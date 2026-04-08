package tuxwars.ui.popups.screen.passedstat
{
   import com.dchoc.resources.*;
   import flash.display.MovieClip;
   import tuxwars.player.TuxFriend;
   import tuxwars.utils.*;
   
   public class PlayerSlot implements IResourceLoaderURL
   {
      private var player:TuxFriend;
      
      private var design:MovieClip;
      
      private var loader:URLResourceLoader;
      
      public function PlayerSlot(param1:MovieClip, param2:TuxFriend)
      {
         super();
         this.design = param1;
         this.player = param2;
         TuxUiUtils.createAutoTextFieldWithText(param1.Text_Name,param2.name);
         if(this.getResourceUrl())
         {
            this.loader = ResourceLoaderURL.getInstance().load(this,null);
            this.getTargetMovieClip().visible = true;
         }
         else
         {
            this.getTargetMovieClip().visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(this.loader)
         {
            this.loader.dispose();
         }
         this.loader = null;
         this.player = null;
      }
      
      public function getResourceUrl() : String
      {
         return !!this.player ? this.player.picUrl : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return this.design.Container_Profile_Picture;
      }
   }
}

