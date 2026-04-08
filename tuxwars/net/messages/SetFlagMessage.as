package tuxwars.net.messages
{
   import com.dchoc.net.ServerRequest;
   
   public class SetFlagMessage extends ServerRequest
   {
      public function SetFlagMessage(param1:String, param2:String, param3:int = -1, param4:Boolean = false, param5:Function = null)
      {
         var _loc6_:Object = {
            "key":param1,
            "value":param2
         };
         if(param3 != -1)
         {
            _loc6_.expires = param3;
         }
         super("SetFlag",_loc6_,param4,param5);
      }
   }
}

