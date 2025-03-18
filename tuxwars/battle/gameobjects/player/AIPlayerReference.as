package tuxwars.battle.gameobjects.player
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
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
            var _loc6_:String = "AIPlayer";
            var _loc2_:ProjectManager = ProjectManager;
            var _loc7_:* = AIID;
            var _loc3_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc6_);
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
               var _loc9_:String = "AIPlayer";
               var _loc4_:ProjectManager = ProjectManager;
               var _loc10_:String = "NONE";
               var _loc5_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc9_);
               if(!_loc5_._cache[_loc10_])
               {
                  var _loc11_:Row = com.dchoc.utils.DCUtils.find(_loc5_.rows,"id",_loc10_);
                  if(!_loc11_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc10_ + "\' was found in table: \'" + _loc5_.name + "\'",_loc5_,3);
                  }
                  _loc5_._cache[_loc10_] = _loc11_;
               }
               row = _loc5_._cache[_loc10_];
            }
         }
      }
      
      private static function findFromTable() : String
      {
         var _loc10_:String = "AIPlayer";
         var _loc4_:ProjectManager = ProjectManager;
         var _loc5_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc10_);
         var _loc2_:int = Math.random() * _loc5_._rows.length;
         var _loc11_:String = "AIPlayer";
         var _loc6_:ProjectManager = ProjectManager;
         var _loc7_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc11_);
         var _loc3_:Row = _loc7_._rows[_loc2_];
         if(_loc3_)
         {
            var _loc12_:String = "ID";
            var _loc8_:* = _loc3_;
            if(!_loc8_._cache[_loc12_])
            {
               _loc8_._cache[_loc12_] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name",_loc12_);
            }
            §§push(_loc8_._cache[_loc12_]);
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
         var _loc3_:Field = null;
         var _loc2_:int = 0;
         var _loc8_:Field = null;
         var _loc5_:int = 0;
         var _loc18_:String = "AIPlayer";
         var _loc10_:ProjectManager = ProjectManager;
         var _loc11_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc18_);
         var _loc4_:Array = _loc11_._rows;
         var _loc6_:Vector.<Row> = new Vector.<Row>();
         for each(var row in _loc4_)
         {
            if(row)
            {
               var _loc19_:String = "MinLevel";
               var _loc12_:* = row;
               if(!_loc12_._cache[_loc19_])
               {
                  _loc12_._cache[_loc19_] = com.dchoc.utils.DCUtils.find(_loc12_._fields,"name",_loc19_);
               }
               §§push(_loc12_._cache[_loc19_]);
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
               var _loc20_:String = "MaxLevel";
               var _loc14_:* = row;
               if(!_loc14_._cache[_loc20_])
               {
                  _loc14_._cache[_loc20_] = com.dchoc.utils.DCUtils.find(_loc14_._fields,"name",_loc20_);
               }
               §§push(_loc14_._cache[_loc20_]);
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
         var _loc4_:String = "Name";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get minLevel() : int
      {
         if(row)
         {
            var _loc4_:String = "MinLevel";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "MaxLevel";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Torso";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Head";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Feet";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Face";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Color";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Trophy";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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

