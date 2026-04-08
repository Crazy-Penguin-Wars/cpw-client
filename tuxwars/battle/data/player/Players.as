package tuxwars.battle.data.player
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class Players
   {
      private static var playersTable:Table;
      
      private static var playerData:PlayerGameObjectData;
      
      private static const DEFAULT:String = "Default";
      
      private static const PLAYERStable:String = "PlayerCharacter";
      
      public function Players()
      {
         super();
         throw new Error("Players is a static class!");
      }
      
      public static function getPlayerData() : PlayerGameObjectData
      {
         var _loc1_:String = null;
         var _loc2_:Table = null;
         var _loc3_:Row = null;
         if(!playerData)
         {
            _loc1_ = "Default";
            _loc2_ = getTable();
            if(!_loc2_.getCache[_loc1_])
            {
               _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
               if(!_loc3_)
               {
                  LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_.getCache[_loc1_] = _loc3_;
            }
            playerData = new PlayerGameObjectData(_loc2_.getCache[_loc1_]);
         }
         return playerData;
      }
      
      public static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!playersTable)
         {
            _loc1_ = "PlayerCharacter";
            playersTable = ProjectManager.findTable(_loc1_);
         }
         return playersTable;
      }
   }
}

