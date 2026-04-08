package tuxwars.battle.simplescript.scripts
{
   import com.dchoc.utils.*;
   import nape.geom.*;
   import no.olog.utilfunctions.*;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   
   public class ApplyForce implements SimpleScriptCore
   {
      public function ApplyForce()
      {
         super();
      }
      
      public function run(param1:SimpleScript, param2:SimpleScriptParams) : *
      {
         var _loc3_:* = false;
         assert("too few variables, needs (name, boolean, boolean, x, y)",true,param1.variables.length >= 5);
         assert("params is not a PhysicsGameObject",true,param2.pgoA is PhysicsGameObject);
         var _loc4_:Vec2 = new Vec2(param1.variables[3],param1.variables[4]);
         var _loc5_:PhysicsGameObject = param2.pgoA;
         if(Boolean(_loc5_.body) && _loc4_.length > 0)
         {
            _loc3_ = StringUtils.trim((param1.variables[2] as String).toLowerCase()) == "true";
            if(_loc3_)
            {
               if(_loc5_ is PlayerGameObject)
               {
                  if((_loc5_ as PlayerGameObject).moveControls.isFallingDown())
                  {
                     this.apply(_loc5_,_loc4_);
                  }
               }
               else if(_loc5_.linearVelocity.y > 0.5)
               {
                  this.apply(_loc5_,_loc4_);
               }
            }
            else
            {
               this.apply(_loc5_,_loc4_);
            }
         }
         return null;
      }
      
      private function apply(param1:PhysicsGameObject, param2:Vec2) : void
      {
         var _loc3_:* = param1;
         LogUtils.log("Applying Impulse: " + param2 + " to: " + param1.shortName + " bodyloc: " + param1.bodyLocation + " world step: " + (_loc3_.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"SimpleScript",false,false,false);
         param1.body.applyImpulse(param2);
      }
   }
}

