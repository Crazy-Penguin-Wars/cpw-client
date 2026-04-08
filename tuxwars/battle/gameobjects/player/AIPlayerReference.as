package tuxwars.battle.gameobjects.player
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class AIPlayerReference
   {
      private static const TABLE:String = "AIPlayer";
      
      private static const ID:String = "ID";
      
      private static const NAME:String = "Name";
      
      private static const TORSO:String = "Torso";
      
      private static const HEAD:String = "Head";
      
      private static const FEET:String = "Feet";
      
      private static const FACE:String = "Face";
      
      private static const COLOR:String = "Color";
      
      private static const TROPHY:String = "Trophy";
      
      private static const MINLEVEL:String = "MinLevel";
      
      private static const MAXLEVEL:String = "MaxLevel";
      
      private var row:Row;
      
      public function AIPlayerReference(param1:String)
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:Row = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:Row = null;
         super();
         if(param1)
         {
            _loc2_ = "AIPlayer";
            _loc3_ = param1;
            _loc4_ = ProjectManager.findTable(_loc2_);
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
            if(!this.row)
            {
               LogUtils.log("Row not found for AIID; " + param1 + " - Not using the AI values",this,2,"AI",false,false,true);
               _loc6_ = "AIPlayer";
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
      }
      
      private static function findFromTable() : String
      {
         var _loc1_:Table = ProjectManager.findTable("AIPlayer");
         var _loc2_:int = Math.random() * _loc1_._rows.length;
         var _loc3_:Row = _loc1_._rows[_loc2_];
         var _loc4_:Field = null;
         if(_loc3_)
         {
            if(!_loc3_.getCache["ID"])
            {
               _loc3_.getCache["ID"] = DCUtils.find(_loc3_.getFields(),"name","ID");
            }
            _loc4_ = _loc3_.getCache["ID"];
         }
         return !!_loc4_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public static function getRandomAI(param1:int) : String
      {
         var _loc5_:Row = null;
         var _loc7_:Field = null;
         var _loc8_:int = 0;
         var _loc9_:Field = null;
         var _loc10_:int = 0;
         var _loc2_:Table = ProjectManager.findTable("AIPlayer");
         var _loc3_:Array = _loc2_._rows;
         var _loc4_:Vector.<Row> = new Vector.<Row>();
         for each(_loc5_ in _loc3_)
         {
            if(_loc5_)
            {
               if(!_loc5_.getCache["MinLevel"])
               {
                  _loc5_.getCache["MinLevel"] = DCUtils.find(_loc5_.getFields(),"name","MinLevel");
               }
               _loc7_ = _loc5_.getCache["MinLevel"];
               _loc8_ = !!_loc7_ ? int(_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) : -1;
               if(!_loc5_.getCache["MaxLevel"])
               {
                  _loc5_.getCache["MaxLevel"] = DCUtils.find(_loc5_.getFields(),"name","MaxLevel");
               }
               _loc9_ = _loc5_.getCache["MaxLevel"];
               _loc10_ = !!_loc9_ ? int(_loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value) : -1;
               if(param1 <= _loc10_ && param1 >= _loc8_)
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         if(_loc4_.length <= 0)
         {
            LogUtils.addDebugLine("AI","No enemies at player level found","AIPlayerReference");
            return findFromTable();
         }
         var _loc6_:int = Math.random() * _loc4_.length;
         return _loc4_[_loc6_].id;
      }
      
      public function toObject() : Object
      {
         return {
            "id":this.AIID,
            "name":this.name,
            "worn_items":[this.torso,this.head,this.feet,this.face,this.color]
         };
      }
      
      public function setRow(param1:Row) : void
      {
         this.row = param1;
      }
      
      public function get AIID() : String
      {
         return !!this.row ? this.row.id : null;
      }
      
      public function get name() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Name";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get minLevel() : int
      {
         var _loc1_:Field = null;
         if(this.row)
         {
            if(!this.row.getCache["MinLevel"])
            {
               this.row.getCache["MinLevel"] = DCUtils.find(this.row.getFields(),"name","MinLevel");
            }
            _loc1_ = this.row.getCache["MinLevel"];
         }
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : int(_loc1_._value)) : -1;
      }
      
      public function get maxLevel() : int
      {
         var _loc1_:Field = null;
         if(this.row)
         {
            if(!this.row.getCache["MaxLevel"])
            {
               this.row.getCache["MaxLevel"] = DCUtils.find(this.row.getFields(),"name","MaxLevel");
            }
            _loc1_ = this.row.getCache["MaxLevel"];
         }
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : int(_loc1_._value)) : -1;
      }
      
      public function get torso() : String
      {
         var _loc1_:Field = null;
         if(this.row)
         {
            if(!this.row.getCache["Torso"])
            {
               this.row.getCache["Torso"] = DCUtils.find(this.row.getFields(),"name","Torso");
            }
            _loc1_ = this.row.getCache["Torso"];
         }
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value).id : null;
      }
      
      public function get head() : String
      {
         var _loc1_:Field = null;
         if(this.row)
         {
            if(!this.row.getCache["Head"])
            {
               this.row.getCache["Head"] = DCUtils.find(this.row.getFields(),"name","Head");
            }
            _loc1_ = this.row.getCache["Head"];
         }
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value).id : null;
      }
      
      public function get feet() : String
      {
         var _loc1_:Field = null;
         if(this.row)
         {
            if(!this.row.getCache["Feet"])
            {
               this.row.getCache["Feet"] = DCUtils.find(this.row.getFields(),"name","Feet");
            }
            _loc1_ = this.row.getCache["Feet"];
         }
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value).id : null;
      }
      
      public function get face() : String
      {
         var _loc1_:Field = null;
         if(this.row)
         {
            if(!this.row.getCache["Face"])
            {
               this.row.getCache["Face"] = DCUtils.find(this.row.getFields(),"name","Face");
            }
            _loc1_ = this.row.getCache["Face"];
         }
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value).id : null;
      }
      
      public function get color() : String
      {
         var _loc1_:Field = null;
         if(this.row)
         {
            if(!this.row.getCache["Color"])
            {
               this.row.getCache["Color"] = DCUtils.find(this.row.getFields(),"name","Color");
            }
            _loc1_ = this.row.getCache["Color"];
         }
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value).id : null;
      }
      
      public function get trophy() : String
      {
         var _loc1_:Field = null;
         if(this.row)
         {
            if(!this.row.getCache["Trophy"])
            {
               this.row.getCache["Trophy"] = DCUtils.find(this.row.getFields(),"name","Trophy");
            }
            _loc1_ = this.row.getCache["Trophy"];
         }
         return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value).id : null;
      }
   }
}

