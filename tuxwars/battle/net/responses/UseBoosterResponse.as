package tuxwars.battle.net.responses
{
   public class UseBoosterResponse extends ActionResponse
   {
       
      
      public function UseBoosterResponse(data:Object)
      {
         super(data);
      }
      
      public function get boosterId() : String
      {
         return data.bid;
      }
   }
}
