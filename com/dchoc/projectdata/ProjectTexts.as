package com.dchoc.projectdata
{
   import com.dchoc.utils.*;
   
   public class ProjectTexts
   {
      private static const LANGUAGES_WITH_SPECIAL_CHARACTERS:Array = ["tr","zt","zs","zh"];
      
      private const _textMap:Object = {};
      
      public function ProjectTexts(param1:Table)
      {
         super();
         this.loadTexts(param1);
      }
      
      public static function replaceParameters(param1:String, param2:Array) : String
      {
         var text:String = param1;
         var paramValues:Array = param2;
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
      
      private static function replaceSubstring(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:int = int(param1.indexOf(param2));
         return _loc4_ >= 0 ? param1.substring(0,_loc4_) + param3 + param1.substring(_loc4_ + param2.length) : param1;
      }
      
      public function get textMap() : Object
      {
         return this._textMap;
      }
      
      final public function getText(param1:String, param2:Array = null) : String
      {
         var _loc3_:String = null;
         if(param1 != null)
         {
            _loc3_ = param1.toLocaleUpperCase();
            if(this._textMap[_loc3_])
            {
               return !!param2 ? replaceParameters(this._textMap[_loc3_],param2) : this._textMap[_loc3_];
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
      
      private function loadTexts(param1:Table) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc2_:Field = null;
         var _loc3_:String = null;
         var _loc4_:* = param1;
         for each(_loc5_ in _loc4_._rows)
         {
            _loc6_ = Config.getLanguageCode();
            _loc7_ = _loc5_;
            if(!_loc7_.getCache[_loc6_])
            {
               _loc7_.getCache[_loc6_] = DCUtils.find(_loc7_.getFields(),"name",_loc6_);
            }
            _loc2_ = _loc7_.getCache[_loc6_];
            if(_loc2_)
            {
               _loc8_ = _loc2_;
               _loc3_ = _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value;
               while(_loc3_.indexOf("\\n") != -1)
               {
                  _loc3_ = _loc3_.replace("\\n","\n");
               }
               this._textMap[_loc5_.id] = _loc3_;
            }
         }
      }
   }
}

