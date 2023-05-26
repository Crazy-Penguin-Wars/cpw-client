package tuxwars.data
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class PlayerReportDatas
   {
      
      private static const TABLE:String = "PlayerStatistics";
      
      private static const PLAYER_REPORT_DATAS:Vector.<PlayerReportData> = new Vector.<PlayerReportData>();
      
      private static var table:Table;
       
      
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
         var rows:Array;
         var row:Row;
         var _loc1_:* = getTable();
         rows = _loc1_._rows;
         for each(row in rows)
         {
            PLAYER_REPORT_DATAS.push(new PlayerReportData(row));
         }
         PLAYER_REPORT_DATAS.sort(function(data1:PlayerReportData, data2:PlayerReportData):int
         {
            return data1.order - data2.order;
         });
      }
      
      private static function getTable() : Table
      {
         if(!table)
         {
            var _loc1_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable("PlayerStatistics");
         }
         return table;
      }
   }
}
