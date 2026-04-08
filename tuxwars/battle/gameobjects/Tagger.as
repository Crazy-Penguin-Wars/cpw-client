package tuxwars.battle.gameobjects
{
   import com.dchoc.game.*;
   
   public class Tagger
   {
      public static const DEFAULT:Tagger = new Tagger(null);
      
      private var _gameObject:PhysicsGameObject;
      
      private var _time:int;
      
      public function Tagger(param1:PhysicsGameObject)
      {
         super();
         this._gameObject = param1;
         this._time = DCGame.getTime();
      }
      
      public function clone() : Tagger
      {
         return new Tagger(this._gameObject);
      }
      
      public function toString() : String
      {
         return (!!this._gameObject ? this._gameObject.shortName : "Default") + " time: " + this._time;
      }
      
      public function get gameObject() : PhysicsGameObject
      {
         return this._gameObject;
      }
      
      public function get time() : int
      {
         return this._time;
      }
      
      public function equals(param1:Tagger) : Boolean
      {
         if(this == param1)
         {
            return true;
         }
         if(param1._gameObject == this._gameObject)
         {
            return true;
         }
         if(!param1._gameObject)
         {
            return this._gameObject == null;
         }
         var _loc2_:* = param1._gameObject;
         var _loc3_:PhysicsGameObject = this._gameObject;
         return _loc2_._id == _loc3_._id;
      }
   }
}

