package tuxwars.battle.world
{
   import nape.dynamics.ArbiterList;
   import nape.phys.Body;
   
   public interface Collider
   {
       
      
      function handleBeginContact(param1:Body, param2:ArbiterList) : void;
      
      function handleOngoingContact(param1:Body, param2:ArbiterList) : void;
      
      function handleEndContact(param1:Body, param2:ArbiterList) : void;
      
      function get id() : String;
   }
}
