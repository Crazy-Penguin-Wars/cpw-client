package tuxwars.data
{
   import com.dchoc.messages.Message;
   import com.dchoc.utils.*;
   
   public class SoundMessage extends Message
   {
      private var _id:String;
      
      private var _path:String;
      
      private var _soundType:String;
      
      private var _playType:String;
      
      public function SoundMessage(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:String = null)
      {
         super(param1,null);
         this._id = param2;
         this._path = param3;
         this._soundType = param4;
         this._playType = param5;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get path() : String
      {
         return this._path;
      }
      
      public function get soundType() : int
      {
         switch(this._soundType)
         {
            case "Music":
               return 0;
            case "Sfx":
               return 1;
            default:
               LogUtils.log("Undefined sound type: " + this._soundType + " for musicID: " + this._id,this,3,"Sounds",false,true,true);
               return -1;
         }
      }
      
      public function get playType() : String
      {
         return this._playType;
      }
   }
}

