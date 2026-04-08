package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.simplescript.*;
   
   public class Homing implements SimpleScriptCore
   {
      public function Homing()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc3_:PhysicsGameObject = null;
         var _loc4_:PhysicsGameObject = null;
         var _loc5_:Vec2 = null;
         var _loc6_:Vec2 = null;
         var _loc7_:SimpleScriptParams = null;
         var _loc8_:Vec2 = null;
         assert("Must be a Follower",true,param1 is Follower);
         assert("ScriptObject.variables lenght must be 4",true,param1.variables.length == 4);
         var _loc9_:int = int(param1.variables[1]);
         if(_loc9_ != 0)
         {
            _loc7_ = new SimpleScriptParams();
            if(_loc9_ > 0)
            {
               _loc3_ = param2.pgoA;
               _loc4_ = param2.pgoB;
               _loc5_ = param2.pgoBLocation;
               _loc7_.pgoA = param2.pgoB;
               _loc7_.pgoALocation = param2.pgoBLocation;
            }
            else
            {
               _loc3_ = param2.pgoB;
               _loc4_ = param2.pgoA;
               _loc5_ = param2.pgoALocation;
               _loc7_.pgoA = param2.pgoA;
               _loc7_.pgoALocation = param2.pgoALocation;
            }
            if(_loc3_ && _loc3_.bodyLocation && _loc4_ && Boolean(_loc4_.body))
            {
               if(_loc5_)
               {
                  _loc6_ = _loc3_.bodyLocation;
                  _loc8_ = _loc5_.sub(_loc6_);
                  if(_loc8_.length != 0)
                  {
                     _loc8_.normalise();
                  }
                  _loc8_.length = -_loc9_;
                  if(!SimpleScriptManager.instance)
                  {
                     new SimpleScriptManager();
                  }
                  SimpleScriptManager.instance.runWithName(false,"ApplyForce",[param1.variables[2],param1.variables[3],_loc8_.x,_loc8_.y],_loc7_);
               }
               else
               {
                  LogUtils.log("No start point to apply in script: " + param1.className + " for id: " + param1.id,this,0,"SimpleScript",false,false,false);
               }
            }
            else
            {
               LogUtils.log("Not correct objects to use in script: " + param1.className + " for id: " + param1.id,this,0,"SimpleScript",false,false,false);
            }
         }
         else
         {
            LogUtils.log("No force to apply in script: " + param1.className + " for id: " + param1.id,this,0,"SimpleScript",false,false,false);
         }
         return null;
      }
   }
}

