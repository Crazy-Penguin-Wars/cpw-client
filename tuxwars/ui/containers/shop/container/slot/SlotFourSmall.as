package tuxwars.ui.containers.shop.container.slot
{
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.BigShopItem;
   import tuxwars.ui.containers.shop.IShopTutorial;
   import tuxwars.ui.containers.shop.container.Container;
   import tuxwars.ui.containers.shop.container.item.ItemButton;
   
   public class SlotFourSmall extends Container implements IShopTutorial
   {
      
      private static const NUMBER_OF_SLOTS:int = 4;
      
      private static const SLOT:String = "Slot_0";
       
      
      private var _content:Vector.<ItemButton>;
      
      public function SlotFourSmall(design:MovieClip, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         var i:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         super(design,data,game,parent);
         if(data is Array)
         {
            if((data as Array).length > 0 && (data as Array).length < 5)
            {
               if(!(data[0] is BigShopItem))
               {
                  _content = new Vector.<ItemButton>();
                  for(i = 0; i < 4; )
                  {
                     _loc6_ = design.getChildByName("Slot_0" + (i + 1)) as MovieClip;
                     if(data[i] != null && (data as Array).length > i)
                     {
                        _loc5_ = new ItemButton(_loc6_,[data[i]],game,parent);
                        _loc5_.shown();
                        _content.push(_loc5_);
                        _loc6_.visible = true;
                     }
                     else
                     {
                        _loc6_.visible = false;
                     }
                     i++;
                  }
               }
            }
            else
            {
               LogUtils.log("Data lenght is not in range of 1 to 4",this,2,"UI",true,false,true);
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_content)
         {
            for each(var ib in _content)
            {
               ib.dispose();
            }
            _content = null;
         }
         super.dispose();
      }
      
      public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         if(_content)
         {
            for each(var ist in _content)
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
