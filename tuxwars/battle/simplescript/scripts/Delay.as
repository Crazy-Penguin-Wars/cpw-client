package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptObject;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.battle.world.PhysicsUpdater;
   
   public class Delay implements SimpleScriptCore
   {
      
      private static const activeDelays:Vector.<Delay> = new Vector.<Delay>();
      
      private static var idCounter:int;
       
      
      private var _uniqueIdForPhysicsUpdater:String;
      
      private var _timeUntillTrigger:int;
      
      private var _triggered:Boolean;
      
      private var _scriptObject:SimpleScript;
      
      private var _params:SimpleScriptParams;
      
      public function Delay()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         _scriptObject = scriptObject;
         _params = params;
         _timeUntillTrigger = scriptObject.variables[1];
         _triggered = false;
         _uniqueIdForPhysicsUpdater = "ScriptDelay_" + idCounter++;
         LogUtils.log("Created delay: " + _uniqueIdForPhysicsUpdater + " for scriptObject id: " + scriptObject.id + " uid: " + scriptObject.uniqueId,this,0,"SimpleScript",false,false,false);
         PhysicsUpdater.register(this,_uniqueIdForPhysicsUpdater);
         activeDelays.push(this);
      }
      
      public function physicsUpdate(deltaTime:int) : void
      {
         var _loc2_:* = null;
         _timeUntillTrigger -= deltaTime;
         if(_timeUntillTrigger < 0 && !_triggered)
         {
            _triggered = true;
            if(BattleManager.isBattleInProgress() && _scriptObject && _scriptObject.variables)
            {
               LogUtils.log("Triggered delay: " + _uniqueIdForPhysicsUpdater + " for scriptObject id: " + _scriptObject.id + " uid: " + _scriptObject.uniqueId,this,0,"SimpleScript",false,false,false);
               _loc2_ = SimpleScriptManager.getNextScriptObject(2,_scriptObject);
               var _loc3_:SimpleScriptManager = SimpleScriptManager;
               if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
               {
                  new tuxwars.battle.simplescript.SimpleScriptManager();
               }
               tuxwars.battle.simplescript.SimpleScriptManager._instance.run(true,_loc2_,_params);
            }
            _params = null;
            _scriptObject = null;
            PhysicsUpdater.unregister(this,_uniqueIdForPhysicsUpdater);
            activeDelays.splice(activeDelays.indexOf(this),1);
         }
      }
   }
}
