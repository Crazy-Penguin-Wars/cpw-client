package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class SoundReference
   {
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
      
      private static const CACHE:Object = {};
      
      private var _fieldCache:Object;
      
      private var row:Row;
      
      public function SoundReference()
      {
         super();
      }
      
      public static function get(param1:String) : SoundReference
      {
         var _loc2_:SoundReference = null;
         if(param1 != "" && param1 != null)
         {
            if(!CACHE.hasOwnProperty(param1))
            {
               _loc2_ = new SoundReference();
               _loc2_.init(param1);
               CACHE[param1] = _loc2_;
            }
            return CACHE[param1];
         }
         return null;
      }
      
      public function init(param1:String) : void
      {
         var _loc5_:Row = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:Row = null;
         this._fieldCache = {};
         var _loc2_:String = "Sound";
         var _loc3_:* = param1;
         var _loc4_:* = ProjectManager.findTable(_loc2_);
         if(!_loc4_.getCache[_loc3_])
         {
            _loc5_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc5_;
         }
         this.row = _loc4_.getCache[_loc3_];
         if(this.row == null)
         {
            _loc6_ = "Sound";
            _loc7_ = "NONE";
            _loc8_ = ProjectManager.findTable(_loc6_);
            if(!_loc8_.getCache[_loc7_])
            {
               _loc9_ = DCUtils.find(_loc8_.rows,"id",_loc7_);
               if(!_loc9_)
               {
                  LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc8_.name + "\'",_loc8_,3);
               }
               _loc8_.getCache[_loc7_] = _loc9_;
            }
            this.row = _loc8_.getCache[_loc7_];
         }
      }
      
      private function checkMP3(param1:String) : String
      {
         if(param1 == null || param1.search(".mp3") == -1)
         {
            return null;
         }
         return param1;
      }
      
      private function getField(param1:String) : Field
      {
         var _loc2_:Field = null;
         if(!this._fieldCache.hasOwnProperty(param1))
         {
            _loc2_ = null;
            if(this.row)
            {
               if(!this.row.getCache[param1])
               {
                  this.row.getCache[param1] = DCUtils.find(this.row.getFields(),"name",param1);
               }
               _loc2_ = this.row.getCache[param1];
            }
            this._fieldCache[param1] = _loc2_;
         }
         return this._fieldCache[param1];
      }
      
      private function getMusicPath(param1:String) : String
      {
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:Field = this.getField(param1);
         _loc4_ = _loc3_;
         var _loc5_:Array = !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
         if(_loc5_ == null || _loc5_.length == 0)
         {
            return null;
         }
         if(_loc5_.length == 1)
         {
            return this.checkMP3(Config.getDataDir() + _loc5_[0]);
         }
         _loc2_ = Math.floor(_loc5_.length * Math.random());
         return this.checkMP3(Config.getDataDir() + _loc5_[_loc2_]);
      }
      
      public function getArrayColumn(param1:String) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Field = this.getField(param1);
         return _loc2_ != null ? (_loc3_ = _loc2_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function getStart() : String
      {
         return this.getMusicPath("Start");
      }
      
      public function getLoop() : String
      {
         return this.getMusicPath("Loop");
      }
      
      public function getEnd() : String
      {
         return this.getMusicPath("End");
      }
      
      public function getCollision() : String
      {
         return this.getMusicPath("Collision");
      }
      
      public function getMusicID() : String
      {
         return !!this.row ? this.row.id : null;
      }
      
      public function getCollisionPriority() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("CollisionPriority");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : -1;
      }
      
      public function getType() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Type");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      public function getMultiple() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Multiple");
         return !!_loc1_ ? (_loc2_ = _loc1_, (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) == "true") : false;
      }
      
      public function getDamage() : String
      {
         return this.getMusicPath("Damage");
      }
      
      public function getLoadNumber() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("LoadNumber");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
   }
}

