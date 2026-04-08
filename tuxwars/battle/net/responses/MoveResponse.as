package tuxwars.battle.net.responses
{
   public class MoveResponse extends ActionResponse
   {
      public function MoveResponse(param1:Object)
      {
         super(param1);
      }
      
      public function get direction() : int
      {
         return data.d;
      }
   }
}

