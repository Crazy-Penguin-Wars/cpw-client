package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptObject;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class Chance implements SimpleScriptCore
   {
       
      
      public function Chance()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var _loc4_:Number = NaN;
         var _loc6_:* = null;
         var _loc3_:Array = scriptObject.variables;
         assert("Value array length is incorrect.",true,_loc3_.length >= 2);
         var _loc5_:Number = Number(_loc3_[1]);
         if(!isNaN(_loc5_) && _loc5_ > 0)
         {
            LogUtils.log("Call to random run()",this,0,"Random",false,false,false);
            _loc4_ = BattleManager.getRandom().float(0,100);
            if(_loc4_ <= _loc5_)
            {
               if(scriptObject.variables.length > 2)
               {
                  LogUtils.log("SUCCESS: Random chance: " + _loc4_ + " is <= to probability: " + _loc5_ + " running next simpleScript: " + scriptObject.variables[2],this,4,"SimpleScript",false,false,false);
                  _loc6_ = SimpleScriptManager.getNextScriptObject(2,scriptObject);
                  var _loc7_:SimpleScriptManager = SimpleScriptManager;
                  if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
                  {
                     new tuxwars.battle.simplescript.SimpleScriptManager();
                  }
                  return tuxwars.battle.simplescript.SimpleScriptManager._instance.run(false,_loc6_,params);
               }
               LogUtils.log("SUCCESS: Random chance: " + _loc4_ + " is <= to probability: " + _loc5_,this,4,"SimpleScript",false,false,false);
               return true;
            }
         }
         if(scriptObject.variables.length > 2)
         {
            LogUtils.log("FAIL: Random chance: " + _loc4_ + " is <= to probability: " + _loc5_ + " not running next simpleScript: " + scriptObject.variables[2],this,0,"SimpleScript",false,false,false);
         }
         else
         {
            LogUtils.log("FAIL: Random chance: " + _loc4_ + " is > probability: " + _loc5_,this,0,"SimpleScript",false,false,false);
         }
         return false;
      }
   }
}
