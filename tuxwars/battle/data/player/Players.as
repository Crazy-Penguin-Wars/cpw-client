package tuxwars.battle.data.player
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class Players
   {
      
      private static const DEFAULT:String = "Default";
      
      private static const PLAYERS_TABLE:String = "PlayerCharacter";
      
      private static var playersTable:Table;
      
      private static var playerData:PlayerGameObjectData;
       
      
      public function Players()
      {
         super();
         throw new Error("Players is a static class!");
      }
      
      public static function getPlayerData() : PlayerGameObjectData
      {
         if(!playerData)
         {
            var _loc1_:* = getTable();
            §§push(§§findproperty(PlayerGameObjectData));
            if(!_loc1_._cache["Default"])
            {
               var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","Default");
               if(!_loc3_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
               }
               _loc1_._cache["Default"] = _loc3_;
            }
            playerData = new §§pop().PlayerGameObjectData(_loc1_._cache["Default"]);
         }
         return playerData;
      }
      
      public static function getTable() : Table
      {
         if(!playersTable)
         {
            var _loc1_:ProjectManager = ProjectManager;
            playersTable = com.dchoc.projectdata.ProjectManager.projectData.findTable("PlayerCharacter");
         }
         return playersTable;
      }
   }
}
