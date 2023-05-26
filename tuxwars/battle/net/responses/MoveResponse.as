package tuxwars.battle.net.responses
{
   public class MoveResponse extends ActionResponse
   {
       
      
      public function MoveResponse(data:Object)
      {
         super(data);
      }
      
      public function get direction() : int
      {
         return data.d;
      }
   }
}
