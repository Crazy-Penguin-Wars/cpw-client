package tuxwars.data
{
   import avmplus.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class ConfigUpdater
   {
      private static const ID:String = "id".toLowerCase();
      
      private static var classNameThis:String = getQualifiedClassName(ConfigUpdater);
      
      public function ConfigUpdater()
      {
         super();
         throw new Error("ConfigUpdater is a static class!");
      }
      
      public static function updateConfig(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:Array = null;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         for each(_loc3_ in param1)
         {
            if(!(_loc3_.tables == null || _loc3_.tables.table == null))
            {
               _loc2_ = _loc3_.tables.table is Array ? _loc3_.tables.table : [_loc3_.tables.table];
               for each(_loc4_ in _loc2_)
               {
                  handleTable(_loc4_);
               }
            }
         }
      }
      
      private static function handleTable(param1:Object) : void
      {
         var _loc4_:* = undefined;
         if(param1 == null || param1.name == null || param1.row == null)
         {
            return;
         }
         var _loc2_:Table = ProjectManager.getProjectData().findTable(param1.name);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Array = param1.row is Array ? param1.row : [param1.row];
         for each(_loc4_ in _loc3_)
         {
            handleItem(param1.name,_loc2_,_loc4_);
         }
      }
      
      private static function handleItem(param1:String, param2:Table, param3:Object, param4:Boolean = false) : void
      {
         var _loc10_:* = undefined;
         var _loc11_:Row = null;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc5_:Boolean = false;
         var _loc6_:Field = null;
         if(param3.Id == null)
         {
            return;
         }
         var _loc7_:* = param3.Id;
         var _loc8_:* = param2;
         if(!_loc8_.getCache[_loc7_])
         {
            _loc11_ = DCUtils.find(_loc8_.rows,"id",_loc7_);
            if(!_loc11_)
            {
               LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc8_.name + "\'",_loc8_,3);
            }
            _loc8_.getCache[_loc7_] = _loc11_;
         }
         var _loc9_:Row = _loc8_.getCache[_loc7_];
         if(_loc9_ == null)
         {
            return;
         }
         for(_loc10_ in param3)
         {
            if(_loc10_.toLowerCase() != ID)
            {
               _loc5_ = false;
               _loc12_ = _loc9_;
               for each(_loc13_ in _loc12_.getFields())
               {
                  if(_loc13_.name == _loc10_)
                  {
                     _loc5_ = true;
                     _loc13_.override(param3[_loc10_]);
                     _loc14_ = _loc13_;
                     LogUtils.log("Overriding table: " + param1 + " fieldName: " + _loc10_ + " in rowID: " + _loc9_.id + " old value: " + _loc13_.originalValue + " new value: " + (_loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value),"ConfigUpdater",0,"CRMDataOverride");
                  }
               }
               if(!_loc5_)
               {
                  _loc9_.addField(new Field(_loc9_,_loc10_));
                  _loc15_ = _loc10_;
                  _loc16_ = _loc9_;
                  if(!_loc16_.getCache[_loc15_])
                  {
                     _loc16_.getCache[_loc15_] = DCUtils.find(_loc16_.getFields(),"name",_loc15_);
                  }
                  _loc6_ = _loc16_.getCache[_loc15_];
                  _loc6_.override(param3[_loc10_]);
                  _loc17_ = _loc6_;
                  LogUtils.log("Creating field " + _loc10_ + " to table: " + param1 + " in rowID: " + _loc9_.id + " old value: " + _loc6_.originalValue + " new value: " + (_loc17_.overrideValue != null ? _loc17_.overrideValue : _loc17_._value),"ConfigUpdater",0,"CRMDataOverride");
               }
            }
         }
      }
   }
}

