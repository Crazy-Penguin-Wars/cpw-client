package no.olog.utilfunctions
{
   import flash.utils.*;
   import no.olog.*;
   
   public function assert(param1:String, param2:*, param3:*, ... rest) : Boolean
   {
      var _loc5_:uint = 0;
      var _loc8_:* = undefined;
      var _loc9_:String = null;
      var _loc6_:* = "[Test \"" + param1 + "\"] ";
      var _loc7_:String = "";
      if(param3 is Function)
      {
         param3.apply(this,rest);
      }
      else if(param2 is Class)
      {
         param2 = getQualifiedClassName(param2);
         _loc8_ = getQualifiedClassName(param3);
      }
      else if(param2 is String && !isNaN(Number(param3)))
      {
         _loc9_ = String(param2);
         if(_loc9_.charAt(0) == "<" && Number(param3) < Number(_loc9_.substr(1)))
         {
            _loc8_ = param2;
         }
         else if(_loc9_.charAt(0) == ">" && Number(param3) > Number(_loc9_.substr(1)))
         {
            _loc8_ = param2;
         }
         else
         {
            _loc8_ = param3;
         }
      }
      else
      {
         _loc8_ = param3;
      }
      if(_loc8_ === param2)
      {
         _loc6_ += "passed";
         _loc5_ = 4;
      }
      else
      {
         _loc6_ += "failed, expected " + String(param2) + " was " + String(_loc8_);
         _loc5_ = 3;
         _loc7_ = getCallee(3);
      }
      Olog.trace(_loc6_,_loc5_,_loc7_);
      return _loc5_ == 4 ? true : false;
   }
}

