package com.dchoc.projectdata
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.UIConfig;
   import com.dchoc.utils.LogUtils;
   import tuxwars.Assets;
   
   public class ProjectManager
   {
      
      private static var projectData:ProjectData;
      
      private static var projectTexts:ProjectTexts;
       
      
      public function ProjectManager()
      {
         super();
         throw new Error("ProjectManager is a static class!");
      }
      
      public static function init() : void
      {
         projectData = new ProjectData();
         projectData.parseFile(DCResourceManager.instance.get("json/tuxwars_config_base.json"));
         projectData.parseFile(DCResourceManager.instance.get(Assets.getLanguageFile()));
         projectData.link(Config.getLanguageCode());
         projectTexts = new ProjectTexts(projectData.findTable("TID"));
         initUiConfig();
      }
      
      public static function getProjectData() : ProjectData
      {
         return projectData;
      }
      
      public static function getProjectTexts() : ProjectTexts
      {
         return projectTexts;
      }
      
      public static function findTable(name:String) : Table
      {
         return projectData.findTable(name);
      }
      
      public static function getText(tid:String, params:Array = null) : String
      {
         var _loc5_:* = params;
         var _loc6_:* = tid;
         var _loc3_:ProjectTexts = projectTexts;
         var _loc4_:String;
         return _loc6_ != null ? (_loc4_ = _loc6_.toLocaleUpperCase(), !!_loc3_.textMap[_loc4_] ? (!!_loc5_ ? com.dchoc.projectdata.ProjectTexts.replaceParameters(_loc3_.textMap[_loc4_],_loc5_) : _loc3_.textMap[_loc4_]) : "#" + _loc4_) : (com.dchoc.utils.LogUtils.log("Tid is NULL",_loc3_,2,"LoadResource",false), null);
      }
      
      private static function initUiConfig() : void
      {
         var content:* = null;
         var c:* = null;
         var _loc50_:String = "UiTransition";
         var _loc14_:* = ProjectManager;
         var configTable:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc50_);
         var configArray:Array = [];
         var _loc15_:* = configTable;
         for each(var row in _loc15_._rows)
         {
            content = [];
            var _loc16_:* = row;
            for each(var field in _loc16_._fields)
            {
               switch(field.name)
               {
                  case "TransitionID":
                     var _loc17_:* = field;
                     if((_loc17_.overrideValue != null ? _loc17_.overrideValue : _loc17_._value) is String)
                     {
                        var _loc18_:* = field;
                        content[0] = _loc18_.overrideValue != null ? _loc18_.overrideValue : _loc18_._value;
                     }
                     else
                     {
                        var _loc19_:* = field;
                        var _loc20_:* = Row(_loc19_.overrideValue != null ? _loc19_.overrideValue : _loc19_._value);
                        §§push(content);
                        §§push(0);
                        §§push(Field);
                        §§push(global);
                        if(!_loc20_._cache["Value"])
                        {
                           _loc20_._cache["Value"] = com.dchoc.utils.DCUtils.find(_loc20_._fields,"name","Value");
                        }
                        var _loc21_:* = §§pop()(_loc20_._cache["Value"]);
                        §§pop()[§§pop()] = _loc21_.overrideValue != null ? _loc21_.overrideValue : _loc21_._value;
                     }
                     break;
                  case "From":
                     var _loc22_:* = field;
                     var _loc23_:* = Row(_loc22_.overrideValue != null ? _loc22_.overrideValue : _loc22_._value);
                     §§push(content);
                     §§push(1);
                     §§push(Field);
                     §§push(global);
                     if(!_loc23_._cache["Value"])
                     {
                        _loc23_._cache["Value"] = com.dchoc.utils.DCUtils.find(_loc23_._fields,"name","Value");
                     }
                     var _loc24_:* = §§pop()(_loc23_._cache["Value"]);
                     §§pop()[§§pop()] = _loc24_.overrideValue != null ? _loc24_.overrideValue : _loc24_._value;
                     break;
                  case "To":
                     var _loc25_:* = field;
                     var _loc26_:* = Row(_loc25_.overrideValue != null ? _loc25_.overrideValue : _loc25_._value);
                     §§push(content);
                     §§push(2);
                     §§push(Field);
                     §§push(global);
                     if(!_loc26_._cache["Value"])
                     {
                        _loc26_._cache["Value"] = com.dchoc.utils.DCUtils.find(_loc26_._fields,"name","Value");
                     }
                     var _loc27_:* = §§pop()(_loc26_._cache["Value"]);
                     §§pop()[§§pop()] = _loc27_.overrideValue != null ? _loc27_.overrideValue : _loc27_._value;
                     break;
                  case "TransitionType":
                     var _loc28_:* = field;
                     var _loc29_:* = Row(_loc28_.overrideValue != null ? _loc28_.overrideValue : _loc28_._value);
                     §§push(content);
                     §§push(3);
                     §§push(Field);
                     §§push(global);
                     if(!_loc29_._cache["Value"])
                     {
                        _loc29_._cache["Value"] = com.dchoc.utils.DCUtils.find(_loc29_._fields,"name","Value");
                     }
                     var _loc30_:* = §§pop()(_loc29_._cache["Value"]);
                     §§pop()[§§pop()] = _loc30_.overrideValue != null ? _loc30_.overrideValue : _loc30_._value;
                     break;
                  case "GfxFile":
                     var _loc31_:* = field;
                     content[4] = _loc31_.overrideValue != null ? _loc31_.overrideValue : _loc31_._value;
                     break;
                  case "GfxClip":
                     var _loc32_:* = field;
                     content[5] = _loc32_.overrideValue != null ? _loc32_.overrideValue : _loc32_._value;
                     break;
                  case "ID":
                     break;
                  default:
                     LogUtils.log("Un Known ID field name: " + field.name,ProjectManager,3,"TODO",false,true);
                     break;
               }
            }
            for each(var s in content)
            {
               configArray.push(s);
            }
         }
         var t:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable("UiTransitionID");
         var transitionIDs:Array = [];
         var _loc40_:* = t;
         for each(var r in _loc40_._rows)
         {
            c = [];
            var _loc41_:* = r;
            for each(var f in _loc41_._fields)
            {
               switch(f.name)
               {
                  case "Value":
                     var _loc42_:* = f;
                     c[0] = _loc42_.overrideValue != null ? _loc42_.overrideValue : _loc42_._value;
                     break;
                  case "Klass":
                     var _loc43_:* = f;
                     c[1] = _loc43_.overrideValue != null ? _loc43_.overrideValue : _loc43_._value;
                     break;
               }
            }
            for each(var st in c)
            {
               transitionIDs.push(st);
            }
         }
         var o:Object = {};
         o["on_click"] = "ButtonClick";
         UIConfig.init(configArray,transitionIDs,true,o);
      }
   }
}
