package tuxwars.battle.net.responses
{
   public class UseBoosterResponse extends ActionResponse
   {
      public function UseBoosterResponse(param1:Object)
      {
         super(param1);
      }
      
      public function get boosterId() : String
      {
         return data.bid;
      }
   }
}

