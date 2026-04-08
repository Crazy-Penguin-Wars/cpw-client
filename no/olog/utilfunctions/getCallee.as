package no.olog.utilfunctions
{
   public function getCallee(param1:int = 2) : String
   {
      var _loc4_:* = null;
      var _loc5_:String = null;
      var _loc2_:String = new Error().getStackTrace().split("\n",param1 + 1)[param1];
      var _loc3_:String = _loc2_.match(/\w+\(\)/g)[0];
      if(_loc2_.indexOf(".as") != -1)
      {
         _loc4_ = _loc2_.match(/(?<=\/)\w+?(?=.as:)/)[0] + ".";
         _loc5_ = ", line " + _loc2_.match(/(?<=:)\d+/)[0];
      }
      else
      {
         _loc4_ = "";
         _loc5_ = "";
      }
      if(_loc4_.substr(0,-1) == _loc3_.substr(0,-2))
      {
         _loc3_ = "constructor()";
      }
      return _loc4_ + _loc3_ + _loc5_;
   }
}

