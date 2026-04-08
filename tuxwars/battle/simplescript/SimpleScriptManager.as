package tuxwars.battle.simplescript
{
   import com.adobe.utils.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.geom.Point;
   import flash.utils.*;
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.responses.*;
   import tuxwars.battle.simplescript.scripts.*;
   import tuxwars.utils.*;
   
   public class SimpleScriptManager
   {
      private static var _instance:SimpleScriptManager;
      
      private static const PACKAGE:String = "tuxwars.battle.simplescript.scripts.";
      
      private static const waitingScripts:Object = {};
      
      public function SimpleScriptManager()
      {
         super();
         if(!_instance)
         {
            _instance = this;
            MessageCenter.addListener("ActionResponse",this.actionHandler);
         }
      }
      
      public static function get instance() : SimpleScriptManager
      {
         if(!_instance)
         {
            new SimpleScriptManager();
         }
         return _instance;
      }
      
      public static function parseSimpleScriptFromOdsData(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            if(_loc3_.indexOf(";") != -1)
            {
               _loc4_ = _loc3_.split(";");
               while(_loc5_ < _loc4_.length)
               {
                  _loc4_[_loc5_] = StringUtil.trim(_loc4_[_loc5_]);
                  _loc5_++;
               }
               param1[_loc2_] = _loc4_;
            }
            _loc2_++;
         }
         return param1;
      }
      
      public static function getNextScriptObject(param1:int, param2:SimpleScript) : SimpleScriptObject
      {
         var _loc3_:int = 0;
         var _loc4_:Array = [];
         _loc3_ = param1 + 1;
         while(_loc3_ < param2.variables.length)
         {
            _loc4_.push(param2.variables[_loc3_]);
            _loc3_++;
         }
         return new SimpleScriptObject(param2.variables[param1],_loc4_,param2 is SimpleScriptObject ? (param2 as SimpleScriptObject).parent : param2);
      }
      
      public function reset() : void
      {
         DCUtils.deleteProperties(waitingScripts);
      }
      
      public function runWithName(param1:Boolean, param2:String, param3:Array, param4:SimpleScriptParams) : *
      {
         return this.run(param1,new SimpleScriptObject(param2,param3),param4);
      }
      
      public function run(param1:Boolean, param2:SimpleScript, param3:SimpleScriptParams) : *
      {
         var _loc4_:String = null;
         if(param2 == null)
         {
            LogUtils.log("SimpleScript object is null",this,2,"SimpleScript",false,false,true);
            return null;
         }
         if(param2.className == null)
         {
            LogUtils.log("SimpleScript object:" + param2 + " has no class specified",this,2,"SimpleScript",false,false,true);
            return null;
         }
         if(!param1)
         {
            return this.actualRun(param2,param3);
         }
         _loc4_ = param2.id + "_" + param2.uniqueId + "_Script_" + UniqueCounters.next(param2.id,"SimpleScriptManager");
         if(!waitingScripts.hasOwnProperty(_loc4_))
         {
            waitingScripts[_loc4_] = [param2,param3];
            if(Boolean(BattleManager.isLocalPlayersTurn()) || Boolean(BattleManager.isPracticeMode()))
            {
               MessageCenter.sendEvent(new SimpleScriptMessage(null,_loc4_,param2,param3));
            }
            return _loc4_;
         }
         LogUtils.log("Conflict in id of waitingScripts for id: " + _loc4_,this,2,"SimpleScript",false,false,true);
         return null;
      }
      
      private function actionHandler(param1:ActionResponse) : void
      {
         if(param1.responseType == 55)
         {
            if(param1 is SimpleScriptResponse)
            {
               this.runServerCommand(param1 as SimpleScriptResponse);
            }
            else
            {
               LogUtils.log("Response is not a SimpleScriptResponse",this,2,"SimpleScript",false,false,false);
            }
         }
      }
      
      private function runServerCommand(param1:SimpleScriptResponse) : void
      {
         var _loc2_:Vec2 = null;
         var _loc3_:Vec2 = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:SimpleScript = null;
         var _loc7_:SimpleScriptParams = null;
         var _loc8_:* = undefined;
         var _loc9_:Array = waitingScripts[param1.scriptId];
         delete waitingScripts[param1.scriptId];
         if(_loc9_ != null)
         {
            _loc2_ = param1.pgoALocationV2;
            _loc3_ = param1.pgoBLocationV2;
            _loc4_ = param1.emissionLocationOriginal;
            _loc5_ = param1.scriptObjectLocationOriginal;
            _loc6_ = _loc9_[0];
            _loc7_ = _loc9_[1];
            _loc7_.pgoALocation = _loc2_;
            _loc7_.pgoBLocation = _loc3_;
            _loc7_.emissionLocationOriginal = _loc4_;
            _loc7_.scriptObjectLocationOriginal = _loc5_;
            _loc8_ = this.actualRun(_loc6_,_loc7_);
            if(_loc8_ != null)
            {
               LogUtils.log("Return value of: " + _loc8_ + " for scriptId: " + param1.scriptId + " run using server" + ", unable to return this result anywhere",this,2,"SimpleScript",false,false,false);
            }
         }
         else
         {
            LogUtils.log("Unable to find scriptObject and params for: " + param1.scriptId,this,3,"SimpleScript",false,false,false);
         }
      }
      
      private function actualRun(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc3_:SimpleScriptCore = null;
         var _loc4_:String = "tuxwars.battle.simplescript.scripts." + param1.className;
         var _loc5_:Class = getDefinitionByName(_loc4_) as Class;
         if(_loc5_)
         {
            _loc3_ = new _loc5_() as SimpleScriptCore;
            if(_loc3_ != null && Boolean(_loc3_["run"]))
            {
               if(param2)
               {
                  LogUtils.log("Run SimpleScript for: " + param1.className + " with params: " + param2,this,4,"SimpleScript",false,false,false);
               }
               else
               {
                  LogUtils.log("Run SimpleScript for: " + param1.className,this,4,"SimpleScript",false,false,false);
               }
               return _loc3_.run(param1,param2);
            }
            LogUtils.log("Unable to create SimpleScript Object for: " + param1.className + " with params: " + param2,this,3,"SimpleScript",false,false,true);
            return null;
         }
         LogUtils.log("Unable to find SimpleScript Class for: " + param1.className + " with params: " + param2,this,3,"SimpleScript",false,false,true);
         return null;
      }
   }
}

