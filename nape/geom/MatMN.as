package nape.geom
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_MatMN;
   
   public final class MatMN
   {
       
      
      public var zpp_inner:ZPP_MatMN;
      
      public function MatMN(param1:int, param2:int)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(param1 <= 0 || param2 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: MatMN::dimensions cannot be < 1";
         }
         zpp_inner = new ZPP_MatMN(param1,param2);
         zpp_inner.outer = this;
      }
      
      public function x(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param2 < 0 || param1 >= zpp_inner.m || param2 >= zpp_inner.n)
         {
            Boot.lastError = new Error();
            throw "Error: MatMN indices out of range";
         }
         return zpp_inner.x[param1 * zpp_inner.n + param2];
      }
      
      public function transpose() : MatMN
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:MatMN = new MatMN(zpp_inner.n,zpp_inner.m);
         var _loc2_:int = 0;
         var _loc3_:int = zpp_inner.m;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _loc5_ = 0;
            _loc6_ = zpp_inner.n;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               if(_loc7_ < 0 || _loc4_ < 0 || _loc7_ >= _loc1_.zpp_inner.m || _loc4_ >= _loc1_.zpp_inner.n)
               {
                  Boot.lastError = new Error();
                  throw "Error: MatMN indices out of range";
               }
               §§push(_loc1_.zpp_inner.x);
               §§push(_loc7_ * _loc1_.zpp_inner.n + _loc4_);
               if(_loc4_ < 0 || _loc7_ < 0 || _loc4_ >= zpp_inner.m || _loc7_ >= zpp_inner.n)
               {
                  Boot.lastError = new Error();
                  throw "Error: MatMN indices out of range";
               }
               §§pop()[§§pop()] = zpp_inner.x[_loc4_ * zpp_inner.n + _loc7_];
            }
         }
         return _loc1_;
      }
      
      public function toString() : String
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:String = "{ ";
         var _loc2_:Boolean = true;
         var _loc3_:int = 0;
         var _loc4_:int = zpp_inner.m;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            if(!_loc2_)
            {
               _loc1_ += "; ";
            }
            _loc2_ = false;
            _loc6_ = 0;
            _loc7_ = zpp_inner.n;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc6_++;
               §§push(_loc1_);
               if(_loc5_ < 0 || _loc8_ < 0 || _loc5_ >= zpp_inner.m || _loc8_ >= zpp_inner.n)
               {
                  Boot.lastError = new Error();
                  throw "Error: MatMN indices out of range";
               }
               _loc1_ = §§pop() + (zpp_inner.x[_loc5_ * zpp_inner.n + _loc8_] + " ");
            }
         }
         return _loc1_ + "}";
      }
      
      public function setx(param1:int, param2:int, param3:Number) : Number
      {
         if(param1 < 0 || param2 < 0 || param1 >= zpp_inner.m || param2 >= zpp_inner.n)
         {
            Boot.lastError = new Error();
            throw "Error: MatMN indices out of range";
         }
         return zpp_inner.x[param1 * zpp_inner.n + param2] = param3;
      }
      
      public function mul(param1:MatMN) : MatMN
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc2_:MatMN = param1;
         if(zpp_inner.n != _loc2_.zpp_inner.m)
         {
            Boot.lastError = new Error();
            throw "Error: Matrix dimensions aren\'t compatible";
         }
         var _loc3_:MatMN = new MatMN(zpp_inner.m,_loc2_.zpp_inner.n);
         var _loc4_:int = 0;
         var _loc5_:int = zpp_inner.m;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc7_ = 0;
            _loc8_ = _loc2_.zpp_inner.n;
            while(_loc7_ < _loc8_)
            {
               _loc9_ = _loc7_++;
               _loc10_ = 0;
               _loc11_ = 0;
               _loc12_ = zpp_inner.n;
               while(_loc11_ < _loc12_)
               {
                  _loc13_ = _loc11_++;
                  §§push(_loc10_);
                  if(_loc6_ < 0 || _loc13_ < 0 || _loc6_ >= zpp_inner.m || _loc13_ >= zpp_inner.n)
                  {
                     Boot.lastError = new Error();
                     throw "Error: MatMN indices out of range";
                  }
                  §§push(zpp_inner.x[_loc6_ * zpp_inner.n + _loc13_]);
                  if(_loc13_ < 0 || _loc9_ < 0 || _loc13_ >= _loc2_.zpp_inner.m || _loc9_ >= _loc2_.zpp_inner.n)
                  {
                     Boot.lastError = new Error();
                     throw "Error: MatMN indices out of range";
                  }
                  _loc10_ = §§pop() + §§pop() * _loc2_.zpp_inner.x[_loc13_ * _loc2_.zpp_inner.n + _loc9_];
               }
               if(_loc6_ < 0 || _loc9_ < 0 || _loc6_ >= _loc3_.zpp_inner.m || _loc9_ >= _loc3_.zpp_inner.n)
               {
                  Boot.lastError = new Error();
                  throw "Error: MatMN indices out of range";
               }
               _loc3_.zpp_inner.x[_loc6_ * _loc3_.zpp_inner.n + _loc9_] = _loc10_;
            }
         }
         return _loc3_;
      }
      
      public function get rows() : int
      {
         return zpp_inner.m;
      }
      
      public function get cols() : int
      {
         return zpp_inner.n;
      }
   }
}
