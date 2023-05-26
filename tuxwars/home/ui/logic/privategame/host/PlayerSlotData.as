package tuxwars.home.ui.logic.privategame.host
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.items.ClothingItem;
   
   public class PlayerSlotData
   {
       
      
      private const _clothes:Vector.<ClothingItem> = new Vector.<ClothingItem>();
      
      private var _id:String;
      
      private var _name:String;
      
      private var _level:int;
      
      private var _pictureURL:String;
      
      public function PlayerSlotData(id:String, name:String, level:int, pictureURL:String)
      {
         super();
         _id = id;
         _name = name != null ? name : ProjectManager.getText("DEFAULT_FRIEND_NAME");
         _level = level;
         _pictureURL = pictureURL != null ? pictureURL : "";
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get clothes() : Vector.<ClothingItem>
      {
         return _clothes;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get pictureURL() : String
      {
         return _pictureURL;
      }
   }
}
