package tuxwars.player.reports.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   
   public class ReportTerrainDestroyedMessage extends Message
   {
       
      
      private const _intersectionPolygons:Array = [];
      
      private var _terrain:TerrainGameObject;
      
      public function ReportTerrainDestroyedMessage(terrain:TerrainGameObject)
      {
         super("TerrainDestroyed");
         _terrain = terrain;
      }
      
      public function get terrain() : TerrainGameObject
      {
         return _terrain;
      }
   }
}
