package tuxwars.home.ui.screen.friendselector
{
   import com.dchoc.game.DCGame;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.scroll.*;
   import com.dchoc.utils.*;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class FriendsSelectorBase extends UIComponent
   {
      public function FriendsSelectorBase(param1:DisplayObject)
      {
         super(param1);
      }
      
      public static function removeFromList(param1:String, param2:Vector.<Object>) : Vector.<Object>
      {
         var _loc3_:int = 0;
         if(param1 != "" && param2 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(param2[_loc3_].id == param1)
               {
                  return param2.splice(_loc3_,1);
               }
               _loc3_++;
            }
         }
         else
         {
            LogUtils.log("Could not remove from list id: " + param1);
         }
         return null;
      }
      
      public function createScrollBar(param1:UIButton, param2:Sprite, param3:Function) : ScrollBar
      {
         var _loc4_:ScrollBar = null;
         var _loc5_:String = "vertical";
         var _loc6_:Stage = DCGame.getStage();
         _loc4_ = new ScrollBar(param1,param2,_loc5_,_loc6_);
         _loc4_.setProcentage(0);
         _loc4_.setMoveCallback(param3);
         return _loc4_;
      }
      
      public function getFromListWithId(param1:String, param2:Vector.<Object>) : Object
      {
         var _loc3_:int = 0;
         if(param1 != "" && param2 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(param2[_loc3_].id == param1)
               {
                  return param2[_loc3_];
               }
               _loc3_++;
            }
         }
         else
         {
            LogUtils.log("Could not find id: " + param1);
         }
         return null;
      }
      
      public function ifNotExistWithIdUnshift(param1:Object, param2:Vector.<Object>) : int
      {
         var _loc3_:int = 0;
         if(param1 != null && param2 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(param2[_loc3_].id == param1.id)
               {
                  return _loc3_;
               }
               _loc3_++;
            }
            param2.unshift(param1);
         }
         return -1;
      }
      
      public function scrollBarMoveHandler(param1:uint, param2:CellList, param3:CellList = null) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = param2.panelList.length;
         var _loc7_:uint = param2.currentLength;
         if(param1 > 0)
         {
            _loc4_ = uint(_loc7_ - _loc6_);
            _loc4_ = _loc4_ + 1;
            _loc5_ = Math.ceil(param1 * _loc4_ / 100);
         }
         _loc5_ = uint(CellList.checkIndex(_loc5_,_loc7_ - _loc6_,0));
         if(param3 != null)
         {
            param2.updateFromIndex(_loc5_,param3.dataList);
         }
         else
         {
            param2.updateFromIndex(_loc5_);
         }
      }
   }
}

