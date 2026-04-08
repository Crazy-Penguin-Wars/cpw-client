package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.LevelGameObject;
   
   public class ChallengeLevelObjectDestroyed extends Message
   {
      private var _levelObject:LevelGameObject;
      
      private var _cause:String;
      
      public function ChallengeLevelObjectDestroyed(param1:LevelGameObject, param2:String)
      {
         super("ChallengeLevelObjectDestroyed");
         this._levelObject = param1;
         this._cause = param2;
      }
      
      public function get levelObject() : LevelGameObject
      {
         return this._levelObject;
      }
      
      public function get cause() : String
      {
         return this._cause;
      }
   }
}

