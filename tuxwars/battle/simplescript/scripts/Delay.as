package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.*;
   import tuxwars.battle.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.battle.world.*;
   
   public class Delay implements SimpleScriptCore
   {
      private static var idCounter:int;
      
      private static const activeDelays:Vector.<Delay> = new Vector.<Delay>();
      
      private var _uniqueIdForPhysicsUpdater:String;
      
      private var _timeUntillTrigger:int;
      
      private var _triggered:Boolean;
      
      private var _scriptObject:SimpleScript;
      
      private var _params:SimpleScriptParams;
      
      public function Delay()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         this._scriptObject = param1;
         this._params = param2;
         this._timeUntillTrigger = param1.variables[1];
         this._triggered = false;
         this._uniqueIdForPhysicsUpdater = "ScriptDelay_" + idCounter++;
         LogUtils.log("Created delay: " + this._uniqueIdForPhysicsUpdater + " for scriptObject id: " + param1.id + " uid: " + param1.uniqueId,this,0,"SimpleScript",false,false,false);
         PhysicsUpdater.register(this,this._uniqueIdForPhysicsUpdater);
         activeDelays.push(this);
      }
      
      public function physicsUpdate(param1:int) : void
      {
         var _loc2_:SimpleScriptObject = null;
         this._timeUntillTrigger -= param1;
         if(this._timeUntillTrigger < 0 && !this._triggered)
         {
            this._triggered = true;
            if(BattleManager.isBattleInProgress() && this._scriptObject && Boolean(this._scriptObject.variables))
            {
               LogUtils.log("Triggered delay: " + this._uniqueIdForPhysicsUpdater + " for scriptObject id: " + this._scriptObject.id + " uid: " + this._scriptObject.uniqueId,this,0,"SimpleScript",false,false,false);
               _loc2_ = SimpleScriptManager.getNextScriptObject(2,this._scriptObject);
               if(!SimpleScriptManager.instance)
               {
                  new SimpleScriptManager();
               }
               SimpleScriptManager.instance.run(true,_loc2_,this._params);
            }
            this._params = null;
            this._scriptObject = null;
            PhysicsUpdater.unregister(this,this._uniqueIdForPhysicsUpdater);
            activeDelays.splice(activeDelays.indexOf(this),1);
         }
      }
   }
}

