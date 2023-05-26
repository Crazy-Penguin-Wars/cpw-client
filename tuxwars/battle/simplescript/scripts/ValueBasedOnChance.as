package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class ValueBasedOnChance implements SimpleScriptCore
   {
      
      public static const RETURN_INT_ON_FAIL:int = 0;
       
      
      public function ValueBasedOnChance()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var values:Array = scriptObject.variables;
         if(values && values.length >= 4)
         {
            var _loc4_:SimpleScriptManager = SimpleScriptManager;
            if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
            {
               new tuxwars.battle.simplescript.SimpleScriptManager();
            }
            if(tuxwars.battle.simplescript.SimpleScriptManager._instance.runWithName(false,"Chance",[scriptObject.variables[1]],params))
            {
               LogUtils.log("SUCCESS: returning value: " + values[3],this,4,"SimpleScript",false,false,false);
               return values[2];
            }
            LogUtils.log("FAIL: returning value: " + values[3],this,0,"SimpleScript",false,false,false);
            return values[3];
         }
         return 0;
      }
   }
}
