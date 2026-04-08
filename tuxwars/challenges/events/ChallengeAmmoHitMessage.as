package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.*;
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
      
      public function ChallengeAmmoHitMessage(param1:Emission, param2:EmissionReference, param3:EmissionExplosionReference, param4:Vector.<PhysicsGameObject>, param5:PlayerGameObject, param6:Vector.<int>)
      {
         super("ChallengeAmmoHit");
         this._emission = param1;
         this._emissionReference = param2;
         this._affectedGameObjects = param4;
         this._firingPlayer = param5;
         this._damageToGameObjects = param6;
      }
      
      public function get affectedGameObjects() : Vector.<PhysicsGameObject>
      {
         return this._affectedGameObjects;
      }
      
      public function get firingPlayer() : PlayerGameObject
      {
         return this._firingPlayer;
      }
      
      public function get emission() : Emission
      {
         return this._emission;
      }
      
      public function get emissionReference() : EmissionReference
      {
         return this._emissionReference;
      }
      
      public function get damageToGameObjects() : Vector.<int>
      {
         return this._damageToGameObjects;
      }
      
      public function get emissionExplosionRef() : EmissionExplosionReference
      {
         return this._emissionExplosionRef;
      }
      
      public function get affectedPlayers() : Vector.<PlayerGameObject>
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<PlayerGameObject> = new Vector.<PlayerGameObject>();
         for each(_loc2_ in this._affectedGameObjects)
         {
            if(_loc2_ is PlayerGameObject)
            {
               _loc1_.push(_loc2_ as PlayerGameObject);
            }
         }
         return _loc1_;
      }
   }
}

