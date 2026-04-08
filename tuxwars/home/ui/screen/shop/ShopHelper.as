package tuxwars.home.ui.screen.shop
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.*;
   import tuxwars.ui.components.*;
   
   public class ShopHelper
   {
      public static const TYPE:String = "Type";
      
      public function ShopHelper()
      {
         super();
      }
      
      public static function initSubTabObjectContainer(param1:MovieClip, param2:int, param3:TuxWarsGame, param4:Function, param5:IShopLogic) : ObjectContainer
      {
         var _loc25_:* = undefined;
         var _loc26_:* = undefined;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         var _loc13_:ObjectContainer = new ObjectContainer(param1,param3,param4,"transition_slots_left","transition_slots_right",false);
         var _loc14_:Row = param5.getCurrentTab();
         if(!_loc14_.getCache["Categorys"])
         {
            _loc14_.getCache["Categorys"] = DCUtils.find(_loc14_.getFields(),"name","Categorys");
         }
         var _loc15_:Field = _loc14_.getCache["Categorys"];
         var _loc16_:Vector.<BigShopItem> = param5.getCurrentTabBigItems();
         if(!_loc14_.getCache["Type"])
         {
            _loc14_.getCache["Type"] = DCUtils.find(_loc14_.getFields(),"name","Type");
         }
         var _loc17_:Field = _loc14_.getCache["Type"];
         var _loc18_:String = !!_loc17_ ? (_loc17_.overrideValue != null ? _loc17_.overrideValue : _loc17_._value) : null;
         var _loc19_:Vector.<ShopItem> = param5.getItems(_loc18_,_loc15_ != null ? (_loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value) : null);
         var _loc20_:int = int(param5.tabSlotSize);
         var _loc21_:Array = [];
         var _loc22_:int = 0;
         var _loc23_:int = !!_loc19_ ? int(_loc19_.length) : 0;
         if(_loc16_)
         {
            for each(_loc25_ in _loc16_)
            {
               _loc23_ += _loc25_.size;
               if(Boolean(_loc25_.replace) && !_loc25_.isPlaceholderItem())
               {
                  for each(_loc26_ in _loc19_)
                  {
                     if(_loc26_.id == _loc25_.item.id)
                     {
                        _loc19_.splice(_loc19_.indexOf(_loc26_),1);
                        _loc23_--;
                        break;
                     }
                  }
               }
            }
         }
         var _loc24_:* = _loc23_;
         if(_loc23_ % _loc20_ != 0)
         {
            _loc7_ = _loc20_ - _loc23_ % _loc20_;
            _loc24_ += _loc7_;
            while(_loc7_ > 0)
            {
               _loc19_.push(null);
               _loc7_--;
            }
         }
         if(_loc16_)
         {
            _loc8_ = 0;
            _loc9_ = 0;
            while(_loc9_ * _loc20_ < _loc23_)
            {
               _loc6_ = [];
               _loc10_ = _loc20_;
               while(_loc10_ > 0)
               {
                  if(_loc16_.length > _loc8_ && _loc16_[_loc8_].size <= _loc10_)
                  {
                     _loc6_.push(_loc16_[_loc8_]);
                     _loc10_ -= _loc16_[_loc8_].size;
                     _loc8_++;
                  }
                  else if(_loc16_.length > _loc8_ && _loc16_[_loc8_].size > _loc20_)
                  {
                     assert(_loc16_[_loc8_].id + " is to big for this screen tab " + param5.getCurrentTab().id,false,_loc16_[_loc8_].size > _loc20_);
                  }
                  else
                  {
                     if(!(_loc19_.length > _loc22_ && 1 <= _loc10_))
                     {
                        if(_loc19_.length > _loc22_)
                        {
                           LogUtils.log("Infinite loop or other problem in counting objects to page","ShopHelper",3,"UI",false,false,false);
                        }
                        break;
                     }
                     _loc6_.push(_loc19_[_loc22_]);
                     _loc10_ -= !!_loc19_[_loc22_] ? _loc19_[_loc22_].size : 1;
                     _loc22_++;
                  }
               }
               _loc21_.push(_loc6_);
               _loc9_++;
            }
            _loc13_.init(_loc21_,true,-1,param2);
         }
         else
         {
            _loc11_ = 0;
            while(_loc11_ * _loc20_ < _loc23_)
            {
               _loc6_ = [];
               _loc12_ = _loc20_;
               while(_loc12_ > 0)
               {
                  if(!(_loc19_.length > _loc22_ && 1 <= _loc12_))
                  {
                     if(_loc19_.length > _loc22_)
                     {
                        LogUtils.log("Infinite loop or other problem in counting objects to page","ShopHelper",3,"UI",false,false,false);
                     }
                     break;
                  }
                  _loc6_.push(_loc19_[_loc22_]);
                  _loc12_ -= !!_loc19_[_loc22_] ? _loc19_[_loc22_].size : 1;
                  _loc22_++;
               }
               _loc21_.push(_loc6_);
               _loc11_++;
            }
            _loc13_.init(_loc21_,true,-1,param2);
         }
         return _loc13_;
      }
      
      public static function sortingMagic(param1:*) : Array
      {
         var _loc6_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:ShopItem = null;
         var _loc4_:* = (param1 as Array).slice();
         var _loc5_:int = 0;
         for each(_loc6_ in _loc4_)
         {
            if(_loc6_ == null || (_loc6_ as ShopItem).size == 1)
            {
               _loc5_++;
            }
         }
         if(_loc5_ >= 8)
         {
            _loc2_ = int((_loc4_ as Array).length - 1);
            while(_loc2_ > 3)
            {
               _loc3_ = (_loc4_ as Array)[_loc2_ - 2];
               (_loc4_ as Array)[_loc2_ - 2] = (_loc4_ as Array)[_loc2_ - 4];
               (_loc4_ as Array)[_loc2_ - 4] = _loc3_;
               _loc3_ = (_loc4_ as Array)[_loc2_ - 3];
               (_loc4_ as Array)[_loc2_ - 3] = (_loc4_ as Array)[_loc2_ - 5];
               (_loc4_ as Array)[_loc2_ - 5] = _loc3_;
               if(_loc2_ < (_loc4_ as Array).length - 1)
               {
                  _loc3_ = (_loc4_ as Array)[_loc2_ + 2];
                  (_loc4_ as Array)[_loc2_ + 2] = (_loc4_ as Array)[_loc2_ - 4];
                  (_loc4_ as Array)[_loc2_ - 4] = _loc3_;
                  _loc3_ = (_loc4_ as Array)[_loc2_ + 1];
                  (_loc4_ as Array)[_loc2_ + 1] = (_loc4_ as Array)[_loc2_ - 5];
                  (_loc4_ as Array)[_loc2_ - 5] = _loc3_;
               }
               _loc2_ -= 4;
            }
         }
         return _loc4_;
      }
   }
}

