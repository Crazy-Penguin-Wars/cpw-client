package tuxwars.battle.net.responses
{
   public class DieResponse extends ActionResponse
   {
      public function DieResponse(param1:Object)
      {
         super(param1);
      }
      
      override public function get id() : String
      {
         return data.dead_dude;
      }
   }
}

