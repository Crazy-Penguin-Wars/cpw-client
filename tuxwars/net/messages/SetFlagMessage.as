package tuxwars.net.messages
{
   import com.dchoc.net.ServerRequest;
   
   public class SetFlagMessage extends ServerRequest
   {
       
      
      public function SetFlagMessage(key:String, value:String, expires:int = -1, buffered:Boolean = false, callback:Function = null)
      {
         var _loc6_:Object = {
            "key":key,
            "value":value
         };
         if(expires != -1)
         {
            _loc6_.expires = expires;
         }
         super("SetFlag",_loc6_,buffered,callback);
      }
   }
}
