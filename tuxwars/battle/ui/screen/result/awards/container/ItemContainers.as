package tuxwars.battle.ui.screen.result.awards.container
{
   import com.dchoc.ui.windows.UIContainers;
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.ItemData;
   
   public class ItemContainers extends UIContainers
   {
      
      private static const CONTAINER:String = "Container_Items_";
       
      
      private var _design:MovieClip;
      
      private var numContainers:int;
      
      public function ItemContainers(design:MovieClip, game:TuxWarsGame)
      {
         var i:int = 0;
         super();
         _design = design;
         numContainers = calculateContainers();
         for(i = 1; i <= numContainers; )
         {
            add("Container_Items_" + i,new ItemContainer(design.getChildByName("Container_Items_" + i) as MovieClip,i,game,i == numContainers));
            i++;
         }
         setAllVisible(false);
      }
      
      public function init(items:Vector.<ItemData>) : void
      {
         if(items.length > 0)
         {
            if(items.length < numContainers)
            {
               show("Container_Items_" + items.length);
               LogUtils.log("Showing Container: " + ("Container_Items_" + items.length) + " itemsLenght:" + items.length,this,0,"UI",false);
            }
            else
            {
               show("Container_Items_" + numContainers);
               LogUtils.log("Showing Container: " + ("Container_Items_" + numContainers) + " itemsLenght:" + items.length,this,0,"UI",false);
            }
            (getCurrentContainer() as ItemContainer).init(items);
         }
      }
      
      private function calculateContainers() : int
      {
         var _loc1_:* = null;
         var i:int = 0;
         do
         {
            i++;
            _loc1_ = _design.getChildByName("Container_Items_" + i);
         }
         while(_loc1_);
         
         LogUtils.log("Number of Containers: " + (i - 1),this,0,"UI",false);
         return i - 1;
      }
   }
}
