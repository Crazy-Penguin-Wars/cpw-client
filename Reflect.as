package
{
   public class Reflect
   {
      public function Reflect()
      {
         super();
      }
      
      public static function field(param1:*, param2:String) : *
      {
         try
         {
            return param1[param2];
         }
         catch(e:Error)
         {
            return undefined;
         }
      }
      
      public static function fields(param1:*) : Array
      {
         var _loc2_:* = null as String;
         if(param1 == null)
         {
            return [];
         }
         var _loc3_:Array = [];
         for(_loc2_ in param1)
         {
            if(param1.hasOwnProperty(_loc2_))
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public static function copy(param1:Object) : Object
      {
         var _loc2_:* = null as String;
         var _loc3_:* = {};
         var _loc4_:int = 0;
         var _loc5_:Array = Reflect.fields(param1);
         while(_loc4_ < int(_loc5_.length))
         {
            _loc2_ = _loc5_[_loc4_];
            _loc4_++;
            _loc3_[_loc2_] = Reflect.field(param1,_loc2_);
         }
         return _loc3_;
      }
   }
}

