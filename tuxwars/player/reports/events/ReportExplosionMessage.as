package tuxwars.player.reports.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ReportExplosionMessage extends Message
   {
       
      
      private const _affectedPlayers:Vector.<PlayerGameObject> = new Vector.<PlayerGameObject>();
      
      private var _affectedGameObjects:Vector.<PhysicsGameObject>;
      
      private var _firingPlayer:PlayerGameObject;
      
      private var _damageToGameObjects:Vector.<int>;
      
      public function ReportExplosionMessage(firingPlayer:PlayerGameObject, affectedGameObjects:Vector.<PhysicsGameObject>, damageToGameObjects:Vector.<int>)
      {
         super("ReportExplosion");
         _affectedGameObjects = affectedGameObjects;
         _firingPlayer = firingPlayer;
         _damageToGameObjects = damageToGameObjects;
         initAffectedPlayers();
      }
      
      public function get affectedGameObjects() : Vector.<PhysicsGameObject>
      {
         return _affectedGameObjects;
      }
      
      public function get firingPlayer() : PlayerGameObject
      {
         return _firingPlayer;
      }
      
      public function get damageToGameObjects() : Vector.<int>
      {
         return _damageToGameObjects;
      }
      
      public function get affectedPlayers() : Vector.<PlayerGameObject>
      {
         return _affectedPlayers;
      }
      
      public function containsPlayer(id:String) : Boolean
      {
         for each(var player in affectedPlayers)
         {
            var _loc3_:* = player;
            if(_loc3_._id == id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function damageTo(id:String) : int
      {
         var i:int = 0;
         var _loc2_:* = null;
         for(i = 0; i < affectedGameObjects.length; )
         {
            _loc2_ = affectedGameObjects[i];
            var _loc4_:* = _loc2_;
            if(_loc4_._id == id)
            {
               return damageToGameObjects[i];
            }
            i++;
         }
         return 0;
      }
      
      private function initAffectedPlayers() : void
      {
         for each(var obj in _affectedGameObjects)
         {
            if(obj is PlayerGameObject)
            {
               _affectedPlayers.push(obj as PlayerGameObject);
            }
         }
      }
   }
}
