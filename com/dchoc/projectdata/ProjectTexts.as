package com.dchoc.projectdata
{
   import com.dchoc.utils.LogUtils;
   
   public class ProjectTexts
   {
      
      private static const LANGUAGES_WITH_SPECIAL_CHARACTERS:Array = ["tr","zt","zs","zh"];
       
      
      private const textMap:Object = {};
      
      public function ProjectTexts(textTable:Table)
      {
         super();
         loadTexts(textTable);
      }
      
      public static function replaceParameters(text:String, paramValues:Array) : String
      {
         var i:int = 0;
         try
         {
            if(paramValues.length == 1)
            {
               text = replaceSubstring(text,"%U",paramValues[0]);
            }
            else
            {
               i = 0;
               while(i < paramValues.length)
               {
                  text = replaceSubstring(text,"%" + i + "U",paramValues[i]);
                  i++;
               }
            }
         }
         catch(e:Error)
         {
            LogUtils.log("Error while replacing text parameters: " + e.message,ProjectTexts,2,"ErrorLogging",true,false,false);
         }
         return text;
      }
      
      private static function replaceSubstring(source:String, replace:String, by:String) : String
      {
         var _loc4_:int = source.indexOf(replace);
         return _loc4_ >= 0 ? source.substring(0,_loc4_) + by + source.substring(_loc4_ + replace.length) : source;
      }
      
      final public function getText(tid:String, params:Array = null) : String
      {
         var _loc3_:* = null;
         if(tid != null)
         {
            _loc3_ = tid.toLocaleUpperCase();
            if(textMap[_loc3_])
            {
               return !!params ? replaceParameters(textMap[_loc3_],params) : textMap[_loc3_];
            }
            return "#" + _loc3_;
         }
         LogUtils.log("Tid is NULL",this,2,"LoadResource",false);
         return null;
      }
      
      public function languageHasSpecialCharacters() : Boolean
      {
         return LANGUAGES_WITH_SPECIAL_CHARACTERS.indexOf(Config.getLanguageCode()) != -1;
      }
      
      private function loadTexts(textTable:Table) : void
      {
         var _loc2_:* = null;
         var str:* = null;
         var _loc5_:* = textTable;
         for each(var row in _loc5_._rows)
         {
            var _loc10_:* = Config.getLanguageCode();
            var _loc6_:* = row;
            if(!_loc6_._cache[_loc10_])
            {
               _loc6_._cache[_loc10_] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name",_loc10_);
            }
            _loc2_ = _loc6_._cache[_loc10_];
            if(_loc2_)
            {
               var _loc7_:* = _loc2_;
               str = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
               while(str.indexOf("\\n") != -1)
               {
                  str = str.replace("\\n","\n");
               }
               textMap[row.id] = str;
            }
         }
      }
   }
}
