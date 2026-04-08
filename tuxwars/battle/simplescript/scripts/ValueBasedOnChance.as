package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.*;
   import tuxwars.battle.simplescript.*;
   
   public class ValueBasedOnChance implements SimpleScriptCore
   {
      public static const RETURN_INT_ON_FAIL:int = 0;
      
      public function ValueBasedOnChance()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc3_:Array = param1.variables;
         if(Boolean(_loc3_) && _loc3_.length >= 4)
         {
            if(!SimpleScriptManager.instance)
            {
               new SimpleScriptManager();
            }
            if(SimpleScriptManager.instance.runWithName(false,"Chance",[param1.variables[1]],param2))
            {
               LogUtils.log("SUCCESS: returning value: " + _loc3_[3],this,4,"SimpleScript",false,false,false);
               return _loc3_[2];
            }
            LogUtils.log("FAIL: returning value: " + _loc3_[3],this,0,"SimpleScript",false,false,false);
            return _loc3_[3];
         }
         return 0;
      }
   }
}

