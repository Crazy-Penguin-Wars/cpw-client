package tuxwars.battle.simplescript
{
   import com.adobe.utils.StringUtil;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.battle.SimpleScriptMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.SimpleScriptResponse;
   import tuxwars.battle.simplescript.scripts.SimpleScriptCore;
   import tuxwars.utils.UniqueCounters;
   
   public class SimpleScriptManager
   {
      
      private static const PACKAGE:String = "tuxwars.battle.simplescript.scripts.";
      
      private static var _instance:SimpleScriptManager;
      
      private static const waitingScripts:Object = {};
       
      
      public function SimpleScriptManager()
      {
         super();
         if(!_instance)
         {
            _instance = this;
            MessageCenter.addListener("ActionResponse",actionHandler);
         }
      }
      
      public static function get instance() : SimpleScriptManager
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      public static function parseSimpleScriptFromOdsData(array:Array) : Array
      {
         var i:int = 0;
         var s:* = null;
         var _loc3_:* = null;
         var j:int = 0;
         while(i < array.length)
         {
            s = array[i];
            if(s.indexOf(";") != -1)
            {
               _loc3_ = s.split(";");
               while(j < _loc3_.length)
               {
                  _loc3_[j] = StringUtil.trim(_loc3_[j]);
                  j++;
               }
               array[i] = _loc3_;
            }
            i++;
         }
         return array;
      }
      
      public static function getNextScriptObject(indexOfNextScriptName:int, scriptObject:SimpleScript) : SimpleScriptObject
      {
         var i:int = 0;
         var _loc4_:Array = [];
         for(i = indexOfNextScriptName + 1; i < scriptObject.variables.length; )
         {
            _loc4_.push(scriptObject.variables[i]);
            i++;
         }
         return new SimpleScriptObject(scriptObject.variables[indexOfNextScriptName],_loc4_,scriptObject is SimpleScriptObject ? (scriptObject as SimpleScriptObject).parent : scriptObject);
      }
      
      public function reset() : void
      {
         DCUtils.deleteProperties(waitingScripts);
      }
      
      public function runWithName(useServerMessage:Boolean, className:String, variables:Array, params:SimpleScriptParams) : *
      {
         return run(useServerMessage,new SimpleScriptObject(className,variables),params);
      }
      
      public function run(useServerMessage:Boolean, scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc4_:* = null;
         if(scriptObject == null)
         {
            LogUtils.log("SimpleScript object is null",this,2,"SimpleScript",false,false,true);
            return null;
         }
         if(scriptObject.className == null)
         {
            LogUtils.log("SimpleScript object:" + scriptObject + " has no class specified",this,2,"SimpleScript",false,false,true);
            return null;
         }
         if(!useServerMessage)
         {
            return actualRun(scriptObject,params);
         }
         _loc4_ = scriptObject.id + "_" + scriptObject.uniqueId + "_Script_" + UniqueCounters.next(scriptObject.id,"SimpleScriptManager");
         if(!waitingScripts.hasOwnProperty(_loc4_))
         {
            waitingScripts[_loc4_] = [scriptObject,params];
            if(BattleManager.isLocalPlayersTurn() || BattleManager.isPracticeMode())
            {
               MessageCenter.sendEvent(new SimpleScriptMessage(null,_loc4_,scriptObject,params));
            }
            return _loc4_;
         }
         LogUtils.log("Conflict in id of waitingScripts for id: " + _loc4_,this,2,"SimpleScript",false,false,true);
         return null;
      }
      
      private function actionHandler(response:ActionResponse) : void
      {
         if(response.responseType == 55)
         {
            if(response is SimpleScriptResponse)
            {
               runServerCommand(response as SimpleScriptResponse);
            }
            else
            {
               LogUtils.log("Response is not a SimpleScriptResponse",this,2,"SimpleScript",false,false,false);
            }
         }
      }
      
      private function runServerCommand(response:SimpleScriptResponse) : void
      {
         var _loc3_:* = null;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = undefined;
         var _loc4_:Array = waitingScripts[response.scriptId];
         delete waitingScripts[response.scriptId];
         if(_loc4_ != null)
         {
            _loc3_ = response.pgoALocationV2;
            _loc9_ = response.pgoBLocationV2;
            _loc8_ = response.emissionLocationOriginal;
            _loc6_ = response.scriptObjectLocationOriginal;
            _loc2_ = _loc4_[0];
            _loc7_ = _loc4_[1];
            _loc7_.pgoALocation = _loc3_;
            _loc7_.pgoBLocation = _loc9_;
            _loc7_.emissionLocationOriginal = _loc8_;
            _loc7_.scriptObjectLocationOriginal = _loc6_;
            _loc5_ = actualRun(_loc2_,_loc7_);
            if(_loc5_ != null)
            {
               LogUtils.log("Return value of: " + _loc5_ + " for scriptId: " + response.scriptId + " run using server" + ", unable to return this result anywhere",this,2,"SimpleScript",false,false,false);
            }
         }
         else
         {
            LogUtils.log("Unable to find scriptObject and params for: " + response.scriptId,this,3,"SimpleScript",false,false,false);
         }
      }
      
      private function actualRun(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc4_:* = null;
         var _loc3_:String = "tuxwars.battle.simplescript.scripts." + scriptObject.className;
         var _loc5_:Class = getDefinitionByName(_loc3_) as Class;
         if(_loc5_)
         {
            _loc4_ = new _loc5_() as SimpleScriptCore;
            if(_loc4_ != null && _loc4_["run"])
            {
               if(params)
               {
                  LogUtils.log("Run SimpleScript for: " + scriptObject.className + " with params: " + params,this,4,"SimpleScript",false,false,false);
               }
               else
               {
                  LogUtils.log("Run SimpleScript for: " + scriptObject.className,this,4,"SimpleScript",false,false,false);
               }
               return _loc4_.run(scriptObject,params);
            }
            LogUtils.log("Unable to create SimpleScript Object for: " + scriptObject.className + " with params: " + params,this,3,"SimpleScript",false,false,true);
            return null;
         }
         LogUtils.log("Unable to find SimpleScript Class for: " + scriptObject.className + " with params: " + params,this,3,"SimpleScript",false,false,true);
         return null;
      }
   }
}
