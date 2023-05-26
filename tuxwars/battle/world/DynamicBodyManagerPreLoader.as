package tuxwars.battle.world
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.DCUtils;
   import flash.events.TimerEvent;
   
   public class DynamicBodyManagerPreLoader
   {
      
      private static const TABLE:String = "PhysicsPreLoad";
      
      private static const COLUMN:String = "Column";
      
      private static const managers:Object = {};
      
      private static const loadingFiles:Object = {};
      
      private static var loaded:Boolean;
       
      
      public function DynamicBodyManagerPreLoader()
      {
         super();
         throw new Error("DynamicBodyManagerPreLoader is a static class");
      }
      
      public static function dispose() : void
      {
         DCUtils.deleteProperties(managers);
         DCUtils.deleteProperties(loadingFiles);
         DynamicBodyManagerFactory.getInstance().dispose();
         loaded = false;
      }
      
      public static function preLoad() : void
      {
         var tablePreLoad:* = null;
         var fieldPreLoad:* = null;
         var columnNameForXML:* = null;
         var table:* = null;
         var field:* = null;
         var xmlFileName:* = null;
         if(!loaded)
         {
            var _loc9_:ProjectManager = ProjectManager;
            tablePreLoad = com.dchoc.projectdata.ProjectManager.projectData.findTable("PhysicsPreLoad");
            if(tablePreLoad)
            {
               var _loc10_:* = tablePreLoad;
               for each(var rowPreLoad in _loc10_._rows)
               {
                  if(rowPreLoad)
                  {
                     var _loc11_:* = rowPreLoad;
                     if(!_loc11_._cache["Column"])
                     {
                        _loc11_._cache["Column"] = com.dchoc.utils.DCUtils.find(_loc11_._fields,"name","Column");
                     }
                     fieldPreLoad = _loc11_._cache["Column"];
                     if(fieldPreLoad)
                     {
                        var _loc12_:* = fieldPreLoad;
                        columnNameForXML = _loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value;
                        var _loc23_:* = rowPreLoad.id;
                        var _loc13_:ProjectManager = ProjectManager;
                        table = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc23_);
                        if(table)
                        {
                           var _loc14_:* = table;
                           for each(var row in _loc14_._rows)
                           {
                              if(row)
                              {
                                 var _loc24_:* = columnNameForXML;
                                 var _loc15_:* = row;
                                 if(!_loc15_._cache[_loc24_])
                                 {
                                    _loc15_._cache[_loc24_] = com.dchoc.utils.DCUtils.find(_loc15_._fields,"name",_loc24_);
                                 }
                                 field = _loc15_._cache[_loc24_];
                                 var _loc16_:*;
                                 xmlFileName = field != null ? (_loc16_ = field, _loc16_.overrideValue != null ? _loc16_.overrideValue : _loc16_._value) : null;
                                 if(xmlFileName)
                                 {
                                    if(loadingFiles[xmlFileName] == null)
                                    {
                                       loadingFiles[xmlFileName] = DynamicBodyManagerFactory.getInstance().createManager(xmlFileName,managerLoaded);
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            loaded = true;
         }
      }
      
      private static function managerLoaded(event:TimerEvent) : void
      {
         var _loc2_:DynamicBodyManager = DynamicBodyManagerFactory.getInstance().getManager(event.type);
         managers[_loc2_.getFile()] = _loc2_;
      }
      
      public static function getBodyManager(XMLName:String) : DynamicBodyManager
      {
         return managers[XMLName];
      }
   }
}
