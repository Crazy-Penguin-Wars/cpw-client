package tuxwars.battle.net.responses
{
   public class DieResponse extends ActionResponse
   {
       
      
      public function DieResponse(data:Object)
      {
         super(data);
      }
      
      override public function get id() : String
      {
         return data.dead_dude;
      }
   }
}
