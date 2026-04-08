package tuxwars.player.reports.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   
   public class ReportTerrainDestroyedMessage extends Message
   {
      private const _intersectionPolygons:Array = [];
      
      private var _terrain:TerrainGameObject;
      
      public function ReportTerrainDestroyedMessage(param1:TerrainGameObject)
      {
         super("TerrainDestroyed");
         this._terrain = param1;
      }
      
      public function get terrain() : TerrainGameObject
      {
         return this._terrain;
      }
   }
}

