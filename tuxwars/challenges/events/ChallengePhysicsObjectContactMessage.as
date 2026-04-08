package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   
   public class ChallengePhysicsObjectContactMessage extends Message
   {
      private var _objectHit:PhysicsGameObject;
      
      private var _contactPoint:Vec2;
      
      public function ChallengePhysicsObjectContactMessage(param1:PhysicsGameObject, param2:PhysicsGameObject, param3:Vec2)
      {
         this._objectHit = param2;
         this._contactPoint = param3;
         super("ChallengePhysicsObjectContact",param1);
      }
      
      public function get object() : PhysicsGameObject
      {
         return data;
      }
      
      public function get objectHit() : PhysicsGameObject
      {
         return this._objectHit;
      }
      
      public function get contactPoint() : Vec2
      {
         return this._contactPoint;
      }
   }
}

