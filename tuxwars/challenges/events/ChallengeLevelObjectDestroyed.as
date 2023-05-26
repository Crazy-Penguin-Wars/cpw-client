package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.LevelGameObject;
   
   public class ChallengeLevelObjectDestroyed extends Message
   {
       
      
      private var _levelObject:LevelGameObject;
      
      private var _cause:String;
      
      public function ChallengeLevelObjectDestroyed(levelObject:LevelGameObject, cause:String)
      {
         super("ChallengeLevelObjectDestroyed");
         _levelObject = levelObject;
         _cause = cause;
      }
      
      public function get levelObject() : LevelGameObject
      {
         return _levelObject;
      }
      
      public function get cause() : String
      {
         return _cause;
      }
   }
}
