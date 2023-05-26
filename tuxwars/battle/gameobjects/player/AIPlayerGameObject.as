package tuxwars.battle.gameobjects.player
{
   import nape.geom.Vec2;
   import tuxwars.TuxWarsGame;
   
   public class AIPlayerGameObject extends PlayerGameObject
   {
       
      
      private var targetVec:Vec2;
      
      public function AIPlayerGameObject(def:PlayerGameObjectDef, game:TuxWarsGame)
      {
         super(def,game);
      }
      
      override public function isAI() : Boolean
      {
         return true;
      }
      
      public function set target(target:Vec2) : void
      {
         targetVec = target;
      }
      
      public function get target() : Vec2
      {
         return targetVec;
      }
   }
}
