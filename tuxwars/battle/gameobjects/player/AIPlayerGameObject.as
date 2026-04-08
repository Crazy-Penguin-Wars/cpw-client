package tuxwars.battle.gameobjects.player
{
   import nape.geom.Vec2;
   import tuxwars.TuxWarsGame;
   
   public class AIPlayerGameObject extends PlayerGameObject
   {
      private var targetVec:Vec2;
      
      public function AIPlayerGameObject(param1:PlayerGameObjectDef, param2:TuxWarsGame)
      {
         super(param1,param2);
      }
      
      override public function isAI() : Boolean
      {
         return true;
      }
      
      public function set target(param1:Vec2) : void
      {
         this.targetVec = param1;
      }
      
      public function get target() : Vec2
      {
         return this.targetVec;
      }
   }
}

