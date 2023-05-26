package tuxwars.battle.gameobjects
{
   import com.dchoc.game.DCGame;
   
   public class Tagger
   {
      
      public static const DEFAULT:Tagger = new Tagger(null);
       
      
      private var _gameObject:PhysicsGameObject;
      
      private var _time:int;
      
      public function Tagger(gameObject:PhysicsGameObject)
      {
         super();
         _gameObject = gameObject;
         _time = DCGame.getTime();
      }
      
      public function clone() : Tagger
      {
         return new Tagger(_gameObject);
      }
      
      public function toString() : String
      {
         return (!!_gameObject ? _gameObject.shortName : "Default") + " time: " + _time;
      }
      
      public function get gameObject() : PhysicsGameObject
      {
         return _gameObject;
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function equals(other:Tagger) : Boolean
      {
         if(this == other)
         {
            return true;
         }
         if(other._gameObject == _gameObject)
         {
            return true;
         }
         if(!other._gameObject)
         {
            return _gameObject == null;
         }
         var _loc2_:* = other._gameObject;
         var _loc3_:PhysicsGameObject = _gameObject;
         return _loc2_._id == _loc3_._id;
      }
   }
}
