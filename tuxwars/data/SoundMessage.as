package tuxwars.data
{
   import com.dchoc.messages.Message;
   import com.dchoc.utils.LogUtils;
   
   public class SoundMessage extends Message
   {
       
      
      private var _id:String;
      
      private var _path:String;
      
      private var _soundType:String;
      
      private var _playType:String;
      
      public function SoundMessage(type:String, id:String = null, path:String = null, soundType:String = null, playType:String = null)
      {
         super(type,null);
         this._id = id;
         this._path = path;
         this._soundType = soundType;
         this._playType = playType;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get path() : String
      {
         return _path;
      }
      
      public function get soundType() : int
      {
         switch(_soundType)
         {
            case "Music":
               return 0;
            case "Sfx":
               return 1;
            default:
               LogUtils.log("Undefined sound type: " + _soundType + " for musicID: " + _id,this,3,"Sounds",false,true,true);
               return -1;
         }
      }
      
      public function get playType() : String
      {
         return _playType;
      }
   }
}
