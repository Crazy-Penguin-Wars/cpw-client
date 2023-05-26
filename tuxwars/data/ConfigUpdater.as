package tuxwars.data
{
   import avmplus.getQualifiedClassName;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.LogUtils;
   
   public class ConfigUpdater
   {
      
      private static const ID:String = "id".toLowerCase();
      
      private static var classNameThis:String = getQualifiedClassName(ConfigUpdater);
       
      
      public function ConfigUpdater()
      {
         super();
         throw new Error("ConfigUpdater is a static class!");
      }
      
      public static function updateConfig(data:Array) : void
      {
         var _loc2_:* = null;
         if(data == null || data.length == 0)
         {
            return;
         }
         for each(var obj in data)
         {
            if(!(obj.tables == null || obj.tables.table == null))
            {
               _loc2_ = obj.tables.table is Array ? obj.tables.table : [obj.tables.table];
               for each(var table in _loc2_)
               {
                  handleTable(table);
               }
            }
         }
      }
      
      private static function handleTable(table:Object) : void
      {
         if(table == null || table.name == null || table.row == null)
         {
            return;
         }
         var _loc3_:Table = ProjectManager.getProjectData().findTable(table.name);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Array = table.row is Array ? table.row : [table.row];
         for each(var item in _loc4_)
         {
            handleItem(table.name,_loc3_,item);
         }
      }
      
      private static function handleItem(tableName:String, tableConfig:Table, row:Object, showExtraInformation:Boolean = false) : void
      {
         var hasField:Boolean = false;
         var _loc5_:* = null;
         if(row.Id == null)
         {
            return;
         }
         var _loc19_:* = row.Id;
         var _loc10_:* = tableConfig;
         if(!_loc10_._cache[_loc19_])
         {
            var _loc20_:Row = com.dchoc.utils.DCUtils.find(_loc10_.rows,"id",_loc19_);
            if(!_loc20_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc19_ + "\' was found in table: \'" + _loc10_.name + "\'",_loc10_,3);
            }
            _loc10_._cache[_loc19_] = _loc20_;
         }
         var _loc6_:Row = _loc10_._cache[_loc19_];
         if(_loc6_ == null)
         {
            return;
         }
         for(var key in row)
         {
            if(key.toLowerCase() != ID)
            {
               hasField = false;
               var _loc11_:* = _loc6_;
               for each(var fieldConfig in _loc11_._fields)
               {
                  if(fieldConfig.name == key)
                  {
                     hasField = true;
                     fieldConfig.override(row[key]);
                     var _loc12_:* = fieldConfig;
                     LogUtils.log("Overriding table: " + tableName + " fieldName: " + key + " in rowID: " + _loc6_.id + " old value: " + fieldConfig.originalValue + " new value: " + (_loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value),"ConfigUpdater",0,"CRMDataOverride");
                  }
               }
               if(!hasField)
               {
                  _loc6_.addField(new Field(_loc6_,key));
                  var _loc21_:* = key;
                  var _loc15_:* = _loc6_;
                  if(!_loc15_._cache[_loc21_])
                  {
                     _loc15_._cache[_loc21_] = com.dchoc.utils.DCUtils.find(_loc15_._fields,"name",_loc21_);
                  }
                  _loc5_ = _loc15_._cache[_loc21_];
                  _loc5_.override(row[key]);
                  var _loc16_:* = _loc5_;
                  LogUtils.log("Creating field " + key + " to table: " + tableName + " in rowID: " + _loc6_.id + " old value: " + _loc5_.originalValue + " new value: " + (_loc16_.overrideValue != null ? _loc16_.overrideValue : _loc16_._value),"ConfigUpdater",0,"CRMDataOverride");
               }
            }
         }
      }
   }
}
