package tuxwars.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
   public class SoundReference
   {
      
      private static const CACHE:Object = {};
      
      public static const TABLE:String = "Sound";
      
      public static const START:String = "Start";
      
      public static const LOOP:String = "Loop";
      
      public static const END:String = "End";
      
      private static const TYPE:String = "Type";
      
      private static const COLLISIONPRIORITY:String = "CollisionPriority";
      
      private static const MULTIPLE:String = "Multiple";
      
      private static const DAMAGE:String = "Damage";
      
      public static const COLLISION:String = "Collision";
      
      private static const LOADNUMBER:String = "LoadNumber";
      
      public static const TYPE_MUSIC:String = "Music";
      
      public static const TYPE_SOUND:String = "Sfx";
       
      
      private var _fieldCache:Object;
      
      private var row:Row;
      
      public function SoundReference()
      {
         super();
      }
      
      public static function get(musicID:String) : SoundReference
      {
         var _loc2_:* = null;
         if(musicID != "" && musicID != null)
         {
            if(!CACHE.hasOwnProperty(musicID))
            {
               _loc2_ = new SoundReference();
               _loc2_.init(musicID);
               CACHE[musicID] = _loc2_;
            }
            return CACHE[musicID];
         }
         return null;
      }
      
      public function init(musicID:String) : void
      {
         _fieldCache = {};
         var _loc2_:ProjectManager = ProjectManager;
         var _loc7_:* = musicID;
         var _loc3_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Sound");
         if(!_loc3_._cache[_loc7_])
         {
            var _loc8_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc7_);
            if(!_loc8_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc7_] = _loc8_;
         }
         row = _loc3_._cache[_loc7_];
         if(row == null)
         {
            var _loc4_:ProjectManager = ProjectManager;
            var _loc5_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Sound");
            if(!_loc5_._cache["NONE"])
            {
               var _loc11_:Row = com.dchoc.utils.DCUtils.find(_loc5_.rows,"id","NONE");
               if(!_loc11_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "NONE" + "\' was found in table: \'" + _loc5_.name + "\'",_loc5_,3);
               }
               _loc5_._cache["NONE"] = _loc11_;
            }
            row = _loc5_._cache["NONE"];
         }
      }
      
      private function checkMP3(value:String) : String
      {
         if(value == null || value.search(".mp3") == -1)
         {
            return null;
         }
         return value;
      }
      
      private function getField(name:String) : Field
      {
         if(!_fieldCache.hasOwnProperty(name))
         {
            §§push(_fieldCache);
            §§push(name);
            if(row)
            {
               var _loc3_:* = name;
               var _loc2_:Row = row;
               if(!_loc2_._cache[_loc3_])
               {
                  _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
               }
               §§push(_loc2_._cache[_loc3_]);
            }
            else
            {
               §§push(null);
            }
            §§pop()[§§pop()] = §§pop();
         }
         return _fieldCache[name];
      }
      
      private function getMusicPath(type:String) : String
      {
         var rnd:int = 0;
         var _loc2_:Field = getField(type);
         var _loc5_:*;
         var _loc3_:Array = !!_loc2_ ? (_loc5_ = _loc2_, _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) : null;
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return null;
         }
         if(_loc3_.length == 1)
         {
            return checkMP3(Config.getDataDir() + _loc3_[0]);
         }
         rnd = Math.floor(_loc3_.length * Math.random());
         return checkMP3(Config.getDataDir() + _loc3_[rnd]);
      }
      
      public function getArrayColumn(value:String) : Array
      {
         var _loc2_:Field = getField(value);
         var _loc3_:*;
         return _loc2_ != null ? (_loc3_ = _loc2_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function getStart() : String
      {
         return getMusicPath("Start");
      }
      
      public function getLoop() : String
      {
         return getMusicPath("Loop");
      }
      
      public function getEnd() : String
      {
         return getMusicPath("End");
      }
      
      public function getCollision() : String
      {
         return getMusicPath("Collision");
      }
      
      public function getMusicID() : String
      {
         return !!row ? row.id : null;
      }
      
      public function getCollisionPriority() : int
      {
         var _loc1_:Field = getField("CollisionPriority");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : -1;
      }
      
      public function getType() : String
      {
         var _loc1_:Field = getField("Type");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      public function getMultiple() : Boolean
      {
         var _loc1_:Field = getField("Multiple");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) == "true") : false;
      }
      
      public function getDamage() : String
      {
         return getMusicPath("Damage");
      }
      
      public function getLoadNumber() : int
      {
         var _loc1_:Field = getField("LoadNumber");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
   }
}
