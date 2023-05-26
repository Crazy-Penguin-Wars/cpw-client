package tuxwars.battle.gameobjects.player
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   
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
      
      public function AIPlayerReference(AIID:String)
      {
         super();
         if(AIID)
         {
            var _loc2_:ProjectManager = ProjectManager;
            var _loc7_:* = AIID;
            var _loc3_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("AIPlayer");
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
            if(!row)
            {
               LogUtils.log("Row not found for AIID; " + AIID + " - Not using the AI values",this,2,"AI",false,false,true);
               var _loc4_:ProjectManager = ProjectManager;
               var _loc5_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("AIPlayer");
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
      }
      
      private static function findFromTable() : String
      {
         var _loc4_:ProjectManager = ProjectManager;
         var _loc5_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("AIPlayer");
         var _loc2_:int = Math.random() * Number(_loc5_._rows.length);
         var _loc6_:ProjectManager = ProjectManager;
         var _loc7_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("AIPlayer");
         var _loc3_:Row = _loc7_._rows[_loc2_];
         if(_loc3_)
         {
            var _loc8_:* = _loc3_;
            if(!_loc8_._cache["ID"])
            {
               _loc8_._cache["ID"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","ID");
            }
            §§push(_loc8_._cache["ID"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc9_:*;
         return !!_loc1_ ? (_loc9_ = _loc1_, _loc9_.overrideValue != null ? _loc9_.overrideValue : _loc9_._value) : null;
      }
      
      public static function getRandomAI(playerLevel:int) : String
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc8_:* = null;
         var _loc5_:int = 0;
         var _loc10_:ProjectManager = ProjectManager;
         var _loc11_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("AIPlayer");
         var _loc4_:Array = _loc11_._rows;
         var _loc6_:Vector.<Row> = new Vector.<Row>();
         for each(var row in _loc4_)
         {
            if(row)
            {
               var _loc12_:* = row;
               if(!_loc12_._cache["MinLevel"])
               {
                  _loc12_._cache["MinLevel"] = com.dchoc.utils.DCUtils.find(_loc12_._fields,"name","MinLevel");
               }
               §§push(_loc12_._cache["MinLevel"]);
            }
            else
            {
               §§push(null);
            }
            _loc3_ = §§pop();
            var _loc13_:*;
            _loc2_ = int(!!_loc3_ ? (_loc13_ = _loc3_, _loc13_.overrideValue != null ? _loc13_.overrideValue : _loc13_._value) : -1);
            if(row)
            {
               var _loc14_:* = row;
               if(!_loc14_._cache["MaxLevel"])
               {
                  _loc14_._cache["MaxLevel"] = com.dchoc.utils.DCUtils.find(_loc14_._fields,"name","MaxLevel");
               }
               §§push(_loc14_._cache["MaxLevel"]);
            }
            else
            {
               §§push(null);
            }
            _loc8_ = §§pop();
            var _loc15_:*;
            _loc5_ = int(!!_loc8_ ? (_loc15_ = _loc8_, _loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value) : -1);
            if(playerLevel <= _loc5_ && playerLevel >= _loc2_)
            {
               _loc6_.push(row);
            }
         }
         if(_loc6_.length <= 0)
         {
            LogUtils.addDebugLine("AI","No enemies at player level found","AIPlayerReference");
            return findFromTable();
         }
         var _loc7_:int = Math.random() * _loc6_.length;
         return _loc6_[_loc7_].id;
      }
      
      public function toObject() : Object
      {
         return {
            "id":AIID,
            "name":name,
            "worn_items":[torso,head,feet,face,color]
         };
      }
      
      public function setRow(value:Row) : void
      {
         row = value;
      }
      
      public function get AIID() : String
      {
         return !!row ? row.id : null;
      }
      
      public function get name() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Name"])
         {
            _loc2_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Name");
         }
         var _loc1_:Field = _loc2_._cache["Name"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get minLevel() : int
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["MinLevel"])
            {
               _loc2_._cache["MinLevel"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","MinLevel");
            }
            §§push(_loc2_._cache["MinLevel"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : -1;
      }
      
      public function get maxLevel() : int
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["MaxLevel"])
            {
               _loc2_._cache["MaxLevel"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","MaxLevel");
            }
            §§push(_loc2_._cache["MaxLevel"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : -1;
      }
      
      public function get torso() : String
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["Torso"])
            {
               _loc2_._cache["Torso"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Torso");
            }
            §§push(_loc2_._cache["Torso"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value).id) : null;
      }
      
      public function get head() : String
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["Head"])
            {
               _loc2_._cache["Head"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Head");
            }
            §§push(_loc2_._cache["Head"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value).id) : null;
      }
      
      public function get feet() : String
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["Feet"])
            {
               _loc2_._cache["Feet"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Feet");
            }
            §§push(_loc2_._cache["Feet"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value).id) : null;
      }
      
      public function get face() : String
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["Face"])
            {
               _loc2_._cache["Face"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Face");
            }
            §§push(_loc2_._cache["Face"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value).id) : null;
      }
      
      public function get color() : String
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["Color"])
            {
               _loc2_._cache["Color"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Color");
            }
            §§push(_loc2_._cache["Color"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value).id) : null;
      }
      
      public function get trophy() : String
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["Trophy"])
            {
               _loc2_._cache["Trophy"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Trophy");
            }
            §§push(_loc2_._cache["Trophy"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value).id) : null;
      }
   }
}
