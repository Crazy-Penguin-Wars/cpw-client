package tuxwars.ui.containers.shop.container.slot
{
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.*;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.containers.shop.container.Container;
   
   public class SlotsBig extends Container implements IShopTutorial
   {
      private static const SLOT_SIZE:int = 4;
      
      private static const CONTAINER:String = "Container_0";
      
      private var _containers:Vector.<ContentSizeFour>;
      
      public function SlotsBig(param1:DisplayObject, param2:*, param3:TuxWarsGame, param4:int, param5:TuxUIScreen = null)
      {
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         super(param1,param2,param3,param5);
         this._containers = new Vector.<ContentSizeFour>();
         var _loc10_:int = 0;
         _loc6_ = 1;
         while(_loc6_ < param4 + 1)
         {
            _loc7_ = getDesignMovieClip().getChildByName("Container_0" + _loc6_) as MovieClip;
            if(_loc7_)
            {
               if((param2 as Array).length > 1)
               {
                  _loc8_ = [];
                  _loc9_ = 0;
                  while(_loc9_ < 4 && (param2 as Array).length > _loc10_)
                  {
                     _loc8_.push(param2[_loc10_]);
                     _loc9_ += !!(param2[_loc10_] as ShopItem) ? (param2[_loc10_] as ShopItem).size : 1;
                     _loc10_++;
                  }
                  this._containers.push(new ContentSizeFour(_loc7_,_loc8_.length > 0 ? _loc8_ : null,param3,param5));
               }
               else
               {
                  this._containers.push(new ContentSizeFour(_loc7_,param2,param3,param5));
               }
            }
            _loc6_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         if(this._containers)
         {
            for each(_loc1_ in this._containers)
            {
               _loc1_.dispose();
            }
         }
         this._containers = null;
         super.dispose();
      }
      
      public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:* = undefined;
         if(this._containers)
         {
            for each(_loc4_ in this._containers)
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

