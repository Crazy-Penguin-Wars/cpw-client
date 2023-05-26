package tuxwars.player.reports.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.LevelGameObject;
   
   public class ReportLevelObjectDestroyedMessage extends Message
   {
       
      
      public function ReportLevelObjectDestroyedMessage(levelObject:LevelGameObject)
      {
         super("LevelObjectDestroyed",levelObject);
      }
      
      public function get levelObject() : LevelGameObject
      {
         return data;
      }
   }
}
