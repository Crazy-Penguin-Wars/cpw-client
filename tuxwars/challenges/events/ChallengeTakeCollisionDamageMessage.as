package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.*;
   
   public class ChallengeTakeCollisionDamageMessage extends Message
   {
      private var _damagedObject:PhysicsGameObject;
      
      private var _objectDoingDamage:PhysicsGameObject;
      
      private var _damageAmount:int;
      
      private var _playerTaggerOfObjectDoingDamage:PlayerGameObject;
      
      public function ChallengeTakeCollisionDamageMessage(param1:PhysicsGameObject, param2:PhysicsGameObject, param3:int)
      {
         var _loc4_:Tagger = null;
         super("ChallengeTakeCollisionDamage");
         this._damagedObject = param1;
         this._objectDoingDamage = param2;
         this._damageAmount = param3;
         if(param2 != null)
         {
            _loc4_ = param2.tag.findLatestPlayerTagger();
            if(_loc4_ != null && Boolean(_loc4_.gameObject))
            {
               this._playerTaggerOfObjectDoingDamage = _loc4_.gameObject as PlayerGameObject;
            }
            else if(param2 is PlayerGameObject)
            {
               this._playerTaggerOfObjectDoingDamage = param2 as PlayerGameObject;
            }
         }
      }
      
      public function get damagedObject() : PhysicsGameObject
      {
         return this._damagedObject;
      }
      
      public function get objectDoingDamage() : PhysicsGameObject
      {
         return this._objectDoingDamage;
      }
      
      public function get damageAmount() : int
      {
         return this._damageAmount;
      }
      
      public function get playerTaggerOfObjectDoingDamage() : PlayerGameObject
      {
         return this._playerTaggerOfObjectDoingDamage;
      }
   }
}

