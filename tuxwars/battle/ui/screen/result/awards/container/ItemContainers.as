package tuxwars.battle.ui.screen.result.awards.container
{
   import com.dchoc.ui.windows.UIContainers;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.ItemData;
   
   public class ItemContainers extends UIContainers
   {
      private static const CONTAINER:String = "Container_Items_";
      
      private var _design:MovieClip;
      
      private var numContainers:int;
      
      public function ItemContainers(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:int = 0;
         super();
         this._design = param1;
         this.numContainers = this.calculateContainers();
         _loc3_ = 1;
         while(_loc3_ <= this.numContainers)
         {
            add("Container_Items_" + _loc3_,new ItemContainer(param1.getChildByName("Container_Items_" + _loc3_) as MovieClip,_loc3_,param2,_loc3_ == this.numContainers));
            _loc3_++;
         }
         setAllVisible(false);
      }
      
      public function init(param1:Vector.<ItemData>) : void
      {
         if(param1.length > 0)
         {
            if(param1.length < this.numContainers)
            {
               show("Container_Items_" + param1.length);
               LogUtils.log("Showing Container: " + ("Container_Items_" + param1.length) + " itemsLenght:" + param1.length,this,0,"UI",false);
            }
            else
            {
               show("Container_Items_" + this.numContainers);
               LogUtils.log("Showing Container: " + ("Container_Items_" + this.numContainers) + " itemsLenght:" + param1.length,this,0,"UI",false);
            }
            (getCurrentContainer() as ItemContainer).init(param1);
         }
      }
      
      private function calculateContainers() : int
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         do
         {
            _loc2_++;
            _loc1_ = this._design.getChildByName("Container_Items_" + _loc2_);
         }
         while(_loc1_);
         
         LogUtils.log("Number of Containers: " + (_loc2_ - 1),this,0,"UI",false);
         return _loc2_ - 1;
      }
   }
}

