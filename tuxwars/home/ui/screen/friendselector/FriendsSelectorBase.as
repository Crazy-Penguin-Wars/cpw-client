package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.game.DCGame;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.scroll.ScrollBar;
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class FriendsSelectorBase extends UIComponent
   {
       
      
      public function FriendsSelectorBase(newDesign:DisplayObject)
      {
         super(newDesign);
      }
      
      public static function removeFromList(id:String, list:Vector.<Object>) : Vector.<Object>
      {
         var i:int = 0;
         if(id != "" && list != null)
         {
            for(i = 0; i < list.length; )
            {
               if(list[i].id == id)
               {
                  return list.splice(i,1);
               }
               i++;
            }
         }
         else
         {
            LogUtils.log("Could not remove from list id: " + id);
         }
         return null;
      }
      
      public function createScrollBar(design:UIButton, hitArea:Sprite, callback:Function) : ScrollBar
      {
         var returnBar:* = null;
         var _loc7_:DCGame = DCGame;
         var stage:Stage = com.dchoc.game.DCGame._stage;
         returnBar = new ScrollBar(design,hitArea,"vertical",stage);
         returnBar.setProcentage(0);
         returnBar.setMoveCallback(callback);
         return returnBar;
      }
      
      public function getFromListWithId(id:String, list:Vector.<Object>) : Object
      {
         var i:int = 0;
         if(id != "" && list != null)
         {
            for(i = 0; i < list.length; )
            {
               if(list[i].id == id)
               {
                  return list[i];
               }
               i++;
            }
         }
         else
         {
            LogUtils.log("Could not find id: " + id);
         }
         return null;
      }
      
      public function ifNotExistWithIdUnshift(obj:Object, list:Vector.<Object>) : int
      {
         var i:int = 0;
         if(obj != null && list != null)
         {
            for(i = 0; i < list.length; )
            {
               if(list[i].id == obj.id)
               {
                  return i;
               }
               i++;
            }
            list.unshift(obj);
         }
         return -1;
      }
      
      public function scrollBarMoveHandler(percentage:uint, list:CellList, excluded:CellList = null) : void
      {
         var itemsLenght:* = 0;
         var returnPanelIndex:uint = 0;
         var panelCount:uint = list.panelList.length;
         var itemsCount:uint = list.currentLength;
         if(percentage > 0)
         {
            itemsLenght = itemsCount - panelCount;
            itemsLenght++;
            returnPanelIndex = Math.ceil(percentage * itemsLenght / 100);
         }
         returnPanelIndex = CellList.checkIndex(returnPanelIndex,itemsCount - panelCount,0);
         if(excluded != null)
         {
            list.updateFromIndex(returnPanelIndex,excluded.dataList);
         }
         else
         {
            list.updateFromIndex(returnPanelIndex);
         }
      }
   }
}
