package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class TriggerEmission implements SimpleScriptCore
   {
      public function TriggerEmission()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:Config = null;
         var _loc3_:Vec2 = null;
         var _loc4_:Missile = null;
         var _loc5_:Follower = null;
         var _loc6_:Vec2 = null;
         var _loc7_:Vec2 = null;
         var _loc8_:Emission = param2.emission;
         var _loc9_:PhysicsGameObject = param2.pgoA;
         var _loc10_:PhysicsGameObject = param2.pgoB;
         if(_loc9_.disposed || _loc10_.disposed)
         {
            LogUtils.log("GameObject has been disposed, targer: " + _loc9_.disposed + " emitAt: " + _loc10_.disposed,this,1,"SimpleScript",false,false,false);
            return;
         }
         if(_loc9_ == _loc10_)
         {
            if(_loc9_.body && _loc9_.linearVelocity && _loc9_.linearVelocity.length != 0)
            {
               _loc3_ = _loc9_.linearVelocity;
            }
            else
            {
               _loc4_ = _loc9_ as Missile;
               if((_loc4_) && _loc4_.lastLinearVelocity && _loc4_.lastLinearVelocity.length != 0)
               {
                  _loc3_ = _loc4_.lastLinearVelocity;
               }
               else
               {
                  _loc5_ = _loc9_ as Follower;
                  if((_loc5_) && _loc5_.lastLinearVelocity && _loc5_.lastLinearVelocity.length != 0)
                  {
                     _loc3_ = _loc5_.lastLinearVelocity;
                  }
               }
            }
         }
         else if(_loc9_ && _loc9_.bodyLocation && _loc10_ && Boolean(_loc10_.bodyLocation))
         {
            _loc6_ = _loc10_.bodyLocation;
            _loc7_ = _loc9_.bodyLocation;
            _loc3_ = _loc6_.add(_loc7_);
         }
         else
         {
            _loc13_ = _loc9_;
            _loc14_ = _loc10_;
            LogUtils.log("Target or EmitAt is null or has no body! Target: " + (!!_loc9_ ? _loc9_.shortName : null) + " EmitAt: " + (!!_loc10_ ? _loc10_.shortName : null) + " Target loc: " + _loc9_.bodyLocation + " EmitAt loc: " + _loc10_.bodyLocation + " Target hps: " + _loc13_.cahcedHP + " EmitAt hps: " + _loc14_.cahcedHP,this,2,"SimpleScript",true,true,true);
         }
         if(Boolean(_loc10_) && Boolean(_loc10_.bodyLocation))
         {
            _loc8_.location = _loc10_.bodyLocation.copy();
         }
         if(_loc3_ == null || _loc3_.length == 0)
         {
            _loc15_ = Config;
            _loc3_ = Config.VEC_UP.copy();
         }
         var _loc11_:String = !!(param1.variables[1] as String) ? (param1.variables[1] as String).toLowerCase() : null;
         var _loc12_:Boolean = _loc11_ == "false" ? false : true;
         if(!_loc12_)
         {
            _loc3_ = EmitterUtils.convertDirection(_loc3_);
         }
         if(_loc8_.readyToEmit())
         {
            _loc8_.setEmissionsParams("Params",{
               "dir":_loc3_.copy(),
               "powerBar":0
            });
            _loc8_.triggerEmission();
         }
         else
         {
            LogUtils.log("Emission: " + _loc8_.shortName + " not ready to emit",this,0,"SimpleScript",false,false,false);
         }
         if(_loc3_)
         {
            _loc3_.dispose();
         }
         return null;
      }
   }
}

