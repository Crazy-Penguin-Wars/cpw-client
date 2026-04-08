package tuxwars.player.reports.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.LevelGameObject;
   
   public class ReportLevelObjectDestroyedMessage extends Message
   {
      public function ReportLevelObjectDestroyedMessage(param1:LevelGameObject)
      {
         super("LevelObjectDestroyed",param1);
      }
      
      public function get levelObject() : LevelGameObject
      {
         return data;
      }
   }
}

