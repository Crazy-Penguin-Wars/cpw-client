package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.emitters.EmitterUtils;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.missiles.Missile;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class TriggerEmission implements SimpleScriptCore
   {
       
      
      public function TriggerEmission()
      {
         super();
      }
      
      public function run(scriptObject:SimpleScript, params:SimpleScriptParams) : *
      {
         var directionPoint:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc7_:Emission = params.emission;
         var _loc9_:PhysicsGameObject = params.pgoA;
         var _loc8_:PhysicsGameObject = params.pgoB;
         if(_loc9_.disposed || _loc8_.disposed)
         {
            LogUtils.log("GameObject has been disposed, targer: " + _loc9_.disposed + " emitAt: " + _loc8_.disposed,this,1,"SimpleScript",false,false,false);
            return;
         }
         if(_loc9_ == _loc8_)
         {
            if(_loc9_.body && _loc9_.linearVelocity && _loc9_.linearVelocity.length != 0)
            {
               directionPoint = _loc9_.linearVelocity;
            }
            else
            {
               _loc5_ = _loc9_ as Missile;
               if(_loc5_ && _loc5_.lastLinearVelocity && _loc5_.lastLinearVelocity.length != 0)
               {
                  directionPoint = _loc5_.lastLinearVelocity;
               }
               else
               {
                  _loc6_ = _loc9_ as Follower;
                  if(_loc6_ && _loc6_.lastLinearVelocity && _loc6_.lastLinearVelocity.length != 0)
                  {
                     directionPoint = _loc6_.lastLinearVelocity;
                  }
               }
            }
         }
         else if(_loc9_ && _loc9_.bodyLocation && _loc8_ && _loc8_.bodyLocation)
         {
            _loc10_ = _loc8_.bodyLocation;
            _loc11_ = _loc9_.bodyLocation;
            directionPoint = _loc10_.add(_loc11_);
         }
         else
         {
            var _loc13_:* = _loc9_;
            var _loc14_:* = _loc8_;
            LogUtils.log("Target or EmitAt is null or has no body! Target: " + (!!_loc9_ ? _loc9_.shortName : null) + " EmitAt: " + (!!_loc8_ ? _loc8_.shortName : null) + " Target loc: " + _loc9_.bodyLocation + " EmitAt loc: " + _loc8_.bodyLocation + " Target hps: " + _loc13_.cahcedHP + " EmitAt hps: " + _loc14_.cahcedHP,this,2,"SimpleScript",true,true,true);
         }
         if(_loc8_ && _loc8_.bodyLocation)
         {
            _loc7_.location = _loc8_.bodyLocation.copy();
         }
         if(directionPoint == null || directionPoint.length == 0)
         {
            var _loc15_:Config = Config;
            directionPoint = Config.VEC_UP.copy();
         }
         var _loc12_:String = !!(scriptObject.variables[1] as String) ? (scriptObject.variables[1] as String).toLowerCase() : null;
         var _loc3_:Boolean = _loc12_ == "false" ? false : true;
         if(!_loc3_)
         {
            directionPoint = EmitterUtils.convertDirection(directionPoint);
         }
         if(_loc7_.readyToEmit())
         {
            _loc7_.setEmissionsParams("Params",{
               "dir":directionPoint.copy(),
               "powerBar":0
            });
            _loc7_.triggerEmission();
         }
         else
         {
            LogUtils.log("Emission: " + _loc7_.shortName + " not ready to emit",this,0,"SimpleScript",false,false,false);
         }
         if(directionPoint)
         {
            directionPoint.dispose();
         }
         return null;
      }
   }
}
