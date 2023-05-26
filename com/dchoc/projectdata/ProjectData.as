package com.dchoc.projectdata
{
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import mx.utils.StringUtil;
   
   public class ProjectData
   {
      
      private static const CACHE:Object = {};
      
      private static const DATA_TYPE_ROW:String = "$DATA_TYPE";
      
      private static const ID_COLUMN:String = "ID";
      
      private static const REFERENCE_TOKEN:String = "#";
      
      private static const REFERENCE_SEPARATOR:String = ".";
      
      private static const LIST_SEPARATOR:String = ",";
      
      internal static const TEXTS_TABLE:String = "TID";
      
      private static const NEW_LINE_REG_EXP:RegExp = new RegExp("/\\n/g");
       
      
      private const tables:Array = [];
      
      public function ProjectData()
      {
         super();
      }
      
      public function parseFile(fileData:String) : void
      {
         loadTables(JSON.parse(fileData));
      }
      
      public function getTables() : Array
      {
         return tables;
      }
      
      public function findTable(name:String) : Table
      {
         if(!CACHE[name])
         {
            CACHE[name] = DCUtils.find(tables,"name",name);
         }
         return CACHE[name];
      }
      
      private function loadTables(data:Object) : void
      {
         var _loc3_:* = null;
         for(var tableName in data)
         {
            _loc3_ = new Table(tableName);
            loadRows(data[tableName],_loc3_);
            tables.push(_loc3_);
         }
      }
      
      private function loadRows(tableData:Object, table:Table) : void
      {
         var rowName:String;
         var row:Row;
         for(rowName in tableData)
         {
            if(rowName != "$DATA_TYPE")
            {
               row = new Row(rowName,table);
               loadFields(tableData[rowName],row);
               table.addRow(row);
            }
         }
         var _loc6_:Table = table;
         _loc6_._rows.sort(function(row1:Row, row2:Row):int
         {
            return row1.id.localeCompare(row2.id);
         });
      }
      
      private function loadFields(rowData:Object, row:Row) : void
      {
         var fieldName:String;
         var field:Field;
         for(fieldName in rowData)
         {
            var _loc8_:String = fieldName;
            var _loc3_:Row = row;
            if(!_loc3_._cache[_loc8_])
            {
               _loc3_._cache[_loc8_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc8_);
            }
            field = _loc3_._cache[_loc8_];
            if(field)
            {
               field.value = rowData[fieldName];
            }
            else
            {
               row.addField(createNewField(rowData,fieldName,row));
            }
         }
         var _loc7_:Row = row;
         _loc7_._fields.sort(function(field1:Field, field2:Field):int
         {
            return field1.name.localeCompare(field2.name);
         });
      }
      
      private function createNewField(rowData:Object, fieldName:String, row:Row) : Field
      {
         var _loc8_:* = null;
         var _loc5_:* = rowData[fieldName];
         var _loc4_:Field = new Field(row,fieldName);
         var _loc7_:Boolean = _loc5_ is String && _loc5_.search(",") != -1;
         var _loc9_:* = row;
         var _loc10_:* = _loc9_._table;
         if(_loc10_._name != "TID" && _loc7_)
         {
            _loc8_ = _loc5_.split(",");
            for(var index in _loc8_)
            {
               _loc8_[index] = StringUtil.trim(_loc8_[index]);
            }
            _loc4_.value = _loc8_;
         }
         else
         {
            var _loc13_:* = row;
            var _loc14_:* = _loc13_._table;
            _loc4_.value = _loc14_._name == "TID" ? _loc5_.replace(NEW_LINE_REG_EXP,"\n") : _loc5_;
         }
         return _loc4_;
      }
      
      public function link(languageCode:String) : void
      {
         var _loc12_:* = undefined;
         var _loc13_:* = null;
         var linkTableTemp:* = null;
         var linkRowTemp:* = null;
         var linkFieldTemp:* = null;
         var linkValueTemp:* = undefined;
         var _loc3_:Array = [];
         for each(var table in tables)
         {
            var _loc14_:* = table;
            for each(var row in _loc14_._rows)
            {
               var _loc15_:* = row;
               for each(var field in _loc15_._fields)
               {
                  var _loc16_:* = field;
                  _loc12_ = _loc16_.overrideValue != null ? _loc16_.overrideValue : _loc16_._value;
                  if(_loc12_ is Array)
                  {
                     for(var index in _loc12_)
                     {
                        var _loc17_:* = table;
                        createLink(languageCode,_loc3_,_loc12_[index] as String,_loc17_._name,row.id,field.name,index);
                     }
                  }
                  else if(_loc12_ is String)
                  {
                     var _loc20_:* = table;
                     createLink(languageCode,_loc3_,_loc12_ as String,_loc20_._name,row.id,field.name);
                  }
               }
            }
         }
         for each(var link in _loc3_)
         {
            _loc13_ = findLinkReference(link);
            if(link.arrayIndex != null)
            {
               linkTableTemp = findTable(link.tableName);
               var _loc34_:* = link.rowName;
               var _loc27_:* = linkTableTemp;
               if(!_loc27_._cache[_loc34_])
               {
                  var _loc35_:Row = com.dchoc.utils.DCUtils.find(_loc27_.rows,"id",_loc34_);
                  if(!_loc35_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc34_ + "\' was found in table: \'" + _loc27_.name + "\'",_loc27_,3);
                  }
                  _loc27_._cache[_loc34_] = _loc35_;
               }
               linkRowTemp = _loc27_._cache[_loc34_];
               var _loc36_:* = link.fieldName;
               var _loc28_:* = linkRowTemp;
               if(!_loc28_._cache[_loc36_])
               {
                  _loc28_._cache[_loc36_] = com.dchoc.utils.DCUtils.find(_loc28_._fields,"name",_loc36_);
               }
               linkFieldTemp = _loc28_._cache[_loc36_];
               var _loc29_:* = linkFieldTemp;
               linkValueTemp = _loc29_.overrideValue != null ? _loc29_.overrideValue : _loc29_._value;
               linkValueTemp[link.arrayIndex] = _loc13_;
            }
            else
            {
               var _loc37_:* = link.rowName;
               var _loc30_:* = findTable(link.tableName);
               if(!_loc30_._cache[_loc37_])
               {
                  var _loc38_:Row = com.dchoc.utils.DCUtils.find(_loc30_.rows,"id",_loc37_);
                  if(!_loc38_)
                  {
                     com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc37_ + "\' was found in table: \'" + _loc30_.name + "\'",_loc30_,3);
                  }
                  _loc30_._cache[_loc37_] = _loc38_;
               }
               var _loc39_:* = link.fieldName;
               var _loc31_:* = _loc30_._cache[_loc37_];
               if(!_loc31_._cache[_loc39_])
               {
                  _loc31_._cache[_loc39_] = com.dchoc.utils.DCUtils.find(_loc31_._fields,"name",_loc39_);
               }
               _loc31_._cache[_loc39_].value = _loc13_;
            }
         }
      }
      
      private function findLinkReference(link:Object) : Object
      {
         if(link.refFieldName)
         {
            var _loc5_:* = link.refRowName;
            var _loc2_:* = findTable(link.refTableName);
            if(!_loc2_._cache[_loc5_])
            {
               var _loc6_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc5_);
               if(!_loc6_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache[_loc5_] = _loc6_;
            }
            var _loc7_:* = link.refFieldName;
            var _loc3_:* = _loc2_._cache[_loc5_];
            if(!_loc3_._cache[_loc7_])
            {
               _loc3_._cache[_loc7_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc7_);
            }
            return _loc3_._cache[_loc7_];
         }
         if(link.refRowName)
         {
            var _loc8_:* = link.refRowName;
            var _loc4_:* = findTable(link.refTableName);
            if(!_loc4_._cache[_loc8_])
            {
               var _loc9_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc8_);
               if(!_loc9_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc8_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
               }
               _loc4_._cache[_loc8_] = _loc9_;
            }
            return _loc4_._cache[_loc8_];
         }
         if(link.refTableName)
         {
            return findTable(link.refTableName);
         }
         LogUtils.log("JsonParser: Couldn\'t find link reference: \'" + link + "\'",this,2,"Warning",true,false,false);
         return null;
      }
      
      private function createLink(languageCode:String, linkTable:Array, value:String, tableName:Object, rowName:Object, fieldName:Object, arrayIndex:Object = null) : void
      {
         var _loc10_:* = null;
         var _loc12_:* = null;
         var _loc9_:* = null;
         var _loc11_:* = null;
         var _loc8_:* = null;
         if(value)
         {
            _loc10_ = StringUtil.trim(value);
            if(_loc10_.charAt(0) == "#")
            {
               _loc12_ = _loc10_.split(".");
               if(_loc12_.length == 0 || _loc12_.length > 2)
               {
                  throw new Error("Invalid reference in " + tableName + ": " + _loc10_);
               }
               _loc9_ = _loc12_[0].substring(1,_loc12_[0].length);
               if(!findTable(_loc9_))
               {
                  throw new Error("Invalid reference in " + tableName + " : " + _loc10_);
               }
               _loc11_ = {};
               _loc11_.refTableName = _loc9_;
               if(_loc12_.length == 2)
               {
                  _loc8_ = _loc12_[1];
                  _loc11_.refRowName = _loc8_;
                  var _loc19_:* = _loc8_;
                  var _loc13_:* = findTable(_loc9_);
                  if(!_loc13_._cache[_loc19_])
                  {
                     var _loc20_:Row = com.dchoc.utils.DCUtils.find(_loc13_.rows,"id",_loc19_);
                     if(!_loc20_)
                     {
                        com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc19_ + "\' was found in table: \'" + _loc13_.name + "\'",_loc13_,3);
                     }
                     _loc13_._cache[_loc19_] = _loc20_;
                  }
                  if(!_loc13_._cache[_loc19_])
                  {
                     throw new Error("Invalid reference in " + tableName + ": " + _loc10_);
                  }
               }
               if(_loc9_ == "TID")
               {
                  if(_loc12_.length != 2)
                  {
                     throw new Error("Invalid text reference in " + tableName + ": " + _loc10_);
                  }
                  var _loc21_:* = _loc8_;
                  var _loc14_:* = findTable("TID");
                  if(!_loc14_._cache[_loc21_])
                  {
                     var _loc22_:Row = com.dchoc.utils.DCUtils.find(_loc14_.rows,"id",_loc21_);
                     if(!_loc22_)
                     {
                        com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc21_ + "\' was found in table: \'" + _loc14_.name + "\'",_loc14_,3);
                     }
                     _loc14_._cache[_loc21_] = _loc22_;
                  }
                  var _loc23_:* = languageCode;
                  var _loc15_:* = _loc14_._cache[_loc21_];
                  if(!_loc15_._cache[_loc23_])
                  {
                     _loc15_._cache[_loc23_] = com.dchoc.utils.DCUtils.find(_loc15_._fields,"name",_loc23_);
                  }
                  if(!_loc15_._cache[_loc23_] || (_loc18_.overrideValue != null ? _loc18_.overrideValue : _loc18_._value) == "")
                  {
                     throw new Error(_loc8_ + " is not defined in language " + languageCode);
                  }
                  _loc11_.refFieldName = languageCode;
               }
               _loc11_.tableName = tableName;
               _loc11_.rowName = rowName;
               _loc11_.fieldName = fieldName;
               _loc11_.arrayIndex = arrayIndex;
               linkTable.push(_loc11_);
            }
         }
      }
   }
}
