package tuxwars.ui.containers.shop.container.slot
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.containers.shop.ContentSizeFour;
   import tuxwars.ui.containers.shop.IShopTutorial;
   import tuxwars.ui.containers.shop.container.Container;
   
   public class SlotsBig extends Container implements IShopTutorial
   {
      
      private static const SLOT_SIZE:int = 4;
      
      private static const CONTAINER:String = "Container_0";
       
      
      private var _containers:Vector.<ContentSizeFour>;
      
      public function SlotsBig(design:DisplayObject, data:*, game:TuxWarsGame, slots:int, parent:TuxUIScreen = null)
      {
         var i:int = 0;
         var mc:* = null;
         var dataArray:* = null;
         var size:int = 0;
         super(design,data,game,parent);
         _containers = new Vector.<ContentSizeFour>();
         var dataIndex:int = 0;
         for(i = 1; i < slots + 1; )
         {
            mc = getDesignMovieClip().getChildByName("Container_0" + i) as MovieClip;
            if(mc)
            {
               if((data as Array).length > 1)
               {
                  dataArray = [];
                  size = 0;
                  while(size < 4 && (data as Array).length > dataIndex)
                  {
                     dataArray.push(data[dataIndex]);
                     size += !!(data[dataIndex] as ShopItem) ? (data[dataIndex] as ShopItem).size : 1;
                     dataIndex++;
                  }
                  _containers.push(new ContentSizeFour(mc,dataArray.length > 0 ? dataArray : null,game,parent));
               }
               else
               {
                  _containers.push(new ContentSizeFour(mc,data,game,parent));
               }
            }
            i++;
         }
      }
      
      override public function dispose() : void
      {
         if(_containers)
         {
            for each(var cfs in _containers)
            {
               cfs.dispose();
            }
         }
         _containers = null;
         super.dispose();
      }
      
      public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         if(_containers)
         {
            for each(var ist in _containers)
            {
               if(ist is IShopTutorial)
               {
                  (ist as IShopTutorial).activateTutorial(itemID,arrow,addTutorialArrow);
               }
            }
         }
      }
   }
}
