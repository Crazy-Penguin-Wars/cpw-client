package tuxwars.ui.components
{
   import com.dchoc.ui.buttons.UIToggleButton;
   import flash.display.*;
   
   public class IconToggleButton extends UIToggleButton
   {
      private static const CONTAINER_ICON:String = "Container_Icon";
      
      private var icon:MovieClip;
      
      public function IconToggleButton(param1:MovieClip, param2:Object = null, param3:Boolean = true, param4:Object = null, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function dispose() : void
      {
         if(Boolean(this.icon) && this.getIconContainer().contains(this.icon))
         {
            this.getIconContainer().removeChild(this.icon);
         }
         this.icon = null;
         super.dispose();
      }
      
      public function setIcon(param1:MovieClip) : void
      {
         if(Boolean(this.icon) && this.getIconContainer().contains(this.icon))
         {
            this.getIconContainer().removeChild(this.icon);
         }
         this.icon = param1;
         this.updateTextField();
      }
      
      override protected function updateTextField() : void
      {
         super.updateTextField();
         if(Boolean(this.icon) && !this.getIconContainer().contains(this.icon))
         {
            this.getIconContainer().addChild(this.icon);
         }
      }
      
      public function getIconContainer(param1:String = null) : MovieClip
      {
         if(param1 == null)
         {
            return getDesignMovieClip().getChildByName("Container_Icon") as MovieClip;
         }
         return getDesignMovieClip().getChildByName(param1) as MovieClip;
      }
   }
}

