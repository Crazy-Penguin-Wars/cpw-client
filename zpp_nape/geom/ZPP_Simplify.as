package zpp_nape.geom
{
   import zpp_nape.util.ZNPList_ZPP_SimplifyP;
   import zpp_nape.util.ZNPNode_ZPP_SimplifyP;
   
   public class ZPP_Simplify
   {
      
      public static var stack:ZNPList_ZPP_SimplifyP = null;
       
      
      public function ZPP_Simplify()
      {
      }
      
      public static function lessval(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV) : Number
      {
         return param1.x - param2.x + (param1.y - param2.y);
      }
      
      public static function less(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV) : Boolean
      {
         return param1.x - param2.x + (param1.y - param2.y) < 0;
      }
      
      public static function distance(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV, param3:ZPP_SimplifyV) : Number
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         _loc4_ = param3.x - param2.x;
         _loc5_ = param3.y - param2.y;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         _loc6_ = param1.x - param2.x;
         _loc7_ = param1.y - param2.y;
         var _loc8_:Number = _loc4_ * _loc4_ + _loc5_ * _loc5_;
         if(_loc8_ == 0)
         {
            return _loc6_ * _loc6_ + _loc7_ * _loc7_;
         }
         _loc9_ = (_loc6_ * _loc4_ + _loc7_ * _loc5_) / (_loc4_ * _loc4_ + _loc5_ * _loc5_);
         if(_loc9_ <= 0)
         {
            return _loc6_ * _loc6_ + _loc7_ * _loc7_;
         }
         if(_loc9_ >= 1)
         {
            _loc10_ = 0;
            _loc11_ = 0;
            _loc10_ = param1.x - param3.x;
            _loc11_ = param1.y - param3.y;
            return _loc10_ * _loc10_ + _loc11_ * _loc11_;
         }
         _loc10_ = _loc9_;
         _loc6_ -= _loc4_ * _loc10_;
         _loc7_ -= _loc5_ * _loc10_;
         return _loc6_ * _loc6_ + _loc7_ * _loc7_;
      }
      
      public static function simplify(param1:ZPP_GeomVert, param2:Number) : ZPP_GeomVert
      {
         var _loc9_:* = null as ZPP_SimplifyV;
         var _loc10_:* = null as ZPP_SimplifyV;
         var _loc11_:* = null as ZPP_SimplifyP;
         var _loc12_:* = null as ZPP_SimplifyV;
         var _loc13_:Boolean = false;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:* = null as ZPP_SimplifyP;
         var _loc17_:* = null as ZPP_SimplifyV;
         var _loc19_:* = null as ZPP_GeomVert;
         var _loc20_:* = null as ZPP_GeomVert;
         var _loc3_:ZPP_SimplifyV = null;
         var _loc4_:ZPP_SimplifyV = null;
         var _loc5_:ZPP_SimplifyV = null;
         param2 *= param2;
         if(ZPP_Simplify.stack == null)
         {
            ZPP_Simplify.stack = new ZNPList_ZPP_SimplifyP();
         }
         var _loc6_:ZPP_SimplifyV = null;
         var _loc7_:ZPP_SimplifyV = null;
         var _loc8_:ZPP_GeomVert = param1;
         do
         {
            if(ZPP_SimplifyV.zpp_pool == null)
            {
               _loc10_ = new ZPP_SimplifyV();
            }
            else
            {
               _loc10_ = ZPP_SimplifyV.zpp_pool;
               ZPP_SimplifyV.zpp_pool = _loc10_.next;
               _loc10_.next = null;
            }
            _loc10_.x = _loc8_.x;
            _loc10_.y = _loc8_.y;
            _loc10_.flag = false;
            _loc9_ = _loc10_;
            _loc9_.forced = _loc8_.forced;
            if(_loc9_.forced)
            {
               _loc9_.flag = true;
               if(_loc6_ != null)
               {
                  §§push(ZPP_Simplify.stack);
                  if(ZPP_SimplifyP.zpp_pool == null)
                  {
                     _loc11_ = new ZPP_SimplifyP();
                  }
                  else
                  {
                     _loc11_ = ZPP_SimplifyP.zpp_pool;
                     ZPP_SimplifyP.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  _loc11_.min = _loc6_;
                  _loc11_.max = _loc9_;
                  §§pop().add(_loc11_);
               }
               else
               {
                  _loc7_ = _loc9_;
               }
               _loc6_ = _loc9_;
            }
            _loc10_ = _loc9_;
            if(_loc3_ == null)
            {
               _loc3_ = _loc10_.prev = _loc10_.next = _loc10_;
            }
            else
            {
               _loc10_.prev = _loc3_;
               _loc10_.next = _loc3_.next;
               _loc3_.next.prev = _loc10_;
               _loc3_.next = _loc10_;
            }
            _loc3_ = _loc10_;
            if(_loc4_ == null)
            {
               _loc4_ = _loc3_;
               _loc5_ = _loc3_;
            }
            else
            {
               if(_loc3_.x - _loc4_.x + (_loc3_.y - _loc4_.y) < 0)
               {
                  _loc4_ = _loc3_;
               }
               if(_loc5_.x - _loc3_.x + (_loc5_.y - _loc3_.y) < 0)
               {
                  _loc5_ = _loc3_;
               }
            }
            _loc8_ = _loc8_.next;
         }
         while(_loc8_ != param1);
         
         if(ZPP_Simplify.stack.head == null)
         {
            if(_loc7_ == null)
            {
               _loc4_.flag = _loc5_.flag = true;
               §§push(ZPP_Simplify.stack);
               if(ZPP_SimplifyP.zpp_pool == null)
               {
                  _loc11_ = new ZPP_SimplifyP();
               }
               else
               {
                  _loc11_ = ZPP_SimplifyP.zpp_pool;
                  ZPP_SimplifyP.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.min = _loc4_;
               _loc11_.max = _loc5_;
               §§pop().add(_loc11_);
               §§push(ZPP_Simplify.stack);
               if(ZPP_SimplifyP.zpp_pool == null)
               {
                  _loc11_ = new ZPP_SimplifyP();
               }
               else
               {
                  _loc11_ = ZPP_SimplifyP.zpp_pool;
                  ZPP_SimplifyP.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.min = _loc5_;
               _loc11_.max = _loc4_;
               §§pop().add(_loc11_);
            }
            else
            {
               _loc14_ = _loc4_.x - _loc7_.x + (_loc4_.y - _loc7_.y);
               if(_loc14_ < 0)
               {
                  _loc14_ = -_loc14_;
               }
               _loc15_ = _loc5_.x - _loc7_.x + (_loc5_.y - _loc7_.y);
               if(_loc15_ < 0)
               {
                  _loc15_ = -_loc15_;
               }
               if(_loc14_ > _loc15_)
               {
                  _loc4_.flag = _loc7_.flag = true;
                  §§push(ZPP_Simplify.stack);
                  if(ZPP_SimplifyP.zpp_pool == null)
                  {
                     _loc11_ = new ZPP_SimplifyP();
                  }
                  else
                  {
                     _loc11_ = ZPP_SimplifyP.zpp_pool;
                     ZPP_SimplifyP.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  _loc11_.min = _loc4_;
                  _loc11_.max = _loc7_;
                  §§pop().add(_loc11_);
                  §§push(ZPP_Simplify.stack);
                  if(ZPP_SimplifyP.zpp_pool == null)
                  {
                     _loc11_ = new ZPP_SimplifyP();
                  }
                  else
                  {
                     _loc11_ = ZPP_SimplifyP.zpp_pool;
                     ZPP_SimplifyP.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  _loc11_.min = _loc7_;
                  _loc11_.max = _loc4_;
                  §§pop().add(_loc11_);
               }
               else
               {
                  _loc5_.flag = _loc7_.flag = true;
                  §§push(ZPP_Simplify.stack);
                  if(ZPP_SimplifyP.zpp_pool == null)
                  {
                     _loc11_ = new ZPP_SimplifyP();
                  }
                  else
                  {
                     _loc11_ = ZPP_SimplifyP.zpp_pool;
                     ZPP_SimplifyP.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  _loc11_.min = _loc5_;
                  _loc11_.max = _loc7_;
                  §§pop().add(_loc11_);
                  §§push(ZPP_Simplify.stack);
                  if(ZPP_SimplifyP.zpp_pool == null)
                  {
                     _loc11_ = new ZPP_SimplifyP();
                  }
                  else
                  {
                     _loc11_ = ZPP_SimplifyP.zpp_pool;
                     ZPP_SimplifyP.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  _loc11_.min = _loc7_;
                  _loc11_.max = _loc5_;
                  §§pop().add(_loc11_);
               }
            }
         }
         else
         {
            §§push(ZPP_Simplify.stack);
            if(ZPP_SimplifyP.zpp_pool == null)
            {
               _loc11_ = new ZPP_SimplifyP();
            }
            else
            {
               _loc11_ = ZPP_SimplifyP.zpp_pool;
               ZPP_SimplifyP.zpp_pool = _loc11_.next;
               _loc11_.next = null;
            }
            _loc11_.min = _loc6_;
            _loc11_.max = _loc7_;
            §§pop().add(_loc11_);
         }
         while(ZPP_Simplify.stack.head != null)
         {
            _loc11_ = ZPP_Simplify.stack.pop_unsafe();
            _loc9_ = _loc11_.min;
            _loc10_ = _loc11_.max;
            _loc16_ = _loc11_;
            _loc16_.min = _loc16_.max = null;
            _loc16_.next = ZPP_SimplifyP.zpp_pool;
            ZPP_SimplifyP.zpp_pool = _loc16_;
            _loc14_ = param2;
            _loc12_ = null;
            _loc17_ = _loc9_.next;
            while(_loc17_ != _loc10_)
            {
               _loc15_ = ZPP_Simplify.distance(_loc17_,_loc9_,_loc10_);
               if(_loc15_ > _loc14_)
               {
                  _loc14_ = _loc15_;
                  _loc12_ = _loc17_;
               }
               _loc17_ = _loc17_.next;
            }
            if(_loc12_ != null)
            {
               _loc12_.flag = true;
               §§push(ZPP_Simplify.stack);
               if(ZPP_SimplifyP.zpp_pool == null)
               {
                  _loc16_ = new ZPP_SimplifyP();
               }
               else
               {
                  _loc16_ = ZPP_SimplifyP.zpp_pool;
                  ZPP_SimplifyP.zpp_pool = _loc16_.next;
                  _loc16_.next = null;
               }
               _loc16_.min = _loc9_;
               _loc16_.max = _loc12_;
               §§pop().add(_loc16_);
               §§push(ZPP_Simplify.stack);
               if(ZPP_SimplifyP.zpp_pool == null)
               {
                  _loc16_ = new ZPP_SimplifyP();
               }
               else
               {
                  _loc16_ = ZPP_SimplifyP.zpp_pool;
                  ZPP_SimplifyP.zpp_pool = _loc16_.next;
                  _loc16_.next = null;
               }
               _loc16_.min = _loc12_;
               _loc16_.max = _loc10_;
               §§pop().add(_loc16_);
            }
         }
         var _loc18_:ZPP_GeomVert = null;
         while(_loc3_ != null)
         {
            if(_loc3_.flag)
            {
               if(ZPP_GeomVert.zpp_pool == null)
               {
                  _loc20_ = new ZPP_GeomVert();
               }
               else
               {
                  _loc20_ = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc20_.next;
                  _loc20_.next = null;
               }
               _loc20_.forced = false;
               _loc20_.x = _loc3_.x;
               _loc20_.y = _loc3_.y;
               _loc19_ = _loc20_;
               if(_loc18_ == null)
               {
                  _loc18_ = _loc19_.prev = _loc19_.next = _loc19_;
               }
               else
               {
                  _loc19_.prev = _loc18_;
                  _loc19_.next = _loc18_.next;
                  _loc18_.next.prev = _loc19_;
                  _loc18_.next = _loc19_;
               }
               _loc18_ = _loc19_;
               _loc18_.forced = _loc3_.forced;
            }
            _loc3_ = _loc3_ != null && _loc3_.prev == _loc3_ ? (_loc3_.next = _loc3_.prev = null, _loc9_ = _loc3_, _loc9_.next = ZPP_SimplifyV.zpp_pool, ZPP_SimplifyV.zpp_pool = _loc9_, _loc3_ = null) : (_loc9_ = _loc3_.next, _loc3_.prev.next = _loc3_.next, _loc3_.next.prev = _loc3_.prev, _loc3_.next = _loc3_.prev = null, _loc10_ = _loc3_, _loc10_.next = ZPP_SimplifyV.zpp_pool, ZPP_SimplifyV.zpp_pool = _loc10_, _loc3_ = null, _loc9_);
         }
         return _loc18_;
      }
   }
}
