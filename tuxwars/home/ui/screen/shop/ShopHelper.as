package tuxwars.home.ui.screen.shop
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import no.olog.utilfunctions.assert;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.BigShopItem;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.components.ObjectContainer;
   
   public class ShopHelper
   {
      
      public static const TYPE:String = "Type";
       
      
      public function ShopHelper()
      {
         super();
      }
      
      public static function initSubTabObjectContainer(contentMoveClip:MovieClip, oldPage:int, game:TuxWarsGame, getButton:Function, shopLogic:IShopLogic) : ObjectContainer
      {
         var objectsOnPage:* = null;
         var emptySlotsToAdd:int = 0;
         var nextBigItemIndex:int = 0;
         var objectPageA:int = 0;
         var roomOnObjectPageA:* = 0;
         var objectPageB:int = 0;
         var roomOnObjectPageB:* = 0;
         var _loc14_:ObjectContainer = new ObjectContainer(contentMoveClip,game,getButton,"transition_slots_left","transition_slots_right",false);
         var _loc15_:Row = shopLogic.getCurrentTab();
         var _loc26_:* = _loc15_;
         if(!_loc26_._cache["Categorys"])
         {
            _loc26_._cache["Categorys"] = com.dchoc.utils.DCUtils.find(_loc26_._fields,"name","Categorys");
         }
         var _loc10_:Field = _loc26_._cache["Categorys"];
         var _loc9_:Vector.<BigShopItem> = shopLogic.getCurrentTabBigItems();
         var _loc27_:* = _loc15_;
         if(!_loc27_._cache["Type"])
         {
            _loc27_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc27_._fields,"name","Type");
         }
         if(_loc27_._cache["Type"])
         {
            var _loc28_:* = _loc15_;
            if(!_loc28_._cache["Type"])
            {
               _loc28_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc28_._fields,"name","Type");
            }
            var _loc29_:* = _loc28_._cache["Type"];
            §§push(_loc29_.overrideValue != null ? _loc29_.overrideValue : _loc29_._value);
         }
         else
         {
            §§push(null);
         }
         var _loc8_:String = §§pop();
         var _loc30_:*;
         var items:Vector.<ShopItem> = shopLogic.getItems(_loc8_,_loc10_ != null ? (_loc30_ = _loc10_, _loc30_.overrideValue != null ? _loc30_.overrideValue : _loc30_._value) : null);
         var slotSize:int = shopLogic.tabSlotSize;
         var objectsToAddToContainer:Array = [];
         var nextItemIndex:int = 0;
         var itemsTotalSize:int = !!items ? items.length : 0;
         if(_loc9_)
         {
            for each(var bigShopItem in _loc9_)
            {
               itemsTotalSize += bigShopItem.size;
               if(bigShopItem.replace && !bigShopItem.isPlaceholderItem())
               {
                  for each(var si in items)
                  {
                     if(si.id == bigShopItem.item.id)
                     {
                        items.splice(items.indexOf(si),1);
                        itemsTotalSize--;
                        break;
                     }
                  }
               }
            }
         }
         var helperTotalSize:* = itemsTotalSize;
         if(itemsTotalSize % slotSize != 0)
         {
            emptySlotsToAdd = slotSize - itemsTotalSize % slotSize;
            helperTotalSize += emptySlotsToAdd;
            while(emptySlotsToAdd > 0)
            {
               items.push(null);
               emptySlotsToAdd--;
            }
         }
         if(_loc9_)
         {
            nextBigItemIndex = 0;
            for(objectPageA = 0; objectPageA * slotSize < itemsTotalSize; )
            {
               objectsOnPage = [];
               for(roomOnObjectPageA = slotSize; roomOnObjectPageA > 0; )
               {
                  if(_loc9_.length > nextBigItemIndex && _loc9_[nextBigItemIndex].size <= roomOnObjectPageA)
                  {
                     objectsOnPage.push(_loc9_[nextBigItemIndex]);
                     roomOnObjectPageA -= _loc9_[nextBigItemIndex].size;
                     nextBigItemIndex++;
                  }
                  else if(_loc9_.length > nextBigItemIndex && _loc9_[nextBigItemIndex].size > slotSize)
                  {
                     assert(_loc9_[nextBigItemIndex].id + " is to big for this screen tab " + shopLogic.getCurrentTab().id,false,_loc9_[nextBigItemIndex].size > slotSize);
                  }
                  else
                  {
                     if(!(items.length > nextItemIndex && 1 <= roomOnObjectPageA))
                     {
                        if(items.length > nextItemIndex)
                        {
                           LogUtils.log("Infinite loop or other problem in counting objects to page","ShopHelper",3,"UI",false,false,false);
                           break;
                        }
                        break;
                     }
                     objectsOnPage.push(items[nextItemIndex]);
                     roomOnObjectPageA -= !!items[nextItemIndex] ? items[nextItemIndex].size : 1;
                     nextItemIndex++;
                  }
               }
               objectsToAddToContainer.push(objectsOnPage);
               objectPageA++;
            }
            _loc14_.init(objectsToAddToContainer,true,-1,oldPage);
         }
         else
         {
            objectPageB = 0;
            while(objectPageB * slotSize < itemsTotalSize)
            {
               objectsOnPage = [];
               for(roomOnObjectPageB = slotSize; roomOnObjectPageB > 0; )
               {
                  if(!(items.length > nextItemIndex && 1 <= roomOnObjectPageB))
                  {
                     if(items.length > nextItemIndex)
                     {
                        LogUtils.log("Infinite loop or other problem in counting objects to page","ShopHelper",3,"UI",false,false,false);
                        break;
                     }
                     break;
                  }
                  objectsOnPage.push(items[nextItemIndex]);
                  roomOnObjectPageB -= !!items[nextItemIndex] ? items[nextItemIndex].size : 1;
                  nextItemIndex++;
               }
               objectsToAddToContainer.push(objectsOnPage);
               objectPageB++;
            }
            _loc14_.init(objectsToAddToContainer,true,-1,oldPage);
         }
         return _loc14_;
      }
      
      public static function sortingMagic(oldData:*) : Array
      {
         var j:int = 0;
         var temp:* = null;
         var _loc3_:* = (oldData as Array).slice();
         var count:int = 0;
         for each(var si in _loc3_)
         {
            if(si == null || (si as ShopItem).size == 1)
            {
               count++;
            }
         }
         if(count >= 8)
         {
            for(j = (_loc3_ as Array).length - 1; j > 3; )
            {
               temp = (_loc3_ as Array)[j - 2];
               (_loc3_ as Array)[j - 2] = (_loc3_ as Array)[j - 4];
               (_loc3_ as Array)[j - 4] = temp;
               temp = (_loc3_ as Array)[j - 3];
               (_loc3_ as Array)[j - 3] = (_loc3_ as Array)[j - 5];
               (_loc3_ as Array)[j - 5] = temp;
               if(j < (_loc3_ as Array).length - 1)
               {
                  temp = (_loc3_ as Array)[j + 2];
                  (_loc3_ as Array)[j + 2] = (_loc3_ as Array)[j - 4];
                  (_loc3_ as Array)[j - 4] = temp;
                  temp = (_loc3_ as Array)[j + 1];
                  (_loc3_ as Array)[j + 1] = (_loc3_ as Array)[j - 5];
                  (_loc3_ as Array)[j - 5] = temp;
               }
               j -= 4;
            }
         }
         return _loc3_;
      }
   }
}
