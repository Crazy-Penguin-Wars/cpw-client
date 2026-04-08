package tuxwars.player.reports.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.*;
   
   public class ReportExplosionMessage extends Message
   {
      private const _affectedPlayers:Vector.<PlayerGameObject> = new Vector.<PlayerGameObject>();
      
      private var _affectedGameObjects:Vector.<PhysicsGameObject>;
      
      private var _firingPlayer:PlayerGameObject;
      
      private var _damageToGameObjects:Vector.<int>;
      
      public function ReportExplosionMessage(param1:PlayerGameObject, param2:Vector.<PhysicsGameObject>, param3:Vector.<int>)
      {
         super("ReportExplosion");
         this._affectedGameObjects = param2;
         this._firingPlayer = param1;
         this._damageToGameObjects = param3;
         this.initAffectedPlayers();
      }
      
      public function get affectedGameObjects() : Vector.<PhysicsGameObject>
      {
         return this._affectedGameObjects;
      }
      
      public function get firingPlayer() : PlayerGameObject
      {
         return this._firingPlayer;
      }
      
      public function get damageToGameObjects() : Vector.<int>
      {
         return this._damageToGameObjects;
      }
      
      public function get affectedPlayers() : Vector.<PlayerGameObject>
      {
         return this._affectedPlayers;
      }
      
      public function containsPlayer(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for each(_loc2_ in this.affectedPlayers)
         {
            _loc3_ = _loc2_;
            if(_loc3_._id == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function damageTo(param1:String) : int
      {
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:PhysicsGameObject = null;
         _loc2_ = 0;
         while(_loc2_ < this.affectedGameObjects.length)
         {
            _loc3_ = this.affectedGameObjects[_loc2_];
            _loc4_ = _loc3_;
            if(_loc4_._id == param1)
            {
               return this.damageToGameObjects[_loc2_];
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function initAffectedPlayers() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._affectedGameObjects)
         {
            if(_loc1_ is PlayerGameObject)
            {
               this._affectedPlayers.push(_loc1_ as PlayerGameObject);
            }
         }
      }
   }
}

