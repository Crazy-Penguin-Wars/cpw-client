package tuxwars.ui.components
{
   import com.dchoc.ui.buttons.UIToggleButton;
   import flash.display.MovieClip;
   
   public class IconToggleButton extends UIToggleButton
   {
      
      private static const CONTAINER_ICON:String = "Container_Icon";
       
      
      private var icon:MovieClip;
      
      public function IconToggleButton(design:MovieClip, parameter:Object = null, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
      }
      
      override public function dispose() : void
      {
         if(icon && getIconContainer().contains(icon))
         {
            getIconContainer().removeChild(icon);
         }
         icon = null;
         super.dispose();
      }
      
      public function setIcon(icon:MovieClip) : void
      {
         if(this.icon && getIconContainer().contains(this.icon))
         {
            getIconContainer().removeChild(this.icon);
         }
         this.icon = icon;
         updateTextField();
      }
      
      override protected function updateTextField() : void
      {
         super.updateTextField();
         if(icon && !getIconContainer().contains(icon))
         {
            getIconContainer().addChild(icon);
         }
      }
      
      public function getIconContainer(childName:String = null) : MovieClip
      {
         if(childName == null)
         {
            return getDesignMovieClip().getChildByName("Container_Icon") as MovieClip;
         }
         return getDesignMovieClip().getChildByName(childName) as MovieClip;
      }
   }
}
