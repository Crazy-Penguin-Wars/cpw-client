package tuxwars.battle.emitters
{
   import nape.geom.Vec2;
   import nape.phys.Body;
   
   public interface FiringDirection
   {
       
      
      function get id() : String;
      
      function get uniqueId() : String;
      
      function get shortName() : String;
      
      function get linearVelocity() : Vec2;
      
      function get lastBodyLocations() : Vec2;
      
      function get lastContactLocations() : Vec2;
      
      function get lastLinearDirection() : Vec2;
      
      function get explosionDirection() : Vec2;
      
      function getBody() : Body;
   }
}
