package com.dchoc.projectdata
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.*;
   import com.dchoc.utils.*;
   import tuxwars.*;
   
   public class ProjectManager
   {
      private static var _projectData:ProjectData;
      
      private static var projectTexts:ProjectTexts;
      
      public function ProjectManager()
      {
         super();
         throw new Error("ProjectManager is a static class!");
      }
      
      public static function init() : void
      {
         _projectData = new ProjectData();
         _projectData.parseFile(DCResourceManager.instance.get("json/tuxwars_config_base.json"));
         _projectData.parseFile(DCResourceManager.instance.get(Assets.getLanguageFile()));
         _projectData.link(Config.getLanguageCode());
         projectTexts = new ProjectTexts(_projectData.findTable("TID"));
         initUiConfig();
      }
      
      public static function getProjectData() : ProjectData
      {
         return _projectData;
      }
      
      public static function getProjectTexts() : ProjectTexts
      {
         return projectTexts;
      }
      
      public static function findTable(param1:String) : Table
      {
         return _projectData.findTable(param1);
      }
      
      public static function getText(param1:String, param2:Array = null) : String
      {
         var _loc6_:String = null;
         var _loc3_:* = param2;
         var _loc4_:* = param1;
         var _loc5_:ProjectTexts = projectTexts;
         return _loc4_ != null ? (_loc6_ = _loc4_.toLocaleUpperCase(), !!_loc5_.textMap[_loc6_] ? (!!_loc3_ ? ProjectTexts.replaceParameters(_loc5_.textMap[_loc6_],_loc3_) : _loc5_.textMap[_loc6_]) : "#" + _loc6_) : (LogUtils.log("Tid is NULL",_loc5_,2,"LoadResource",false), null);
      }
      
      private static function initUiConfig() : void
      {
         var _loc5_:Row = null;
         var _loc6_:Table = null;
         var _loc7_:Array = null;
         var _loc8_:Row = null;
         var _loc9_:Object = null;
         var _loc10_:Field = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:Row = null;
         var _loc14_:Field = null;
         var _loc15_:Row = null;
         var _loc16_:Field = null;
         var _loc17_:Row = null;
         var _loc18_:Field = null;
         var _loc19_:Row = null;
         var _loc20_:Field = null;
         var _loc21_:Field = null;
         var _loc22_:* = undefined;
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Table = _projectData.findTable("UiTransition");
         var _loc4_:Array = [];
         for each(_loc5_ in _loc3_._rows)
         {
            _loc1_ = [];
            for each(_loc10_ in _loc5_.getFields())
            {
               switch(_loc10_.name)
               {
                  case "TransitionID":
                     _loc12_ = _loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value;
                     if(_loc12_ is String)
                     {
                        _loc1_[0] = _loc12_;
                     }
                     else
                     {
                        _loc19_ = Row(_loc12_);
                        if(!_loc19_.getCache["Value"])
                        {
                           _loc19_.getCache["Value"] = DCUtils.find(_loc19_.getFields(),"name","Value");
                        }
                        _loc20_ = Field(_loc19_.getCache["Value"]);
                        _loc1_[0] = _loc20_.overrideValue != null ? _loc20_.overrideValue : _loc20_._value;
                     }
                     break;
                  case "From":
                     _loc13_ = Row(_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value);
                     if(!_loc13_.getCache["Value"])
                     {
                        _loc13_.getCache["Value"] = DCUtils.find(_loc13_.getFields(),"name","Value");
                     }
                     _loc14_ = Field(_loc13_.getCache["Value"]);
                     _loc1_[1] = _loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value;
                     break;
                  case "To":
                     _loc15_ = Row(_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value);
                     if(!_loc15_.getCache["Value"])
                     {
                        _loc15_.getCache["Value"] = DCUtils.find(_loc15_.getFields(),"name","Value");
                     }
                     _loc16_ = Field(_loc15_.getCache["Value"]);
                     _loc1_[2] = _loc16_.overrideValue != null ? _loc16_.overrideValue : _loc16_._value;
                     break;
                  case "TransitionType":
                     _loc17_ = Row(_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value);
                     if(!_loc17_.getCache["Value"])
                     {
                        _loc17_.getCache["Value"] = DCUtils.find(_loc17_.getFields(),"name","Value");
                     }
                     _loc18_ = Field(_loc17_.getCache["Value"]);
                     _loc1_[3] = _loc18_.overrideValue != null ? _loc18_.overrideValue : _loc18_._value;
                     break;
                  case "GfxFile":
                     _loc1_[4] = _loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value;
                     break;
                  case "GfxClip":
                     _loc1_[5] = _loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value;
                     break;
                  case "ID":
                     break;
                  default:
                     LogUtils.log("Un Known ID field name: " + _loc10_.name,ProjectManager,3,"TODO",false,true);
                     break;
               }
            }
            for each(_loc11_ in _loc1_)
            {
               _loc4_.push(_loc11_);
            }
         }
         _loc6_ = _projectData.findTable("UiTransitionID");
         _loc7_ = [];
         for each(_loc8_ in _loc6_._rows)
         {
            _loc2_ = [];
            for each(_loc21_ in _loc8_.getFields())
            {
               switch(_loc21_.name)
               {
                  case "Value":
                     _loc2_[0] = _loc21_.overrideValue != null ? _loc21_.overrideValue : _loc21_._value;
                     break;
                  case "Klass":
                     _loc2_[1] = _loc21_.overrideValue != null ? _loc21_.overrideValue : _loc21_._value;
                     break;
               }
            }
            for each(_loc22_ in _loc2_)
            {
               _loc7_.push(_loc22_);
            }
         }
         _loc9_ = {};
         _loc9_["on_click"] = "ButtonClick";
         UIConfig.init(_loc4_,_loc7_,true,_loc9_);
      }
      
      public function get projectData() : ProjectData
      {
         return _projectData;
      }
   }
}

