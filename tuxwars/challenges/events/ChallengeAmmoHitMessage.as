package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.items.references.EmissionExplosionReference;
   import tuxwars.items.references.EmissionReference;
   
   public class ChallengeAmmoHitMessage extends Message
   {
       
      
      private var _affectedGameObjects:Vector.<PhysicsGameObject>;
      
      private var _firingPlayer:PlayerGameObject;
      
      private var _emission:Emission;
      
      private var _emissionReference:EmissionReference;
      
      private var _emissionExplosionRef:EmissionExplosionReference;
      
      private var _damageToGameObjects:Vector.<int>;
      
      public function ChallengeAmmoHitMessage(emission:Emission, emissionReference:EmissionReference, emissionExplosionRef:EmissionExplosionReference, affectedGameObjects:Vector.<PhysicsGameObject>, firingPlayer:PlayerGameObject, damageToGameObjects:Vector.<int>)
      {
         super("ChallengeAmmoHit");
         _emission = emission;
         _emissionReference = emissionReference;
         _affectedGameObjects = affectedGameObjects;
         _firingPlayer = firingPlayer;
         _damageToGameObjects = damageToGameObjects;
      }
      
      public function get affectedGameObjects() : Vector.<PhysicsGameObject>
      {
         return _affectedGameObjects;
      }
      
      public function get firingPlayer() : PlayerGameObject
      {
         return _firingPlayer;
      }
      
      public function get emission() : Emission
      {
         return _emission;
      }
      
      public function get emissionReference() : EmissionReference
      {
         return _emissionReference;
      }
      
      public function get damageToGameObjects() : Vector.<int>
      {
         return _damageToGameObjects;
      }
      
      public function get emissionExplosionRef() : EmissionExplosionReference
      {
         return _emissionExplosionRef;
      }
      
      public function get affectedPlayers() : Vector.<PlayerGameObject>
      {
         var _loc1_:Vector.<PlayerGameObject> = new Vector.<PlayerGameObject>();
         for each(var obj in _affectedGameObjects)
         {
            if(obj is PlayerGameObject)
            {
               _loc1_.push(obj as PlayerGameObject);
            }
         }
         return _loc1_;
      }
   }
}
