package com.dchoc.projectdata
{
   import com.dchoc.utils.*;
   import mx.utils.*;
   
   public class ProjectData
   {
      private static const DATA_TYPE_ROW:String = "$DATA_TYPE";
      
      private static const ID_COLUMN:String = "ID";
      
      private static const REFERENCE_TOKEN:String = "#";
      
      private static const REFERENCE_SEPARATOR:String = ".";
      
      private static const LIST_SEPARATOR:String = ",";
      
      internal static const TEXTStable:String = "TID";
      
      private static const CACHE:Object = {};
      
      private static const NEW_LINE_REG_EXP:RegExp = new RegExp("/\\n/g");
      
      private const tables:Array = [];
      
      public function ProjectData()
      {
         super();
      }
      
      public function parseFile(param1:String) : void
      {
         this.loadTables(JSON.parse(param1));
      }
      
      public function getTables() : Array
      {
         return this.tables;
      }
      
      public function findTable(param1:String) : Table
      {
         if(!CACHE[param1])
         {
            CACHE[param1] = DCUtils.find(this.tables,"name",param1);
         }
         return CACHE[param1];
      }
      
      private function loadTables(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Table = null;
         for(_loc3_ in param1)
         {
            _loc2_ = new Table(_loc3_);
            this.loadRows(param1[_loc3_],_loc2_);
            this.tables.push(_loc2_);
         }
      }
      
      private function loadRows(param1:Object, param2:Table) : void
      {
         var rowName:String = null;
         var row:Row = null;
         var _loc6_:Table = null;
         var tableData:Object = param1;
         var table:Table = param2;
         for(rowName in tableData)
         {
            if(rowName != "$DATA_TYPE")
            {
               row = new Row(rowName,table);
               this.loadFields(tableData[rowName],row);
               table.addRow(row);
            }
         }
         _loc6_ = table;
         _loc6_._rows.sort(function(param1:Row, param2:Row):int
         {
            return param1.id.localeCompare(param2.id);
         });
      }
      
      private function loadFields(param1:Object, param2:Row) : void
      {
         var fieldName:String = null;
         var field:Field = null;
         var _loc7_:Row = null;
         var _loc8_:String = null;
         var _loc3_:Row = null;
         var rowData:Object = param1;
         var row:Row = param2;
         for(fieldName in rowData)
         {
            _loc8_ = fieldName;
            _loc3_ = row;
            if(!_loc3_.getCache[_loc8_])
            {
               _loc3_.getCache[_loc8_] = DCUtils.find(_loc3_.getFields(),"name",_loc8_);
            }
            field = _loc3_.getCache[_loc8_];
            if(field)
            {
               field.value = rowData[fieldName];
            }
            else
            {
               row.addField(this.createNewField(rowData,fieldName,row));
            }
         }
         _loc7_ = row;
         _loc7_.getFields().sort(function(param1:Field, param2:Field):int
         {
            return param1.name.localeCompare(param2.name);
         });
      }
      
      private function createNewField(param1:Object, param2:String, param3:Row) : Field
      {
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc4_:Array = null;
         var _loc5_:* = param1[param2];
         var _loc6_:Field = new Field(param3,param2);
         var _loc7_:Boolean = _loc5_ is String && _loc5_.search(",") != -1;
         var _loc8_:* = param3;
         var _loc9_:* = _loc8_.table;
         if(_loc9_._name != "TID" && _loc7_)
         {
            _loc4_ = _loc5_.split(",");
            for(_loc10_ in _loc4_)
            {
               _loc4_[_loc10_] = StringUtil.trim(_loc4_[_loc10_]);
            }
            _loc6_.value = _loc4_;
         }
         else
         {
            _loc11_ = param3;
            _loc12_ = _loc11_.table;
            _loc6_.value = _loc12_._name == "TID" ? _loc5_.replace(NEW_LINE_REG_EXP,"\n") : _loc5_;
         }
         return _loc6_;
      }
      
      public function link(param1:String) : void
      {
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc24_:Row = null;
         var _loc25_:* = undefined;
         var _loc26_:* = undefined;
         var _loc27_:* = undefined;
         var _loc28_:* = undefined;
         var _loc29_:Row = null;
         var _loc2_:* = undefined;
         var _loc3_:Object = null;
         var _loc4_:Table = null;
         var _loc5_:Row = null;
         var _loc6_:Field = null;
         var _loc7_:* = undefined;
         var _loc8_:Array = [];
         for each(_loc9_ in this.tables)
         {
            _loc11_ = _loc9_;
            for each(_loc12_ in _loc11_._rows)
            {
               _loc13_ = _loc12_;
               for each(_loc14_ in _loc13_.getFields())
               {
                  _loc15_ = _loc14_;
                  _loc2_ = _loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value;
                  if(_loc2_ is Array)
                  {
                     for(_loc16_ in _loc2_)
                     {
                        _loc17_ = _loc9_;
                        this.createLink(param1,_loc8_,_loc2_[_loc16_] as String,_loc17_._name,_loc12_.id,_loc14_.name,_loc16_);
                     }
                  }
                  else if(_loc2_ is String)
                  {
                     _loc18_ = _loc9_;
                     this.createLink(param1,_loc8_,_loc2_ as String,_loc18_._name,_loc12_.id,_loc14_.name);
                  }
               }
            }
         }
         for each(_loc10_ in _loc8_)
         {
            _loc3_ = this.findLinkReference(_loc10_);
            if(_loc10_.arrayIndex != null)
            {
               _loc4_ = this.findTable(_loc10_.tableName);
               _loc19_ = _loc10_.rowName;
               _loc20_ = _loc4_;
               if(!_loc20_.getCache[_loc19_])
               {
                  _loc24_ = DCUtils.find(_loc20_.rows,"id",_loc19_);
                  if(!_loc24_)
                  {
                     LogUtils.log("No row with name: \'" + _loc19_ + "\' was found in table: \'" + _loc20_.name + "\'",_loc20_,3);
                  }
                  _loc20_.getCache[_loc19_] = _loc24_;
               }
               _loc5_ = _loc20_.getCache[_loc19_];
               _loc21_ = _loc10_.fieldName;
               _loc22_ = _loc5_;
               if(!_loc22_.getCache[_loc21_])
               {
                  _loc22_.getCache[_loc21_] = DCUtils.find(_loc22_.getFields(),"name",_loc21_);
               }
               _loc23_ = _loc6_ = _loc22_.getCache[_loc21_];
               _loc7_ = _loc23_.overrideValue != null ? _loc23_.overrideValue : _loc23_._value;
               _loc7_[_loc10_.arrayIndex] = _loc3_;
            }
            else
            {
               _loc25_ = _loc10_.rowName;
               _loc26_ = this.findTable(_loc10_.tableName);
               if(!_loc26_.getCache[_loc25_])
               {
                  _loc29_ = DCUtils.find(_loc26_.rows,"id",_loc25_);
                  if(!_loc29_)
                  {
                     LogUtils.log("No row with name: \'" + _loc25_ + "\' was found in table: \'" + _loc26_.name + "\'",_loc26_,3);
                  }
                  _loc26_.getCache[_loc25_] = _loc29_;
               }
               _loc27_ = _loc10_.fieldName;
               _loc28_ = _loc26_.getCache[_loc25_];
               if(!_loc28_.getCache[_loc27_])
               {
                  _loc28_.getCache[_loc27_] = DCUtils.find(_loc28_.getFields(),"name",_loc27_);
               }
               _loc28_.getCache[_loc27_].value = _loc3_;
            }
         }
      }
      
      private function findLinkReference(param1:Object) : Object
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:Row = null;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:Row = null;
         if(param1.refFieldName)
         {
            _loc2_ = param1.refRowName;
            _loc3_ = this.findTable(param1.refTableName);
            if(!_loc3_.getCache[_loc2_])
            {
               _loc6_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
               if(!_loc6_)
               {
                  LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
               }
               _loc3_.getCache[_loc2_] = _loc6_;
            }
            _loc4_ = param1.refFieldName;
            _loc5_ = _loc3_.getCache[_loc2_];
            if(!_loc5_.getCache[_loc4_])
            {
               _loc5_.getCache[_loc4_] = DCUtils.find(_loc5_.getFields(),"name",_loc4_);
            }
            return _loc5_.getCache[_loc4_];
         }
         if(param1.refRowName)
         {
            _loc7_ = param1.refRowName;
            _loc8_ = this.findTable(param1.refTableName);
            if(!_loc8_.getCache[_loc7_])
            {
               _loc9_ = DCUtils.find(_loc8_.rows,"id",_loc7_);
               if(!_loc9_)
               {
                  LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc8_.name + "\'",_loc8_,3);
               }
               _loc8_.getCache[_loc7_] = _loc9_;
            }
            return _loc8_.getCache[_loc7_];
         }
         if(param1.refTableName)
         {
            return this.findTable(param1.refTableName);
         }
         LogUtils.log("JsonParser: Couldn\'t find link reference: \'" + param1 + "\'",this,2,"Warning",true,false,false);
         return null;
      }
      
      private function createLink(param1:String, param2:Array, param3:String, param4:Object, param5:Object, param6:Object, param7:Object = null) : void
      {
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:Row = null;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:Row = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         if(param3)
         {
            _loc8_ = StringUtil.trim(param3);
            if(_loc8_.charAt(0) == "#")
            {
               _loc9_ = _loc8_.split(".");
               if(_loc9_.length == 0 || _loc9_.length > 2)
               {
                  throw new Error("Invalid reference in " + param4 + ": " + _loc8_);
               }
               _loc10_ = _loc9_[0].substring(1,_loc9_[0].length);
               if(!this.findTable(_loc10_))
               {
                  throw new Error("Invalid reference in " + param4 + " : " + _loc8_);
               }
               _loc11_ = {};
               _loc11_.refTableName = _loc10_;
               if(_loc9_.length == 2)
               {
                  _loc12_ = _loc9_[1];
                  _loc11_.refRowName = _loc12_;
                  _loc13_ = _loc12_;
                  _loc14_ = this.findTable(_loc10_);
                  if(!_loc14_.getCache[_loc13_])
                  {
                     _loc15_ = DCUtils.find(_loc14_.rows,"id",_loc13_);
                     if(!_loc15_)
                     {
                        LogUtils.log("No row with name: \'" + _loc13_ + "\' was found in table: \'" + _loc14_.name + "\'",_loc14_,3);
                     }
                     _loc14_.getCache[_loc13_] = _loc15_;
                  }
                  if(!_loc14_.getCache[_loc13_])
                  {
                     throw new Error("Invalid reference in " + param4 + ": " + _loc8_);
                  }
               }
               if(_loc10_ == "TID")
               {
                  if(_loc9_.length != 2)
                  {
                     throw new Error("Invalid text reference in " + param4 + ": " + _loc8_);
                  }
                  _loc16_ = _loc12_;
                  _loc17_ = this.findTable("TID");
                  if(!_loc17_.getCache[_loc16_])
                  {
                     _loc20_ = DCUtils.find(_loc17_.rows,"id",_loc16_);
                     if(!_loc20_)
                     {
                        LogUtils.log("No row with name: \'" + _loc16_ + "\' was found in table: \'" + _loc17_.name + "\'",_loc17_,3);
                     }
                     _loc17_.getCache[_loc16_] = _loc20_;
                  }
                  _loc18_ = param1;
                  _loc19_ = _loc17_.getCache[_loc16_];
                  if(!_loc19_.getCache[_loc18_])
                  {
                     _loc19_.getCache[_loc18_] = DCUtils.find(_loc19_.getFields(),"name",_loc18_);
                  }
                  if(!_loc19_.getCache[_loc18_] || (_loc19_.getCache[_loc18_].overrideValue != null ? _loc19_.getCache[_loc18_].overrideValue : _loc19_.getCache[_loc18_]._value) == "")
                  {
                     throw new Error(_loc12_ + " is not defined in language " + param1);
                  }
                  _loc11_.refFieldName = param1;
               }
               _loc11_.tableName = param4;
               _loc11_.rowName = param5;
               _loc11_.fieldName = param6;
               _loc11_.arrayIndex = param7;
               param2.push(_loc11_);
            }
         }
      }
   }
}

