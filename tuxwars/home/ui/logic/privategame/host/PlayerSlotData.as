package tuxwars.home.ui.logic.privategame.host
{
   import com.dchoc.projectdata.*;
   import tuxwars.items.*;
   
   public class PlayerSlotData
   {
      private const _clothes:Vector.<ClothingItem> = new Vector.<ClothingItem>();
      
      private var _id:String;
      
      private var _name:String;
      
      private var _level:int;
      
      private var _pictureURL:String;
      
      public function PlayerSlotData(param1:String, param2:String, param3:int, param4:String)
      {
         super();
         this._id = param1;
         this._name = param2 != null ? param2 : ProjectManager.getText("DEFAULT_FRIEND_NAME");
         this._level = param3;
         this._pictureURL = param4 != null ? param4 : "";
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get clothes() : Vector.<ClothingItem>
      {
         return this._clothes;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function get pictureURL() : String
      {
         return this._pictureURL;
      }
   }
}

