package tuxwars.ui.containers.shop.container.slot
{
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.*;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.containers.shop.container.Container;
   import tuxwars.ui.containers.shop.container.item.*;
   
   public class SlotFourSmall extends Container implements IShopTutorial
   {
      private static const NUMBER_OF_SLOTS:int = 4;
      
      private static const SLOT:String = "Slot_0";
      
      private var _content:Vector.<ItemButton>;
      
      public function SlotFourSmall(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:ItemButton = null;
         super(param1,param2,param3,param4);
         if(param2 is Array)
         {
            if((param2 as Array).length > 0 && (param2 as Array).length < 5)
            {
               if(!(param2[0] is BigShopItem))
               {
                  this._content = new Vector.<ItemButton>();
                  _loc5_ = 0;
                  while(_loc5_ < 4)
                  {
                     _loc6_ = param1.getChildByName("Slot_0" + (_loc5_ + 1)) as MovieClip;
                     if(param2[_loc5_] != null && (param2 as Array).length > _loc5_)
                     {
                        _loc7_ = new ItemButton(_loc6_,[param2[_loc5_]],param3,param4);
                        _loc7_.shown();
                        this._content.push(_loc7_);
                        _loc6_.visible = true;
                     }
                     else
                     {
                        _loc6_.visible = false;
                     }
                     _loc5_++;
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
         var _loc1_:* = undefined;
         if(this._content)
         {
            for each(_loc1_ in this._content)
            {
               _loc1_.dispose();
            }
            this._content = null;
         }
         super.dispose();
      }
      
      public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:* = undefined;
         if(this._content)
         {
            for each(_loc4_ in this._content)
            {
               if(_loc4_ is IShopTutorial)
               {
                  (_loc4_ as IShopTutorial).activateTutorial(param1,param2,param3);
               }
            }
         }
      }
   }
}

