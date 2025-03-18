package tuxwars.battle.data.player
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
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
            var _loc2_:String = "Default";
            var _loc1_:* = getTable();
            §§push(§§findproperty(PlayerGameObjectData));
            if(!_loc1_._cache[_loc2_])
            {
               var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
               if(!_loc3_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
               }
               _loc1_._cache[_loc2_] = _loc3_;
            }
            playerData = new §§pop().PlayerGameObjectData(_loc1_._cache[_loc2_]);
         }
         return playerData;
      }
      
      public static function getTable() : Table
      {
         if(!playersTable)
         {
            var _loc2_:String = "PlayerCharacter";
            var _loc1_:ProjectManager = ProjectManager;
            playersTable = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc2_);
         }
         return playersTable;
      }
   }
}

