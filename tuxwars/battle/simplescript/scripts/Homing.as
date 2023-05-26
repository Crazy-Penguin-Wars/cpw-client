package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class Homing implements SimpleScriptCore
   {
       
      
      public function Homing()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var target:* = null;
         var emitAt:* = null;
         var start:* = null;
         var end:* = null;
         var newParams:* = null;
         var _loc8_:* = null;
         assert("Must be a Follower",true,scriptObject is Follower);
         assert("ScriptObject.variables lenght must be 4",true,scriptObject.variables.length == 4);
         var _loc9_:int = int(scriptObject.variables[1]);
         if(_loc9_ != 0)
         {
            newParams = new SimpleScriptParams();
            if(_loc9_ > 0)
            {
               target = params.pgoA;
               emitAt = params.pgoB;
               start = params.pgoBLocation;
               newParams.pgoA = params.pgoB;
               newParams.pgoALocation = params.pgoBLocation;
            }
            else
            {
               target = params.pgoB;
               emitAt = params.pgoA;
               start = params.pgoALocation;
               newParams.pgoA = params.pgoA;
               newParams.pgoALocation = params.pgoALocation;
            }
            if(target && target.bodyLocation && emitAt && emitAt.body)
            {
               if(start)
               {
                  end = target.bodyLocation;
                  _loc8_ = start.sub(end);
                  if(_loc8_.length != 0)
                  {
                     _loc8_.normalise();
                  }
                  _loc8_.length = -_loc9_;
                  var _loc10_:SimpleScriptManager = SimpleScriptManager;
                  if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
                  {
                     new tuxwars.battle.simplescript.SimpleScriptManager();
                  }
                  tuxwars.battle.simplescript.SimpleScriptManager._instance.runWithName(false,"ApplyForce",[scriptObject.variables[2],scriptObject.variables[3],_loc8_.x,_loc8_.y],newParams);
               }
               else
               {
                  LogUtils.log("No start point to apply in script: " + scriptObject.className + " for id: " + scriptObject.id,this,0,"SimpleScript",false,false,false);
               }
            }
            else
            {
               LogUtils.log("Not correct objects to use in script: " + scriptObject.className + " for id: " + scriptObject.id,this,0,"SimpleScript",false,false,false);
            }
         }
         else
         {
            LogUtils.log("No force to apply in script: " + scriptObject.className + " for id: " + scriptObject.id,this,0,"SimpleScript",false,false,false);
         }
         return null;
      }
   }
}
