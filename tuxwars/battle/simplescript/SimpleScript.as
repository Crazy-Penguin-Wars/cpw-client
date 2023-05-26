package tuxwars.battle.simplescript
{
   import nape.geom.Vec2;
   
   public interface SimpleScript
   {
       
      
      function get className() : String;
      
      function get variables() : Array;
      
      function get id() : String;
      
      function get uniqueId() : String;
      
      function get location() : Vec2;
   }
}
