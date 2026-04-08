package tuxwars.data
{
   import com.dchoc.projectdata.*;
   
   public class PlayerReportDatas
   {
      private static var table:Table;
      
      private static const TABLE:String = "PlayerStatistics";
      
      private static const PLAYER_REPORT_DATAS:Vector.<PlayerReportData> = new Vector.<PlayerReportData>();
      
      public function PlayerReportDatas()
      {
         super();
         throw new Error("PlayerReports is a static class!");
      }
      
      public static function get playerReportDatas() : Vector.<PlayerReportData>
      {
         if(PLAYER_REPORT_DATAS.length == 0)
         {
            initReportDatas();
         }
         return PLAYER_REPORT_DATAS;
      }
      
      private static function initReportDatas() : void
      {
         var rows:Array = null;
         var row:Row = null;
         var _loc1_:* = getTable();
         rows = _loc1_._rows;
         for each(row in rows)
         {
            PLAYER_REPORT_DATAS.push(new PlayerReportData(row));
         }
         PLAYER_REPORT_DATAS.sort(function(param1:PlayerReportData, param2:PlayerReportData):int
         {
            return param1.order - param2.order;
         });
      }
      
      private static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!table)
         {
            _loc1_ = "PlayerStatistics";
            table = ProjectManager.findTable(_loc1_);
         }
         return table;
      }
   }
}

