package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.*;
   import tuxwars.battle.simplescript.*;
   
   public class Chance implements SimpleScriptCore
   {
      public function Chance()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc3_:Number = Number(NaN);
         var _loc4_:SimpleScriptObject = null;
         var _loc5_:Array = param1.variables;
         assert("Value array length is incorrect.",true,_loc5_.length >= 2);
         var _loc6_:Number = Number(_loc5_[1]);
         if(!isNaN(_loc6_) && _loc6_ > 0)
         {
            LogUtils.log("Call to random run()",this,0,"Random",false,false,false);
            _loc3_ = Number(BattleManager.getRandom().float(0,100));
            if(_loc3_ <= _loc6_)
            {
               if(param1.variables.length > 2)
               {
                  LogUtils.log("SUCCESS: Random chance: " + _loc3_ + " is <= to probability: " + _loc6_ + " running next simpleScript: " + param1.variables[2],this,4,"SimpleScript",false,false,false);
                  _loc4_ = SimpleScriptManager.getNextScriptObject(2,param1);
                  if(!SimpleScriptManager.instance)
                  {
                     new SimpleScriptManager();
                  }
                  return SimpleScriptManager.instance.run(false,_loc4_,param2);
               }
               LogUtils.log("SUCCESS: Random chance: " + _loc3_ + " is <= to probability: " + _loc6_,this,4,"SimpleScript",false,false,false);
               return true;
            }
         }
         if(param1.variables.length > 2)
         {
            LogUtils.log("FAIL: Random chance: " + _loc3_ + " is <= to probability: " + _loc6_ + " not running next simpleScript: " + param1.variables[2],this,0,"SimpleScript",false,false,false);
         }
         else
         {
            LogUtils.log("FAIL: Random chance: " + _loc3_ + " is > probability: " + _loc6_,this,0,"SimpleScript",false,false,false);
         }
         return false;
      }
   }
}

