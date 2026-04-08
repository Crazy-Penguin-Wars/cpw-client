package tuxwars.items
{
   import com.dchoc.ui.base.UIStateComponent;
   import flash.display.DisplayObject;
   
   public class EmoticonItemGraphic extends UIStateComponent
   {
      public function EmoticonItemGraphic(param1:DisplayObject)
      {
         super(param1);
         setShowTransitions(false);
         setVisible(false);
         setShowTransitions(true);
      }
      
      override public function dispose() : void
      {
         setVisible(false);
         super.dispose();
      }
   }
}

